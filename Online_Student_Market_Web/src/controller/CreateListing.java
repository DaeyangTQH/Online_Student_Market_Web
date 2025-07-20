package controller;

import DAO.categoryDAO;
import DAO.CreateDAO;
import Model.Category;
import Model.Product;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CreateListing", urlPatterns = {"/createlisting"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 25     // 25MB
)
public class CreateListing extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String cidParam = request.getParameter("cid");
        if (cidParam != null && !cidParam.isBlank()) {
            try {
                int cid = Integer.parseInt(cidParam);
                categoryDAO dao = new categoryDAO();
                Category cat = dao.getCategoryById(cid);
                if (cat != null) {
                    request.setAttribute("categoryName", cat.getCategory_name());
                    request.setAttribute("cid", cid);
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/createlisting.jsp").forward(request, response);
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
        response.setContentType("application/json");
        try {
            Part filePart = request.getPart("file");
            String fileName = UUID.randomUUID() + getExtension(filePart.getSubmittedFileName());

            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);

            String imageUrl = "uploads/" + fileName;
            response.getWriter().write("{\"url\":\"" + imageUrl + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Upload failed: " + e.getMessage().replace("\"", "'") + "\"}");
        }
    }

    private void handleFormSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String uploadedImages = request.getParameter("uploadedImages");
        String[] imageUrls = uploadedImages != null ? uploadedImages.split(",") : new String[0];

        String stockStr = request.getParameter("stock");
        String cidStr = request.getParameter("cid");

        int cid = 0;
        try { cid = Integer.parseInt(cidStr); } catch (Exception e) { }
        int stock = 1;
        try { stock = Integer.parseInt(stockStr); } catch (Exception e) { }
        BigDecimal priceVal = BigDecimal.ZERO;
        try { priceVal = new BigDecimal(price); } catch (Exception e) { }
        String imageUrl = (imageUrls.length > 0) ? imageUrls[0] : null;

        // Lưu vào DB
        Product product = new Product();
        product.setCategory_id(cid);
        product.setProduct_name(title);
        product.setDescription(description);
        product.setPrice(priceVal);
        product.setStock_quantity(stock);
        product.setImage_url(imageUrl);
        CreateDAO dao = new CreateDAO();
        dao.insertProduct(product);

        // Redirect về trang danh mục
        response.sendRedirect(request.getContextPath() + "/productList?cid=" + cid);
    }

    private String getExtension(String filename) {
        return filename.substring(filename.lastIndexOf("."));
    }
}
