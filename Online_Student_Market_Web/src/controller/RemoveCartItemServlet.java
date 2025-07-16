package controller;

import DAO.CartItemDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;


@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {

    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String cartItemIdStr = request.getParameter("cartItemId");

    if (cartItemIdStr != null) {
        try {
            int cartItemId = Integer.parseInt(cartItemIdStr);
            cartItemDAO.deleteCartItemById(cartItemId); // ✅ Xoá trong DB

            // ✅ Cập nhật lại session cart
            HttpSession session = request.getSession();
            Integer cartId = (Integer) session.getAttribute("cartId");
            if (cartId != null) {
                session.setAttribute("cart", cartItemDAO.getCart_ItemsByCartId(cartId));
            }

            session.setAttribute("message", "✅ Đã xoá sản phẩm khỏi giỏ hàng.");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "❌ Lỗi khi xoá sản phẩm.");
        }
    }

    response.sendRedirect(request.getContextPath() + "/cart");
}

}


