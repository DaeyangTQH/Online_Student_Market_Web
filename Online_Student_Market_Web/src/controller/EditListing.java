/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.productDAO;
import DAO.CreateDAO;
import Model.Product;
import java.io.File;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "EditListing", urlPatterns = {"/editlisting"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB mỗi ảnh
        maxRequestSize = 1024 * 1024 * 25     // 25MB tổng cộng
)
public class EditListing extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pidRaw = request.getParameter("pid");
        if (pidRaw != null) {
            try {
                int pid = Integer.parseInt(pidRaw);
                Product product = new productDAO().getProductByID(pid);
                if (product != null) {
                    request.setAttribute("product", product);
                }
            } catch (Exception e) { e.printStackTrace(); }
        }
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/editlisting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("upload".equals(action)) {
            handleImageUpload(request, response);
        } else {
            handleFormSubmission(request, response);
        }
    }

    private void handleImageUpload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String fileName = UUID.randomUUID() + getExtension(filePart.getSubmittedFileName());

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        filePart.write(uploadPath + File.separator + fileName);

        response.setContentType("application/json");
        response.getWriter().write("{\"url\":\"uploads/" + fileName + "\"}");
    }

    private void handleFormSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String pidRaw = request.getParameter("pid");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String stockStr = request.getParameter("stock");
        String uploadedImages = request.getParameter("uploadedImages");
        String[] imageUrls = uploadedImages != null ? uploadedImages.split(",") : new String[0];

        if ("delete".equals(action) && pidRaw != null) {
            try {
                int pid = Integer.parseInt(pidRaw);
                int cid = Integer.parseInt(category); // category_id
                new CreateDAO().deleteProduct(pid);
                // Redirect về trang danh mục sản phẩm
                response.sendRedirect(request.getContextPath() + "/productList?cid=" + cid);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if ("save".equals(action) && pidRaw != null) {
            try {
                int pid = Integer.parseInt(pidRaw);
                int stock = Integer.parseInt(stockStr);
                java.math.BigDecimal priceVal = new java.math.BigDecimal(price);
                int cid = Integer.parseInt(category); // category_id
                String imageUrl = (imageUrls.length > 0) ? imageUrls[0] : null;
                Model.Product product = new Model.Product();
                product.setProduct_id(pid);
                product.setProduct_name(title);
                product.setDescription(description);
                product.setPrice(priceVal);
                product.setSubCategory_id(cid);
                product.setStock_quantity(stock);
                product.setImage_url(imageUrl);
                new CreateDAO().updateProduct(product);
                // Redirect về trang chi tiết sản phẩm
                response.sendRedirect(request.getContextPath() + "/product?pid=" + pid);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("uploadedImages", Arrays.asList(imageUrls));
        request.setAttribute("message", "Cập nhật tin đăng và tải ảnh thành công!");
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/editlisting.jsp").forward(request, response);
    }

    private String getExtension(String filename) {
        return filename.substring(filename.lastIndexOf("."));
    }
}

