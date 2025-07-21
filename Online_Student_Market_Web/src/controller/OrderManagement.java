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
        String action = request.getParameter("action");

        if ("buyNow".equals(action)) {
            handleBuyNow(request, session);
        } else if ("checkout".equals(action)) {
            handleCheckout(request, session);
        }

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

        // Xử lý Buy Now
        String productIdRaw = request.getParameter("productId");
        String quantityRaw = request.getParameter("quantity");

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return; // Not logged in – nothing to do.
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Math.max(1, Integer.parseInt(request.getParameter("quantity")));

            Product product = productDao.getProductByID(productId, new Holder<>());
            if (product != null) {
                new CreateDAO().createOrderForBuyNow(user.getUser_id(), product, quantity);
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

        // Echo form fields back to the page in case of validation errors.
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
