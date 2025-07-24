package controller;

import DAO.CartItemDAO;
import DAO.CartDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("cartItemId");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (productIdStr != null && user != null) {
            try {
                int productId = Integer.parseInt(productIdStr);

                CartDAO cartDAO = new CartDAO();
                int cartId = cartDAO.getCartIdByUserId(user.getUser_id()); // lấy cartId từ userId

                CartItemDAO cartItemDAO = new CartItemDAO();
                cartItemDAO.deleteCartItem(cartId, productId); // xóa dòng tương ứng trong DB

                session.setAttribute("message", "✅ Đã xóa sản phẩm khỏi giỏ hàng.");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "❌ Có lỗi xảy ra khi xoá.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
