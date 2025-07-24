package controller;

import DAO.OrderDAO;
import model.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet quản lý đơn hàng cho admin.
 */
public class orderadmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tất cả đơn hàng từ DB
        OrderDAO orderDAO = new OrderDAO();
        // Forward sang trang quản lý đơn hàng cho admin
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/orderManagement.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Có thể xử lý cập nhật trạng thái đơn hàng ở đây nếu cần
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Quản lý đơn hàng cho admin";
    }
}