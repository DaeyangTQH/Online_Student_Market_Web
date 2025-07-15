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

        // B1: Lấy dữ liệu từ form
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

        // B2: Lấy sản phẩm từ DB
        Product product = dao.getProductByID(productId, new Holder<>());
        if (product == null) {
            response.sendRedirect("productList");
            return;
        }

        // B3: Lấy giỏ hàng từ session
        List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // B4: Kiểm tra sản phẩm đã có trong giỏ chưa
        boolean found = false;
        for (Cart_Item item : cart) {
            if (item.getProduct_id() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        // B5: Nếu chưa có thì thêm mới
        if (!found) {
            Cart_Item newItem = new Cart_Item(
                    0, // cart_item_id
                    0, // cart_id
                    product.getProduct_id(),
                    quantity,
                    product // truyền luôn cả Product
            );
            cart.add(newItem);
        }

        // B6: Cập nhật session và chuyển về cart.jsp
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);

    }
}
