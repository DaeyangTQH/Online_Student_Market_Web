package controller;

import DAO.UserDAO;
import DAO.productDAO;
import DAO.Holder;
import Model.User;
import Model.Product;
import Model.Cart_Item;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("isLoggedIn", true);

            // ✅ Kiểm tra nếu có sản phẩm cần thêm vào giỏ
            String pendingPid = (String) session.getAttribute("pendingProductId");
            String pendingQty = (String) session.getAttribute("pendingQuantity");
            Boolean backToCart = (Boolean) session.getAttribute("redirectBackToCart");

            if (backToCart != null && backToCart && pendingPid != null) {
                try {
                    int productId = Integer.parseInt(pendingPid);
                    int quantity = Integer.parseInt(pendingQty);

                    productDAO dao = new productDAO();
                    Product product = dao.getProductByID(productId, new Holder<>());

                    if (product != null) {
                        List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");
                        if (cart == null) cart = new ArrayList<>();

                        boolean found = false;
                        for (Cart_Item item : cart) {
                            if (item.getProduct().getProduct_id() == productId) {
                                item.setQuantity(item.getQuantity() + quantity);
                                found = true;
                                break;
                            }
                        }

                        if (!found) {
                            Cart_Item newItem = new Cart_Item(
                                productId, 0, productId, quantity, product
                            );
                            cart.add(newItem);
                        }

                        session.setAttribute("cart", cart);
                    }

                } catch (NumberFormatException e) {
                    // ignore
                }

                // ✅ Xoá session tạm
                session.removeAttribute("pendingProductId");
                session.removeAttribute("pendingQuantity");
                session.removeAttribute("redirectBackToCart");

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // ✅ Không có redirect đặc biệt → về home
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu.");
            request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet for SVMarket";
    }
}
