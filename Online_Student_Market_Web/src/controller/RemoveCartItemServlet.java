package controller;

import Model.Cart_Item;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("cartItemId"); // thực chất là productId
        HttpSession session = request.getSession();

        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);

                List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");
                if (cart != null) {
                    cart.removeIf(item -> item.getProduct().getProduct_id() == productId);
                    session.setAttribute("cart", cart);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                session.setAttribute("message", "❌ ID sản phẩm không hợp lệ.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
