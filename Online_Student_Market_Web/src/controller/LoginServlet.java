package controller;

import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.UserDAO;
import DAO.productDAO;
import DAO.Holder;
import Model.Cart;
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("isLoggedIn", true);
            // 👉 Tạo hoặc lấy cart từ DB
            CartDAO cartDAO = new CartDAO();
            Cart cart = cartDAO.getCartByUserId(user.getUser_id());
            if (cart == null) {
                cart = cartDAO.createCartForUser(user.getUser_id());
            }

            // 👉 Lưu cart vào session nếu cần dùng tiếp
            session.setAttribute("userCart", cart);

            // 👉 Thêm sản phẩm chờ xử lý vào DB nếu có
            String pendingPid = (String) session.getAttribute("pendingProductId");
            String pendingQty = (String) session.getAttribute("pendingQuantity");
            Boolean backToCart = (Boolean) session.getAttribute("redirectBackToCart");

            if (backToCart != null && backToCart && pendingPid != null) {
                try {
                    int productId = Integer.parseInt(pendingPid);
                    int quantity = Integer.parseInt(pendingQty);

                    CartItemDAO cartItemDAO = new CartItemDAO();
                    cartItemDAO.addOrUpdateCartItem(cart.getCart_id(), productId, quantity);

                } catch (NumberFormatException e) {
                    // ignore
                }

                session.removeAttribute("pendingProductId");
                session.removeAttribute("pendingQuantity");
                session.removeAttribute("redirectBackToCart");

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

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
