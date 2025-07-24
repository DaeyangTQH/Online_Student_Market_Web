/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.productDAO;
import model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

        if (productID_raw != null && !productID_raw.isBlank()) {
            try {
                productID = Integer.parseInt(productID_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        Product product = dao.getProductByID(productID);
        request.setAttribute("product", product);
        String categoryName = null;
        String subCategoryName = null;
        if (product != null) {
            // Lấy tên subcategory
            DAO.SubCategoryDAO subDao = new DAO.SubCategoryDAO();
            model.SubCategory sub = subDao.getSubCategoryById(product.getSubCategory_id());
            if (sub != null) {
                subCategoryName = sub.getSubCategory_name();
                // Lấy tên category cha
                DAO.categoryDAO catDao = new DAO.categoryDAO();
                model.Category cat = catDao.getCategoryById(sub.getCategory_id());
                if (cat != null) {
                    categoryName = cat.getCategory_name();
                }
            }
        }
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("subCategoryName", subCategoryName);
        
        final int pid = productID;
        // Lấy sản phẩm cùng category
        if (product != null) {
            // Lấy sản phẩm cùng subcategory (trừ sản phẩm hiện tại)
            List<Product> relatedProducts = dao.getProductsBySubCategoryId(product.getSubCategory_id());
            relatedProducts.removeIf(p -> p.getProduct_id() == pid);
            request.setAttribute("relatedProducts", relatedProducts);
            // Lấy sản phẩm đã xem gần đây
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            List<Integer> recentlyViewed = (List<Integer>) session.getAttribute("recentlyViewed");
            if (recentlyViewed == null) {
                recentlyViewed = new ArrayList<>();
            }
            // Thêm sản phẩm hiện tại vào danh sách đã xem (nếu chưa có)
            if (!recentlyViewed.contains(pid)) {
                recentlyViewed.add(0, pid);
                if (recentlyViewed.size() > 10) {
                    recentlyViewed = recentlyViewed.subList(0, 10);
                }
                session.setAttribute("recentlyViewed", recentlyViewed);
            }
            // Lấy sản phẩm đã xem gần đây (trừ sản phẩm hiện tại)
            List<Integer> recentlyViewedForQuery = new ArrayList<>();
            for (Integer id : recentlyViewed) {
                if (id != pid) {
                    recentlyViewedForQuery.add(id);
                }
            }
            List<Product> recentlyViewedProducts;
            if (!recentlyViewedForQuery.isEmpty()) {
                recentlyViewedProducts = dao.getRecentlyViewedProducts(recentlyViewedForQuery, 8);
            } else {
                recentlyViewedProducts = dao.getRandomProducts(8);
            }
            request.setAttribute("recentlyViewedProducts", recentlyViewedProducts);
        }
        
        request.getRequestDispatcher("WEB-INF/jsp/Haichan/productDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
