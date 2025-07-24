package controller;

import DAO.OrderDAO;
import DAO.UserDAO;
import DAO.OrderDAO.OrderWithUser;
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

        // Lấy tất cả đơn hàng từ DB kèm thông tin user
        OrderDAO orderDAO = new OrderDAO();
        List<OrderWithUser> orders = orderDAO.getAllOrdersWithUserInfo();

        // Truyền danh sách orders vào JSP
        request.setAttribute("orders", orders);

        // Forward sang trang quản lý đơn hàng cho admin
        request.getRequestDispatcher("/WEB-INF/jsp/vietcuong/orderManagement.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateToShipping".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.updateOrderStatusToShippingByOrderId(orderId);

            if (success) {
                request.setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật trạng thái đơn hàng.");
            }
        }

        // Redirect về trang quản lý đơn hàng
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Quản lý đơn hàng cho admin";
    }
}