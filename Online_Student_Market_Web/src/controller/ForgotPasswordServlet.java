package controller;

import DAO.UserDAO;
import Model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        UserDAO dao = new UserDAO();
        User user = dao.findByEmail(email);

        if (user != null) {
            boolean updated = dao.updatePasswordByEmail(email, newPassword);
            if (updated) {
                request.setAttribute("message", "Password updated successfully. Please log in.");
            } else {
                request.setAttribute("message", "Failed to update password.");
            }
        } else {
            request.setAttribute("message", "Email not found.");
        }

        request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
    }
}
