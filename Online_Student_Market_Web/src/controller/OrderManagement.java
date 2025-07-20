/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.CreateDAO;
import Model.User;
import Model.Product;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 *
 * @author Admin
 */
public class OrderManagement extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderManagement</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManagement at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/ordermanagement.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Xử lý Buy Now
        String productIdRaw = request.getParameter("productId");
        String quantityRaw = request.getParameter("quantity");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (productIdRaw != null && quantityRaw != null && user != null) {
            try {
                int productId = Integer.parseInt(productIdRaw);
                int quantity = Integer.parseInt(quantityRaw);
                if (quantity < 1) quantity = 1;
                // Lấy thông tin sản phẩm
                Product product = new DAO.productDAO().getProductByID(productId, new DAO.Holder<>());
                if (product != null) {
                    // Tạo đơn hàng mới
                    CreateDAO dao = new CreateDAO();
                    dao.createOrderForBuyNow(user.getUser_id(), product, quantity);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Forward về trang quản lý đơn hàng
        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/ordermanagement.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
