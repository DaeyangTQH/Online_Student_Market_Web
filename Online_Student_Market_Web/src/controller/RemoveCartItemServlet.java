package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import Model.Cart_Item;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cartItemIdStr = request.getParameter("cartItemId");

        if (cartItemIdStr != null) {
            try {
                int cartItemId = Integer.parseInt(cartItemIdStr);
                HttpSession session = request.getSession();
                List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");

                if (cart != null) {
                    boolean removed = cart.removeIf(item -> item.getCart_item_id() == cartItemId);
                    System.out.println("Xóa thành công? " + removed);
                    session.setAttribute("cart", cart);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
    }

}
