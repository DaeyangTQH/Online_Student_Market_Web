package controller;

import DAO.cartDAO;
import model.Cart_Item;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp"); // hoặc trang thông báo chưa đăng nhập
            return;
        }
        int userId = (int) session.getAttribute("user_id");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        cartDAO dao = new cartDAO();
        try {
            int cartId = dao.getCartIdByUser(userId);
            dao.addToCart(cartId, productId, quantity);
            response.sendRedirect("cart");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp"); // hoặc trang thông báo chưa đăng nhập
            return;
        }
        int userId = (int) session.getAttribute("user_id");

        cartDAO dao = new cartDAO();
        try {
            List<Cart_Item> cartItems = dao.getCartItemsByUser(userId);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
