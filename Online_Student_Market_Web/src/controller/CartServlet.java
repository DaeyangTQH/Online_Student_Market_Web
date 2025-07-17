package controller;

import DAO.Holder;
import DAO.productDAO;
import Model.Cart_Item;
import Model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartServlet extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        String pid_raw = request.getParameter("productId");
        String quantity_raw = request.getParameter("quantity");

        // ✅ Kiểm tra đăng nhập
        Object user = session.getAttribute("user"); // hoặc "account" tùy theo hệ thống
        if (user == null) {
            // Ghi lại sản phẩm cần thêm sau đăng nhập
            session.setAttribute("message", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng.");
            session.setAttribute("pendingProductId", pid_raw);
            session.setAttribute("pendingQuantity", quantity_raw);
            session.setAttribute("redirectBackToCart", true);

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int productId = 0;
        int quantity = 1;

        try {
            productId = Integer.parseInt(pid_raw);
            quantity = Integer.parseInt(quantity_raw);
            if (quantity < 1) {
                quantity = 1;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("productList");
            return;
        }

        Product product = dao.getProductByID(productId, new Holder<>());
        if (product == null) {
            response.sendRedirect("productList");
            return;
        }

        List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

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
                    productId,
                    0,
                    productId,
                    quantity,
                    product
            );
            cart.add(newItem);
        }

        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
    }
}
