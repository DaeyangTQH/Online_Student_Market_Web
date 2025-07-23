/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ResetPassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/reset_password.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");

        UserDAO dao = new UserDAO();

        String error = "";
        boolean valid = true;

        // Kiểm tra email có tồn tại trong session không
        if (email == null || email.trim().isEmpty()) {
            error = "Phiên làm việc đã hết hạn. Vui lòng thực hiện lại quá trình reset password.";
            valid = false;
        }

        // Kiểm tra password không được trống
        if (valid && (newPass == null || newPass.trim().isEmpty())) {
            error = "Mật khẩu mới không được để trống.";
            valid = false;
        }

        // Kiểm tra confirm password không được trống
        if (valid && (confirmPass == null || confirmPass.trim().isEmpty())) {
            error = "Xác nhận mật khẩu không được để trống.";
            valid = false;
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp nhau không
        if (valid && !newPass.equals(confirmPass)) {
            error = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
            valid = false;
        }

        // Kiểm tra độ dài mật khẩu tối thiểu
        if (valid && newPass.length() < 6) {
            error = "Mật khẩu phải có ít nhất 6 ký tự.";
            valid = false;
        }

        if (valid) {
            // Update password bằng email
            boolean updateSuccess = dao.updatePasswordByEmail(email, newPass);

            if (updateSuccess) {
                // Xóa thông tin session sau khi reset thành công
                session.removeAttribute("reset_email");
                session.removeAttribute("user_id");

                // Redirect về trang login với thông báo thành công
                request.setAttribute("success", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập với mật khẩu mới.");
                request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp").forward(request, response);
            } else {
                error = "Có lỗi xảy ra khi cập nhật mật khẩu. Vui lòng thử lại.";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/reset_password.jsp").forward(request, response);
            }
        } else {
            // Có lỗi validation, quay lại trang reset password với thông báo lỗi
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/reset_password.jsp").forward(request, response);
        }
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
