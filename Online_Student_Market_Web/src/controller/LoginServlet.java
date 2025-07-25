
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.UserDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author admin
 */
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã đăng nhập thì chuyển về home
        javax.servlet.http.HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user with database
        User user = userDAO.validateUser(username, password);

        if (user != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("isLoggedIn", true);

            // Redirect theo role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/Admin.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Kiểm tra nếu user tồn tại nhưng bị ban
            User checkUser = userDAO.getUserByIdOrUsername(username);
            if (checkUser != null && "banned".equalsIgnoreCase(checkUser.getRole())) {
                request.setAttribute("errorMessage", "Tài khoản đã bị ban. Liên hệ admin để biết thêm thông tin chi tiết.");
            } else {
                request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu.");
            }
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/t_son/login.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet for SVMarket";
    }// </editor-fold>

}
