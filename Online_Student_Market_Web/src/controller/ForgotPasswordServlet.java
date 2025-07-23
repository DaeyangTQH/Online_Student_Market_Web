package controller;

import DAO.UserDAO;
import DAO.UserOtpDAO;
import Model.User;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.IOException;


public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/t_son/forgot-password.jsp").forward(request, response);
    }
}
