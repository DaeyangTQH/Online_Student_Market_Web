//package controller;
//
//import DAO.productDAO;
//import DAO.Holder;
//import model.Cart_Item;
//import model.Product;
//
//import javax.servlet.ServletException;
//
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.util.*;
//
//public class CartServlet extends HttpServlet {
//
//    private productDAO dao;
//
//    @Override
//    public void init() {
//        dao = new productDAO();
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(true);
//
//        // Lấy thông tin sản phẩm từ form
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//        // Dùng Holder rỗng để lấy Product (bỏ qua tên category)
//        Holder<String> dummyCatName = new Holder<>();
//        Product p = dao.getProductByID(productId, dummyCatName);
//
////        if (p == null) {
////            response.sendRedirect("error.jsp");
////            return;
////        }
//
//        // Lấy giỏ hàng từ session
//        List<Cart_Item> cart = (List<Cart_Item>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new ArrayList<>();
//        }
//
//        boolean found = false;
//        for (Cart_Item item : cart) {
//            if (item.getProduct_id() == productId) {
//                item.setQuantity(item.getQuantity() + quantity);
//                found = true;
//                break;
//            }
//        }
//
//        if (!found) {
//            Cart_Item newItem = new Cart_Item(
//                    0, // cart_item_id
//                    0, // cart_id
//                    p.getProduct_id(),
//                    quantity,
//                    p.getProduct_name(),
//                    p.getPrice().doubleValue(),
//                    p.getImage_url()
//            );
//            cart.add(newItem);
//        }
//
//        session.setAttribute("cart", cart);
//        response.sendRedirect("cart.jsp");
//    }
//}




 
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author ThuyAnh
 */
public class CartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        request.getRequestDispatcher("/WEB-INF/jsp/th_anh/cart.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        doGet(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}