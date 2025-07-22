package controller;

import DAO.Holder;
import DAO.productDAO;
import models.Product;
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

        String cidParam = request.getParameter("cid");
        String typeSort = request.getParameter("type");
        String minPrice_raw = request.getParameter("minPrice");
        String maxPrice_raw = request.getParameter("maxPrice");
        String pageParam = request.getParameter("page");

        int cid = 0;
        Double minPrice = null;
        Double maxPrice = null;
        int pageSize = 16;
        int page = 1;

        if (cidParam != null && !cidParam.isBlank()) {
            try {
                cid = Integer.parseInt(cidParam);
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

        List<Product> pageProducts = dao.findProduct(
                cid != 0 ? cid : null,
                minPrice,
                maxPrice,
                typeSort,
                pageSize,
                offset,
                catName
        );

        int totalRecords = dao.countProduct(
                cid != 0 ? cid : null,
                minPrice,
                maxPrice
        );
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        Double minPriceValue = dao.getMinPrice(cid != 0 ? cid : null);
        Double maxPriceValue = dao.getMaxPrice(cid != 0 ? cid : null);

        request.setAttribute("productlist", pageProducts);
        request.setAttribute("categoryName", catName.value);
        request.setAttribute("cid", cid);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("minPriceValue", minPriceValue);
        request.setAttribute("maxPriceValue", maxPriceValue);

        request.getRequestDispatcher("WEB-INF/jsp/Haichan/productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
