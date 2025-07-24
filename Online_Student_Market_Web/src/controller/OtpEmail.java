/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.UserDAO;
import DAO.UserOtpDAO;
import DAO.EmailUtil;
import Model.User;
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
public class OtpEmail extends HttpServlet {

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
            out.println("<title>Servlet OtpEmail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OtpEmail at " + request.getContextPath() + "</h1>");
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
        String email = request.getParameter("email");
        String error = "";

        if (email == null || email.trim().isEmpty()) {
            error = "Email không được để trống";
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmail(email.trim());
        UserOtpDAO otp_dao = new UserOtpDAO();

        if (user != null) {
            try {
                String code_otp = otp_dao.createOtpByUser(user.getUser_id());

                // Gửi email OTP
                EmailUtil.sendOtpEmail(email, code_otp);

                // Lưu email vào session để sử dụng ở POST method
                HttpSession session = request.getSession();
                session.setAttribute("reset_email", email);
                session.setAttribute("user_id", user.getUser_id());

                // Chuyển đến trang nhập OTP
                request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/otp_email.jsp").forward(request, response);

            } catch (Exception e) {
                error = "Có lỗi xảy ra khi gửi email OTP: " + e.getMessage();
                request.setAttribute("error", error);
                request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
            }

        } else {
            error = "Tài khoản chưa được tạo";
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
        }
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
        String otpInput = request.getParameter("otp");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        Integer userId = (Integer) session.getAttribute("user_id");

        String error = "";
        String success = "";

        if (otpInput == null || otpInput.trim().isEmpty()) {
            error = "Vui lòng nhập mã OTP";
        } else if (userId == null) {
            error = "Phiên làm việc đã hết hạn, vui lòng thử lại";
        } else {
            UserOtpDAO otp_dao = new UserOtpDAO();
            boolean isValidOtp = otp_dao.verifyOtp(userId, otpInput.trim());

            if (isValidOtp) {
                // OTP đúng - dừng lại như yêu cầu
                success = "Xác thực OTP thành công!";
                request.setAttribute("success", success);

                // Hiển thị thông báo thành công và dừng lại
                request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/reset_password.jsp").forward(request, response);
            } else {
                error = "Mã OTP không đúng hoặc đã hết hạn";
            }
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/vanhuy/otp_email.jsp").forward(request, response);
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
