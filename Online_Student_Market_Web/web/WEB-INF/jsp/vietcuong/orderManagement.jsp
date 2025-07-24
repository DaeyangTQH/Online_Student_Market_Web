<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .container {
            width: 90%;
            margin: 40px auto;
            background: #fff;
            padding: 32px;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(255, 107, 44, 0.08);
        }
        h1 {
            text-align: center;
            color: #222;
            font-weight: 700;
            margin-bottom: 32px;
            letter-spacing: 1px;
            font-size: 2rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }
        th, td {
            border: 1px solid #eee;
            padding: 12px 8px;
            text-align: center;
        }
        th {
            background: #FFF3EA;
            color: #FF6B2C;
        }
        .action-btn {
            background: #FF6B2C;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 6px 14px;
            cursor: pointer;
            font-size: 15px;
            margin: 0 2px;
        }
        .action-btn:hover {
            background: #e65c1a;
        }
        .back-link {
            display: inline-block;
            margin-top: 18px;
            color: #FF6B2C;
            text-decoration: none;
            font-weight: 500;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quản lý Đơn hàng</h1>
        <table>
            <tr>
                <th>ID Đơn</th>
                <th>Người đặt</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.order_id}</td>
                    <td>${order.user_name}</td>
                    <td>${order.order_date}</td>
                    <td>${order.total_amount}</td>
                    <td>${order.status}</td>
                    <td>
                        <!-- Ví dụ: Xem chi tiết hoặc cập nhật trạng thái -->
                        <form action="adminorder" method="get" style="display:inline;">
                            <input type="hidden" name="orderId" value="${order.order_id}" />
                            <button type="submit" class="action-btn">Xem chi tiết</button>
                        </form>
                        <!-- Có thể thêm nút cập nhật trạng thái nếu cần -->
                    </td>
                </tr>
            </c:forEach>
        </table>
        <a href="<c:url value='/admin'/>" class="back-link">Quay lại Dashboard</a>
    </div>
</body>
</html>