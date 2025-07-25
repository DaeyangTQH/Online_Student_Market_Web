<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String selectedCategoryId = (String) request.getAttribute("selectedCategoryId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background: #fff;
            margin: 0;
        }
        .main-header {
            width: 100%;
            background: #fff;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            height: 70px;
            box-shadow: 0 2px 8px rgba(255, 107, 44, 0.04);
        }
        .main-header .logo {
            font-size: 2rem;
            font-weight: bold;
            color: #222;
        }
        .main-header .nav {
            display: flex;
            gap: 32px;
        }
        .main-header .nav a {
            color: #222;
            text-decoration: none;
            font-weight: 500;
            font-size: 17px;
            padding: 8px 0;
            border-bottom: 2px solid transparent;
            transition: border 0.2s, color 0.2s;
        }
        .main-header .nav a.active,
        .main-header .nav a:hover {
            color: #FF6B2C;
            border-bottom: 2px solid #FF6B2C;
        }
        .main-header .user-info {
            display: flex;
            gap: 16px;
            align-items: center;
        }
        .main-header .logout-btn {
            background: #FFF3EA;
            color: #FF6B2C;
            border: none;
            border-radius: 18px;
            padding: 7px 18px;
            font-size: 15px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.2s, color 0.2s;
        }
        .main-header .logout-btn:hover {
            background: #FF6B2C;
            color: #fff;
        }

        .container {
            width: 1200px;
            margin: 40px auto;
            background: #fff;
            padding: 32px;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(255, 107, 44, 0.08);
        }

        h1 {
            text-align: center;
            color: #222;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #FF6B2C;
            color: white;
        }

        input[type="text"],
        input[type="number"],
        select {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .action-btn {
            background: #FF6B2C;
            color: #fff;
            border: none;
            padding: 7px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.2s;
        }

        .action-btn:hover {
            background: #e85b1c;
        }

        .footer {
            width: 100%;
            background: #fff;
            border-top: 1px solid #eee;
            text-align: center;
            padding: 18px 0 12px 0;
            color: #888;
            font-size: 15px;
            margin-top: 60px;
            box-shadow: 0 -2px 8px rgba(255, 107, 44, 0.04);
        }

        .back-link {
            display: inline-block;
            margin-top: 24px;
            text-decoration: none;
            background: #FF6B2C;
            color: white;
            padding: 10px 18px;
            border-radius: 12px;
            font-weight: bold;
            transition: 0.2s;
        }

        .back-link:hover {
            background: #e85b1c;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="main-header">
        <div class="logo">SVMarket</div>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/category">Danh mục</a>
            <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
        </div>
        <div class="user-info">
            <span>Xin chào, admin1</span>
            <form action="${pageContext.request.contextPath}/logout" method="post">
                <button type="submit" class="logout-btn">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- Main content -->
    <div class="container">
        <h1>Quản lý Sản phẩm</h1>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-info">
                ${sessionScope.message}
                <c:remove var="message" scope="session"/>
            </div>
        </c:if>

        <!-- Bộ lọc -->
        <form method="get" action="productManagement" style="margin-bottom: 20px; display: flex; align-items: center; gap: 12px;">
            <label for="categoryId"><strong>Lọc theo danh mục:</strong></label>
            <select name="categoryId" id="categoryId" onchange="this.form.submit()">
                <option value="">Tất cả</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.category_id}" <c:if test="${selectedCategoryId eq cat.category_id}">selected</c:if>>${cat.category_name}</option>
                </c:forEach>
            </select>
        </form>

        <!-- Thêm mới sản phẩm -->
        <form action="productManagement" method="post" style="margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 10px;">
            <select name="categoryId" required>
                <option value="">Chọn danh mục</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.category_id}">${cat.category_name}</option>
                </c:forEach>
            </select>
            <input type="text" name="productName" placeholder="Tên sản phẩm" required />
            <input type="text" name="description" placeholder="Mô tả" required />
            <input type="number" name="price" placeholder="Giá" step="0.01" required style="width: 100px;" />
            <input type="number" name="stockQuantity" placeholder="Số lượng" required style="width: 100px;" />
            <input type="text" name="imageUrl" placeholder="Image URL" required style="width: 200px;" />
            <input type="hidden" name="action" value="add" />
            <input type="submit" class="action-btn" value="Thêm mới" />
        </form>

        <!-- Bảng sản phẩm -->
        <table>
            <tr>
                <th>ID</th>
                <th>Danh mục</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Image</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="pro" items="${products}">
                <tr>
                    <td>${pro.product_id}</td>
                    <td>
                        <c:forEach var="cat" items="${categories}">
                            <c:if test="${cat.category_id == pro.category_id}">${cat.category_name}</c:if>
                        </c:forEach>
                    </td>
                    <td>${pro.product_name}</td>
                    <td>${pro.description}</td>
                    <td>${pro.price}</td>
                    <td>${pro.stock_quantity}</td>
                    <td><a href="${pro.image_url}" target="_blank">Xem ảnh</a></td>
                    <td>
                        <!-- Xóa -->
                        <form action="productManagement" method="post" style="display:inline;" onsubmit="return confirm('Xóa sản phẩm này?');">
                            <input type="hidden" name="productId" value="${pro.product_id}" />
                            <input type="hidden" name="action" value="delete" />
                            <input type="submit" class="action-btn" value="Xóa" style="background:#dc3545;" />
                        </form>
                        <!-- Sửa -->
                        <form action="productManagement" method="post" style="display:inline;" onsubmit="return confirm('Sửa sản phẩm này?');">
                            <select name="newCategoryId" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.category_id}" <c:if test="${cat.category_id == pro.category_id}">selected</c:if>>${cat.category_name}</option>
                                </c:forEach>
                            </select>
                            <input type="text" name="newName" placeholder="Tên mới" required style="width: 100px;" />
                            <input type="text" name="newDescription" placeholder="Mô tả mới" required style="width: 120px;" />
                            <input type="number" name="newPrice" placeholder="Giá mới" step="0.01" required style="width: 80px;" />
                            <input type="number" name="newStockQuantity" placeholder="SL mới" required style="width: 80px;" />
                            <input type="text" name="newImageUrl" placeholder="URL ảnh mới" required style="width: 150px;" />
                            <input type="hidden" name="productId" value="${pro.product_id}" />
                            <input type="hidden" name="action" value="edit" />
                            <input type="submit" class="action-btn" value="Sửa" style="background: #ffc107; color: #333;" />
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <a href="<c:url value='/admin'/>" class="back-link">Quay lại Dashboard</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2025 SVMarket. All rights reserved.
    </div>
</body>
</html>
