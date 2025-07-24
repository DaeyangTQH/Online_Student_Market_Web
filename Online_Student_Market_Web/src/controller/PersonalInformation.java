/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.CartItemDAO;
import DAO.productDAO;
import model.Cart_Item;
import model.Product;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class PersonalInformation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PersonalInformation</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PersonalInformation at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để tiếp tục mua hàng.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/personalInformation.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để tiếp tục mua hàng.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("Buy Now".equals(action)) {
            // Xử lý Buy Now từ product detail
            String productIdRaw = request.getParameter("productId");
            String quantityRaw = request.getParameter("quantity");

            if (productIdRaw != null && quantityRaw != null) {
                try {
                    int productId = Integer.parseInt(productIdRaw);
                    int quantity = Integer.parseInt(quantityRaw);

                    // Lấy thông tin sản phẩm
                    productDAO productDao = new productDAO();
                    Product product = productDao.getProductByID(productId);

                    if (product != null) {
                        // Lưu thông tin Buy Now vào session
                        session.setAttribute("buyNowProduct", product);
                        session.setAttribute("buyNowQuantity", quantity);
                        session.setAttribute("orderType", "BUY_NOW");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Xử lý Checkout từ cart
            Integer cartId = (Integer) session.getAttribute("cartId");
            if (cartId != null) {
                CartItemDAO cartItemDAO = new CartItemDAO();
                List<Cart_Item> cartItems = cartItemDAO.getCart_ItemsByCartId(cartId);

                if (cartItems != null && !cartItems.isEmpty()) {
                    // Lưu thông tin Checkout vào session
                    session.setAttribute("checkoutCartItems", cartItems);
                    session.setAttribute("orderType", "CHECKOUT");
                }
            }
        }

        doGet(request, response);
    }


}
