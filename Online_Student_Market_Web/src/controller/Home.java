/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.categoryDAO;
import DAO.productDAO;
import models.Category;
import models.Product;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class Home extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        productDAO productDao = new productDAO();
        categoryDAO categoryDao = new categoryDAO();
        
        // Lấy tất cả categories
        List<Category> categories = categoryDao.getAll();
        
        // Lấy sản phẩm nổi bật từ mỗi category (tối đa 4 sản phẩm mỗi category)
        Map<Integer, List<Product>> featuredProductsByCategory = new HashMap<>();
        if (categories != null) {
            for (Category category : categories) {
                if (category != null) {
                    List<Product> products = productDao.getProductsByCategory(category.getCategory_id(), 4);
                    if (products != null && !products.isEmpty()) {
                        featuredProductsByCategory.put(category.getCategory_id(), products);
                    }
                }
            }
        }
        
        List<Product> featuredProducts = productDao.getRandomProducts(6); // hoặc lấy theo logic bạn muốn
        request.setAttribute("featuredProducts", featuredProducts);
        
        request.setAttribute("categories", categories);
        request.setAttribute("featuredProductsByCategory", featuredProductsByCategory);
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/home.jsp").forward(request, response);
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Home Servlet for SVMarket";
    }// </editor-fold>

}
