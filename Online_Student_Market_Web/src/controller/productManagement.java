/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.categoryDAO;
import DAO.productDAO;
import Model.Category;
import Model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "productManagement", urlPatterns = {"/productManagement"})
public class productManagement extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        categoryDAO catDao = new categoryDAO();
        List<Category> categories = catDao.getAll();
        String categoryIdStr = request.getParameter("categoryId");
        List<Product> products;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                products = dao.getProductsByCategory(categoryId, 1000); // lấy tối đa 1000 sản phẩm trong category
            } catch (NumberFormatException e) {
                products = dao.getAllProducts();
            }
        } else {
            products = dao.getAllProducts();
        }
        request.setAttribute("categories", categories);
        request.setAttribute("products", products);
        request.setAttribute("selectedCategoryId", categoryIdStr);
        request.getRequestDispatcher("WEB-INF/jsp/vietcuong/productManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String categoryIdStr = request.getParameter("categoryId");
            String name = request.getParameter("productName");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String stockQuantityStr = request.getParameter("stockQuantity");
            String imageUrl = request.getParameter("imageUrl");
            if (categoryIdStr != null && name != null && description != null && priceStr != null && stockQuantityStr != null && imageUrl != null) {
                try {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    java.math.BigDecimal price = new java.math.BigDecimal(priceStr);
                    int stockQuantity = Integer.parseInt(stockQuantityStr);
                    dao.addProduct(categoryId, name.trim(), description.trim(), price, stockQuantity, imageUrl.trim());
                } catch (NumberFormatException e) {
                    // Xử lý lỗi nếu cần
                }
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("productId");
            if (id != null) {
                dao.deleteProduct(Integer.parseInt(id));
            }
        } else if ("edit".equals(action)) {
            String id = request.getParameter("productId");
            String newCategoryIdStr = request.getParameter("newCategoryId");
            String newName = request.getParameter("newName");
            String newDescription = request.getParameter("newDescription");
            String newPriceStr = request.getParameter("newPrice");
            String newStockQuantityStr = request.getParameter("newStockQuantity");
            String newImageUrl = request.getParameter("newImageUrl");
            if (id != null && newCategoryIdStr != null && newName != null && newDescription != null && newPriceStr != null && newStockQuantityStr != null && newImageUrl != null) {
                try {
                    int productId = Integer.parseInt(id);
                    int newCategoryId = Integer.parseInt(newCategoryIdStr);
                    java.math.BigDecimal newPrice = new java.math.BigDecimal(newPriceStr);
                    int newStockQuantity = Integer.parseInt(newStockQuantityStr);
                    dao.updateProduct(productId, newCategoryId, newName.trim(), newDescription.trim(), newPrice, newStockQuantity, newImageUrl.trim());
                } catch (NumberFormatException e) {
                    // Xử lý lỗi nếu cần
                }
            }
        }
        response.sendRedirect("productManagement");
    }
}
