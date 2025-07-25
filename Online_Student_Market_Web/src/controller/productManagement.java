/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.categoryDAO;
import DAO.productDAO;
import model.Category;
import model.Product;
import model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "productManagement", urlPatterns = { "/productManagement" })
public class productManagement extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        if (user == null) {
            request.setAttribute("errorMessage", "Bạn cần đăng nhập để truy cập trang này!");
            request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp").forward(request, response);
            return;
        }
        if (user.getRole() == null || !user.getRole().equalsIgnoreCase("admin")) {
            request.setAttribute("errorMessage", "Bạn không có quyền truy cập trang này!");
            request.getRequestDispatcher("/WEB-INF/jsp/common/no_permission.jsp").forward(request, response);
            return;
        }
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
        String message = "";
        
        try {
            if ("add".equals(action)) {
                message = addProduct(request);
            } else if ("delete".equals(action)) {
                message = deleteProduct(request);
            } else if ("edit".equals(action)) {
                message = updateProduct(request);
            }
        } catch (Exception e) {
            message = "Có lỗi xảy ra: " + e.getMessage();
        }
        
        if (!message.isEmpty()) {
            request.getSession().setAttribute("message", message);
        }
        response.sendRedirect("productManagement");
    }
    
    private String addProduct(HttpServletRequest request) {
        String categoryIdStr = request.getParameter("categoryId");
        String name = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String imageUrl = request.getParameter("imageUrl");
        
        if (categoryIdStr == null || name == null || description == null || 
            priceStr == null || stockQuantityStr == null || imageUrl == null ||
            name.trim().isEmpty() || description.trim().isEmpty() || imageUrl.trim().isEmpty()) {
            return "Vui lòng điền đầy đủ thông tin sản phẩm!";
        }
        
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            java.math.BigDecimal price = new java.math.BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            if (price.compareTo(java.math.BigDecimal.ZERO) <= 0) {
                return "Giá sản phẩm phải lớn hơn 0!";
            }
            if (stockQuantity < 0) {
                return "Số lượng không được âm!";
            }
            
            dao.addProduct(categoryId, name.trim(), description.trim(), price, stockQuantity, imageUrl.trim());
            return "Thêm sản phẩm thành công!";
        } catch (NumberFormatException e) {
            return "Dữ liệu không hợp lệ! Vui lòng kiểm tra giá và số lượng.";
        }
    }
    
    private String deleteProduct(HttpServletRequest request) {
        String id = request.getParameter("productId");
        if (id == null || id.trim().isEmpty()) {
            return "ID sản phẩm không hợp lệ!";
        }
        
        try {
            dao.deleteProduct(Integer.parseInt(id));
            return "Xóa sản phẩm thành công!";
        } catch (NumberFormatException e) {
            return "ID sản phẩm không hợp lệ!";
        }
    }
    
    private String updateProduct(HttpServletRequest request) {
        String id = request.getParameter("productId");
        String newCategoryIdStr = request.getParameter("newCategoryId");
        String newName = request.getParameter("newName");
        String newDescription = request.getParameter("newDescription");
        String newPriceStr = request.getParameter("newPrice");
        String newStockQuantityStr = request.getParameter("newStockQuantity");
        String newImageUrl = request.getParameter("newImageUrl");
        
        if (id == null || newCategoryIdStr == null || newName == null || newDescription == null ||
            newPriceStr == null || newStockQuantityStr == null || newImageUrl == null ||
            newName.trim().isEmpty() || newDescription.trim().isEmpty() || newImageUrl.trim().isEmpty()) {
            return "Vui lòng điền đầy đủ thông tin sản phẩm!";
        }
        
        try {
            int productId = Integer.parseInt(id);
            int newCategoryId = Integer.parseInt(newCategoryIdStr);
            java.math.BigDecimal newPrice = new java.math.BigDecimal(newPriceStr);
            int newStockQuantity = Integer.parseInt(newStockQuantityStr);
            
            if (newPrice.compareTo(java.math.BigDecimal.ZERO) <= 0) {
                return "Giá sản phẩm phải lớn hơn 0!";
            }
            if (newStockQuantity < 0) {
                return "Số lượng không được âm!";
            }
            
            dao.updateProduct(productId, newCategoryId, newName.trim(), newDescription.trim(), 
                            newPrice, newStockQuantity, newImageUrl.trim());
            return "Cập nhật sản phẩm thành công!";
        } catch (NumberFormatException e) {
            return "Dữ liệu không hợp lệ! Vui lòng kiểm tra giá và số lượng.";
        }
    }
}
