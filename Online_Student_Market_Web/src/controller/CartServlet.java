package controller;

import DAO.CartItemDAO;
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

    HttpSession session = request.getSession();
    Integer cartId = (Integer) session.getAttribute("cartId");

    if (cartId != null) {
        CartItemDAO cartItemDAO = new CartItemDAO();
        List<Cart_Item> cartItems = cartItemDAO.getCart_ItemsByCartId(cartId);
        session.setAttribute("cart", cartItems);
    }

    request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
}


    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(true);

    String pid_raw = request.getParameter("productId");
    String quantity_raw = request.getParameter("quantity");

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

    Integer cartId = (Integer) session.getAttribute("cartId");
    if (cartId == null) {
        // nếu chưa có cartId (lần đầu), thì bạn cần tạo cart trong DB hoặc xử lý thêm logic
        response.sendRedirect("productList");
        return;
    }

    // ✅ Thêm vào bảng cart_item trong DB
    CartItemDAO cartItemDAO = new CartItemDAO();
    cartItemDAO.addOrUpdateCartItem(cartId, productId, quantity); // <- bạn cần hàm này (đưa dưới)

    // ✅ Load lại cart từ DB
    List<Cart_Item> cart = cartItemDAO.getCart_ItemsByCartId(cartId);
    session.setAttribute("cart", cart);

    request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
}

}
