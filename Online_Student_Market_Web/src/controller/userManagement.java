/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Haichann
 */
@WebServlet(name="userManagement", urlPatterns={"/userManagement"})
public class userManagement extends HttpServlet {
   
    private UserDAO dao;
    
    @Override
    public void init() {
        dao = new UserDAO();
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
        List<User> users = dao.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/userManagement.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String action = request.getParameter("action");
        if (userId != null && action != null) {
            if (action.equals("ban")) {
                dao.banUser(Integer.parseInt(userId));
            } else if (action.equals("unban")) {
                dao.unbanUser(Integer.parseInt(userId));
            }
        }
        response.sendRedirect("userManagement");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
