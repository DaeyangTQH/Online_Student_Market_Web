/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.SubCategoryDAO;
import DAO.categoryDAO;
import model.Category;
import model.SubCategory;
import java.io.IOException;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*")
public class headerDataFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (request.getAttribute("categories") == null) {
            categoryDAO catDao = new categoryDAO();
            SubCategoryDAO subDao = new SubCategoryDAO();
            List<Category> categories = catDao.getAll();
            List<SubCategory> subCategories = subDao.getAllSubCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("subCategories", subCategories);
        }
        chain.doFilter(request, response);
    }
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void destroy() {}
}
