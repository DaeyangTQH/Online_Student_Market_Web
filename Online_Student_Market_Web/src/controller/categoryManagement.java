/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.categoryDAO;
import Model.Category;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            String description = request.getParameter("categoryDescription");
            String imageUrl = request.getParameter("categoryImageUrl");
            if (name != null && description != null && imageUrl != null && !name.trim().isEmpty()) {
                dao.addCategory(name.trim(), description.trim(), imageUrl.trim());
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("categoryId");
            if (id != null) {
                dao.deleteCategory(Integer.parseInt(id));
            }
        } else if ("edit".equals(action)) {
            String id = request.getParameter("categoryId");
            String newName = request.getParameter("newName");
            String newDescription = request.getParameter("newDescription");
            String newImageUrl = request.getParameter("newImageUrl");
            if (id != null && newName != null && newDescription != null && newImageUrl != null && !newName.trim().isEmpty()) {
                dao.updateCategory(Integer.parseInt(id), newName.trim(), newDescription.trim(), newImageUrl.trim());
            }
        }
        response.sendRedirect("categoryManagement");
    }
}
