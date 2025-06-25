/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.Holder;
import DAO.productDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;

/**
 *
 * @author Haichann
 */
public class ProductList extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cidParam = request.getParameter("cid");
        String typeSort = request.getParameter("type");
        String minPrice_raw = request.getParameter("minPrice");
        String maxPrice_raw = request.getParameter("maxPrice");

        int cid = 0;
        double minPrice = Double.MIN_VALUE;
        double maxPrice = Double.MAX_VALUE;
        List<Product> pageProducts = new ArrayList<>();
        Holder<String> catName = new Holder<>();

        if (cidParam != null && !cidParam.isBlank()) {
            try {
                cid = Integer.parseInt(cidParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        List<Product> allProducts = dao.getProductByCategoryID(cid, catName);
        
        int pageSize = 15;
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalProducts);

        if (maxPrice_raw != null && !maxPrice_raw.isBlank() && minPrice_raw != null && !minPrice_raw.isBlank()) {
            try {
                minPrice = Double.parseDouble(minPrice_raw);
                maxPrice = Double.parseDouble(maxPrice_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            List<Product> sortedProduct = dao.getProductBySort(typeSort, minPrice, maxPrice);
            pageProducts = sortedProduct;
        } else {
            pageProducts = allProducts.subList(start, end);
        }

        request.setAttribute("productlist", pageProducts);
        request.setAttribute("categoryName", catName.value);
        request.setAttribute("cid", cid);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("WEB-INF/jsp/Haichan/productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
