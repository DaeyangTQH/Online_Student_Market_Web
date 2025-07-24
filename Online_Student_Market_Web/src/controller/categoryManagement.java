/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.categoryDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Category;
import model.User;

@WebServlet(name = "categoryManagement", urlPatterns = {"/categoryManagement"})
public class categoryManagement extends HttpServlet {

    private categoryDAO dao;

    @Override
    public void init() {
        dao = new categoryDAO();
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
        List<Category> categories = dao.getAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("WEB-INF/jsp/vietcuong/categoryManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("categoryName");
            String imageUrl = request.getParameter("categoryImageUrl");
            if (name != null && imageUrl != null && !name.trim().isEmpty()) {
                dao.addCategory(name.trim(), imageUrl.trim());
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("categoryId");
            if (id != null) {
                dao.deleteCategory(Integer.parseInt(id));
            }
        } else if ("edit".equals(action)) {
            String id = request.getParameter("categoryId");
            String newName = request.getParameter("newName");
            String newImageUrl = request.getParameter("newImageUrl");
            if (id != null && newName != null && newImageUrl != null && !newName.trim().isEmpty()) {
                dao.updateCategory(Integer.parseInt(id), newName.trim(), newImageUrl.trim());
            }
        }
        response.sendRedirect("categoryManagement");
    }
}
