package controller;

import DAO.CartItemDAO;
import DAO.CreateDAO;
import DAO.Holder;
import DAO.OrderDAO;
import DAO.productDAO;
import model.Cart_Item;
import model.Order;
import model.Product;
import model.User;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

                if (user != null) {
            // Lấy danh sách đơn hàng của user
            OrderDAO orderDAO = new OrderDAO();
            List<Order> allOrders = orderDAO.getOrdersByUserId(user.getUser_id());
            
            // Lấy thông tin sản phẩm cho từng đơn hàng
            Map<Integer, List<OrderDAO.OrderItemWithProduct>> orderItemsMap = new HashMap<>();
            System.out.println("DEBUG: Total orders found: " + allOrders.size());
            for (Order order : allOrders) {
                List<OrderDAO.OrderItemWithProduct> items = orderDAO.getOrderItemsWithProductInfo(order.getOrder_id());
                System.out.println("DEBUG: Order " + order.getOrder_id() + " has " + items.size() + " items");
                orderItemsMap.put(order.getOrder_id(), items);
            }
            
            request.setAttribute("allOrders", allOrders);
            request.setAttribute("orderItemsMap", orderItemsMap);
            
            // Phân loại đơn hàng theo status
            List<Order> pendingOrders = allOrders.stream()
                    .filter(order -> "PROCESSING".equals(order.getStatus()))
                    .collect(java.util.stream.Collectors.toList());
            
            List<Order> shippingOrders = allOrders.stream()
                    .filter(order -> "SHIPPING".equals(order.getStatus()))
                    .collect(java.util.stream.Collectors.toList());
                    
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("shippingOrders", shippingOrders);
        }

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
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("Checkout".equals(action)) {
            // Xử lý form từ personalInformation.jsp
            handleFormSubmission(request, session, user);
        }

        // Redirect to GET để tránh resubmit
        response.sendRedirect(request.getContextPath() + "/ordermanagement");
    }

    // ---------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------
    /**
     * Xử lý form submission từ personalInformation.jsp
     */
    private void handleFormSubmission(HttpServletRequest request, HttpSession session, User user) {
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        // Validate form data
        if (fullName == null || fullName.trim().isEmpty() ||
                shippingAddress == null || shippingAddress.trim().isEmpty() ||
                paymentMethod == null || paymentMethod.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin.");
            return;
        }

        CreateDAO createDAO = new CreateDAO();
        String orderType = (String) session.getAttribute("orderType");

        try {
            if ("BUY_NOW".equals(orderType)) {
                // Xử lý Buy Now
                Product product = (Product) session.getAttribute("buyNowProduct");
                Integer quantity = (Integer) session.getAttribute("buyNowQuantity");

                if (product != null && quantity != null) {
                    createDAO.createOrderForBuyNow(user.getUser_id(), product, quantity, paymentMethod,
                            shippingAddress);
                    session.setAttribute("successMessage", "Đặt hàng thành công!");

                    // Clear session data
                    session.removeAttribute("buyNowProduct");
                    session.removeAttribute("buyNowQuantity");
                    session.removeAttribute("orderType");
                }

            } else if ("CHECKOUT".equals(orderType)) {
                // Xử lý Checkout từ cart
                @SuppressWarnings("unchecked")
                List<Cart_Item> cartItems = (List<Cart_Item>) session.getAttribute("checkoutCartItems");
                Integer cartId = (Integer) session.getAttribute("cartId");

                if (cartItems != null && !cartItems.isEmpty() && cartId != null) {
                    createDAO.createOrderFromCart(user.getUser_id(), cartItems, paymentMethod, shippingAddress, cartId);
                    session.setAttribute("successMessage", "Đặt hàng thành công!");

                    // Clear session data
                    session.removeAttribute("checkoutCartItems");
                    session.removeAttribute("cartId");
                    session.removeAttribute("orderType");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles order management actions such as checkout and Buy Now.";
    }

}
