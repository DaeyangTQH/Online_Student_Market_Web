package controller;

import DAO.Holder;
import DAO.SubCategoryDAO;
import DAO.productDAO;
import model.Product;
import model.SubCategory;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductList extends HttpServlet {

    private productDAO dao;

    @Override
    public void init() {
        dao = new productDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subCategoryIdParam = request.getParameter("subCategoryId");
        String typeSort = request.getParameter("type");
        String minPrice_raw = request.getParameter("minPrice");
        String maxPrice_raw = request.getParameter("maxPrice");
        String pageParam = request.getParameter("page");

        int subCategoryId = 0;
        Double minPrice = null;
        Double maxPrice = null;
        int pageSize = 16;
        int page = 1;
        int cid = 0;

        if (subCategoryIdParam != null && !subCategoryIdParam.isBlank()) {
            try {
                subCategoryId = Integer.parseInt(subCategoryIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (minPrice_raw != null && !minPrice_raw.isBlank()) {
            try {
                minPrice = Double.valueOf(minPrice_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (maxPrice_raw != null && !maxPrice_raw.isBlank()) {
            try {
                maxPrice = Double.valueOf(maxPrice_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        int offset = (page - 1) * pageSize;
        Holder<String> catName = new Holder<>();
        String subCategoryName = null;
        List<Product> pageProducts;
        int totalRecords;
        int totalPages;
        Double minPriceValue;
        Double maxPriceValue;

        if (subCategoryId != 0) {
            SubCategoryDAO subDao = new SubCategoryDAO();
            SubCategory sub = subDao.getSubCategoryById(subCategoryId);
            if (sub != null) {
                subCategoryName = sub.getSubCategory_name();
                DAO.categoryDAO catDao = new DAO.categoryDAO();
                model.Category cat = catDao.getCategoryById(sub.getCategory_id());
                if (cat != null) {
                    catName.value = cat.getCategory_name();
                    cid = cat.getCategory_id();
                }
            }
            pageProducts = dao.findProductBySubCategory(subCategoryId, minPrice, maxPrice, typeSort, pageSize, offset);
            totalRecords = dao.countProductBySubCategory(subCategoryId, minPrice, maxPrice);
            totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            minPriceValue = dao.getMinPriceBySubCategory(subCategoryId);
            maxPriceValue = dao.getMaxPriceBySubCategory(subCategoryId);
        } else {
            pageProducts = dao.findProduct(
                    subCategoryId != 0 ? subCategoryId : null,
                    minPrice,
                    maxPrice,
                    typeSort,
                    pageSize,
                    offset,
                    catName
            );
            totalRecords = dao.countProduct(
                    subCategoryId != 0 ? subCategoryId : null,
                    minPrice,
                    maxPrice
            );
            totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            minPriceValue = dao.getMinPrice(subCategoryId != 0 ? subCategoryId : null);
            maxPriceValue = dao.getMaxPrice(subCategoryId != 0 ? subCategoryId : null);
        }

        request.setAttribute("productlist", pageProducts);
        request.setAttribute("categoryName", catName.value);
        request.setAttribute("subCategoryName", subCategoryName);
        request.setAttribute("subCategoryId", subCategoryId);
        request.setAttribute("cid", cid);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("minPriceValue", minPriceValue);
        request.setAttribute("maxPriceValue", maxPriceValue);

        request.getRequestDispatcher("WEB-INF/jsp/Haichan/productList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
