package controller;

import DAO.SubCategoryDAO;
import DAO.categoryDAO;
import model.SubCategory;
import model.Category;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class subCategory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        categoryDAO catDao = new categoryDAO();
        List<Category> categories = catDao.getAll();
        request.setAttribute("categories", categories);

        String categoryIdRaw = request.getParameter("categoryId");
        List<SubCategory> subCategories;
        if (categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdRaw);
                subCategories = new SubCategoryDAO().getSubCategoriesByCategoryId(categoryId);
                request.setAttribute("selectedCategoryId", categoryId);
            } catch (NumberFormatException e) {
                subCategories = new SubCategoryDAO().getAllSubCategories();
            }
        } else {
            subCategories = new SubCategoryDAO().getAllSubCategories();
        }
        request.setAttribute("subCategories", subCategories);
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/subCategory.jsp").forward(request, response);
    }
}