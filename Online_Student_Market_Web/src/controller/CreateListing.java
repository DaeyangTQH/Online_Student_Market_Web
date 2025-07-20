package controller;

import java.io.File;
import java.io.IOException;
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
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/createlisting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        // TODO: lưu vào DB nếu cần

        request.setAttribute("uploadedImages", Arrays.asList(imageUrls));
        request.setAttribute("message", "Tạo tin đăng mới và tải ảnh thành công!");
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/createlisting.jsp").forward(request, response);
    }

    private String getExtension(String filename) {
        return filename.substring(filename.lastIndexOf("."));
    }
}
