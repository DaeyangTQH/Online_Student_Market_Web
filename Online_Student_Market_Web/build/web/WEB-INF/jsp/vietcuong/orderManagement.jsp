<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
    uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
        uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <!DOCTYPE html>
        <html>
            <head>
                <title>Quản lý Đơn hàng</title>
                <link
                    rel="stylesheet"
                    href="${pageContext.request.contextPath}/resources/css/main.css"
                    />
                <style>
                    .container {
                        width: 95%;
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
                    th,
                    td {
                        border: 1px solid #eee;
                        padding: 12px 8px;
                        text-align: center;
                        font-size: 14px;
                    }
                    th {
                        background: #fff3ea;
                        color: #ff6b2c;
                        font-weight: 600;
                    }
                    .action-btn {
                        background: #ff6b2c;
                        color: #fff;
                        border: none;
                        border-radius: 8px;
                        padding: 6px 14px;
                        cursor: pointer;
                        font-size: 13px;
                        margin: 0 2px;
                    }
                    .action-btn:hover {
                        background: #e65c1a;
                    }
                    .back-link {
                        display: inline-block;
                        margin-top: 18px;
                        color: #ff6b2c;
                        text-decoration: none;
                        font-weight: 500;
                    }
                    .back-link:hover {
                        text-decoration: underline;
                    }
                    .status-processing {
                        color: #f39c12;
                        font-weight: bold;
                    }
                    .status-confirmed {
                        color: #27ae60;
                        font-weight: bold;
                    }
                    .status-shipped {
                        color: #3498db;
                        font-weight: bold;
                    }
                    .status-delivered {
                        color: #2ecc71;
                        font-weight: bold;
                    }
                    .status-cancelled {
                        color: #e74c3c;
                        font-weight: bold;
                    }
                    .user-info {
                        font-weight: 500;
                        color: #333;
                    }
                    .email {
                        font-size: 12px;
                        color: #666;
                    }
                    .currency {
                        color: #27ae60;
                        font-weight: 600;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Quản lý Đơn hàng</h1>

                    <!-- Hiển thị thông báo thành công -->
                    <c:if test="${not empty message}">
                        <div
                            style="
                            background: #d4edda;
                            color: #155724;
                            padding: 12px;
                            border-radius: 8px;
                            margin-bottom: 20px;
                            border: 1px solid #c3e6cb;
                            "
                            >
                            ${message}
                        </div>
                    </c:if>

                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div
                            style="
                            background: #f8d7da;
                            color: #721c24;
                            padding: 12px;
                            border-radius: 8px;
                            margin-bottom: 20px;
                            border: 1px solid #f5c6cb;
                            "
                            >
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${empty orders}">
                        <p
                            style="
                            text-align: center;
                            color: #666;
                            font-size: 16px;
                            margin: 40px 0;
                            "
                            >
                            Không có đơn hàng nào trong hệ thống.
                        </p>
                    </c:if>

                    <c:if test="${not empty orders}">
                        <table>
                            <tr>
                                <th>ID Đơn</th>
                                <th>Người đặt</th>
                                <th>Email</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Phương thức thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Địa chỉ giao hàng</th>
                                <th>Hành động</th>
                            </tr>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.order_id}</td>
                                    <td class="user-info">${order.user_name}</td>
                                    <td class="email">${order.user_email}</td>
                                    <td>
                                        <fmt:formatDate
                                            value="${order.order_date}"
                                            pattern="dd/MM/yyyy"
                                            />
                                    </td>
                                    <td class="currency">
                                        <fmt:formatNumber
                                            value="${order.total_amount}"
                                            type="currency"
                                            currencySymbol="₫"
                                            />
                                    </td>
                                    <td>${order.payment_method}</td>
                                    <td>
                                        <span class="status-${order.status.toLowerCase()}">
                                            ${order.status}
                                        </span>
                                    </td>
                                    <td style="text-align: left; max-width: 200px">
                                        ${order.shipping_address}
                                    </td>
                                    <td>
                                        <!-- Button chuyển từ PROCESSING sang SHIPPING -->
                                        <c:if test="${order.status == 'PROCESSING'}">
                                            <form
                                                action="adminorder"
                                                method="post"
                                                style="display: inline"
                                                onsubmit="return confirm('Bạn có chắc muốn chuyển đơn hàng này sang trạng thái SHIPPING?')"
                                                >
                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="updateToShipping"
                                                    />
                                                <input
                                                    type="hidden"
                                                    name="orderId"
                                                    value="${order.order_id}"
                                                    />
                                                <input
                                                    type="hidden"
                                                    name="userId"
                                                    value="${order.user_id}"
                                                    />
                                                <button
                                                    type="submit"
                                                    class="action-btn"
                                                    style="background: #28a745; color: white"
                                                    title="Chuyển sang trạng thái vận chuyển"
                                                    >
                                                    → SHIPPING
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- Hiển thị trạng thái hiện tại nếu không phải PROCESSING -->
                                        <c:if test="${order.status != 'PROCESSING'}">
                                            <span
                                                class="action-btn"
                                                style="background: #6c757d; cursor: default"
                                                >
                                                ${order.status}
                                            </span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>

                        <div style="text-align: center; margin-top: 20px; color: #666">
                            <strong>Tổng số đơn hàng: ${orders.size()}</strong>
                        </div>
                    </c:if>

                    <a href="<c:url value='/admin'/>" class="back-link"
                       >← Quay lại Dashboard</a
                    >
                </div>
            </body>
        </html>
