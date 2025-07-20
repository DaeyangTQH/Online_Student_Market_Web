package controller;

import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.Holder;
import DAO.productDAO;
import Model.Cart;
import Model.Cart_Item;
import Model.Product;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CartServlet extends HttpServlet {

    private productDAO productDao;

    @Override
    public void init() throws ServletException {
        productDao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer cartId = (Integer) session.getAttribute("cartId");

        if (cartId != null) {
            CartItemDAO cartItemDAO = new CartItemDAO();
            List<Cart_Item> cartItems = cartItemDAO.getCart_ItemsByCartId(cartId);
            request.setAttribute("cartItems", cartItems); // dùng request chứ không phải session
        }

        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        String pid_raw = request.getParameter("productId");
        String quantity_raw = request.getParameter("quantity");

        if (user == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng.");
            session.setAttribute("pendingProductId", pid_raw);
            session.setAttribute("pendingQuantity", quantity_raw);
            session.setAttribute("redirectBackToCart", true);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(pid_raw);
            int quantity = Integer.parseInt(quantity_raw);
            if (quantity < 1) quantity = 1;

            Product product = productDao.getProductByID(productId, new Holder<>());
            if (product == null) {
                response.sendRedirect("productList");
                return;
            }

            CartDAO cartDAO = new CartDAO();
            CartItemDAO cartItemDAO = new CartItemDAO();

            Cart cart = cartDAO.getCartByUserId(user.getUser_id());
            if (cart == null) {
                cart = cartDAO.createCartForUser(user.getUser_id());
            }

            // 💥 CẦN lưu cartId vào session để lần sau GET sẽ lấy đúng
            session.setAttribute("cartId", cart.getCart_id());

            // thêm hoặc cập nhật sản phẩm
            cartItemDAO.addOrUpdateCartItem(cart.getCart_id(), productId, quantity);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
