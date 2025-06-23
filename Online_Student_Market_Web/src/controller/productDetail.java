/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.Holder;
import DAO.productDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;

/**
 *
 * @author Haichann
 */
public class productDetail extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID_raw = request.getParameter("pid");
        int productID = 0;
        Holder<String> catName = new Holder<>();

        if (productID_raw != null && !productID_raw.isBlank()) {
            try {
                productID = Integer.parseInt(productID_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        Product product = dao.getProductByID(productID, catName);
        request.setAttribute("product", product);
        request.setAttribute("categoryName", catName.value);
        request.getRequestDispatcher("WEB-INF/jsp/Haichan/productDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
