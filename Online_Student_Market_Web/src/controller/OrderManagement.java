package controller;

import DAO.CartItemDAO;
import DAO.CreateDAO;
import DAO.Holder;
import DAO.productDAO;
import Model.Cart_Item;
import Model.Product;
import Model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet responsible for handling checkout flow and "Buy Now" actions.
 */
public class OrderManagement extends HttpServlet {

    private final productDAO productDao = new productDAO();

    // ---------------------------------------------------------------------
    // GET
    // ---------------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/ordermanagement.jsp")
                .forward(request, response);
    }

    // ---------------------------------------------------------------------
    // POST
    // ---------------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);

        // Get action from form submission (from personalInformation.jsp)
        String action = request.getParameter("action");

        if (action == null) {
            // Get action from session (stored by PersonalInformation servlet)
            action = (String) session.getAttribute("checkoutAction");
        }

        if ("Buy Now".equals(action)) {
            handleBuyNow(request, session);
        } else if ("Checkout".equals(action)) {
            handleCheckout(request, session);
        }

        // Clear temporary session data
        session.removeAttribute("checkoutAction");
        session.removeAttribute("buyNowProductId");
        session.removeAttribute("buyNowQuantity");

        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/ordermanagement.jsp")
                .forward(request, response);
    }

    // ---------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------
    /**
     * Creates an order for the current user immediately ("Buy Now").
     */
    private void handleBuyNow(HttpServletRequest request, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return; // Not logged in – nothing to do.
        }

        try {
            // Get product info from session (stored by PersonalInformation servlet)
            String productIdRaw = (String) session.getAttribute("buyNowProductId");
            String quantityRaw = (String) session.getAttribute("buyNowQuantity");

            if (productIdRaw == null || quantityRaw == null) {
                // Fallback: try to get from request parameters
                productIdRaw = request.getParameter("productId");
                quantityRaw = request.getParameter("quantity");
            }

            if (productIdRaw == null || quantityRaw == null) {
                return; // No product info available
            }

            int productId = Integer.parseInt(productIdRaw);
            int quantity = Math.max(1, Integer.parseInt(quantityRaw));

            Product product = productDao.getProductByID(productId, new Holder<>());
            if (product != null) {
                new CreateDAO().createOrderForBuyNow(user.getUser_id(), product, quantity);

                // Store product info for display
                request.setAttribute("orderProduct", product);
                request.setAttribute("orderQuantity", quantity);
                request.setAttribute("orderType", "buyNow");
            }
        } catch (NumberFormatException ex) {
            ex.printStackTrace(); // TODO: replace with proper logging
        }
    }

    /**
     * Prepares data for the checkout confirmation page.
     */
    private void handleCheckout(HttpServletRequest request, HttpSession session) {
        Integer cartId = (Integer) session.getAttribute("cartId");
        if (cartId == null) {
            return;
        }

        CartItemDAO cartItemDAO = new CartItemDAO();
        List<Cart_Item> cartItems = cartItemDAO.getCart_ItemsByCartId(cartId);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("orderType", "checkout");

        // Process the actual checkout (create order from cart)
        User user = (User) session.getAttribute("user");
        if (user != null && !cartItems.isEmpty()) {
            try {
                new CreateDAO().createOrderFromCart(user.getUser_id(), cartItems);

                // Clear cart after successful order
                cartItemDAO.clearCart(cartId);
            } catch (Exception ex) {
                ex.printStackTrace(); // TODO: replace with proper logging
            }
        }

        // Echo form fields back to the page for display
        request.setAttribute("fullName", request.getParameter("fullName"));
        request.setAttribute("phoneNumber", request.getParameter("phoneNumber"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("shippingAddress", request.getParameter("shippingAddress"));
        request.setAttribute("paymentMethod", request.getParameter("paymentMethod"));
    }

    @Override
    public String getServletInfo() {
        return "Handles order management actions such as checkout and Buy Now.";
    }

}
