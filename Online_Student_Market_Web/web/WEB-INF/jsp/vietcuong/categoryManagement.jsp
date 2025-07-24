<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Category"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Category</title>
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
            box-sizing: border-box;
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
            width: 1100px;
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

        input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin: 4px 6px 8px 0;
            width: 180px;
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
            <a href="${pageContext.request.contextPath}/category" class="active">Danh mục</a>
            <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
        </div>
        <div class="user-info">
            <span>Xin chào, admin1</span>
            <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                <button type="submit" class="logout-btn">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- Main content -->
    <div class="container">
        <h1>Quản lý Danh mục</h1>
        
        <form action="categoryManagement" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn thêm category này?');">
            <input type="text" name="categoryName" placeholder="Tên category" required />
            <input type="text" name="categoryDescription" placeholder="Mô tả" required />
            <input type="text" name="categoryImageUrl" placeholder="Image URL" required />
            <input type="hidden" name="action" value="add" />
            <input type="submit" class="action-btn" value="Thêm mới" />
        </form>

        <table>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Image URL</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="cat" items="${categories}">
                <tr>
                    <td>${cat.category_id}</td>
                    <td>${cat.category_name}</td>
                    <td>${cat.category_description}</td>
                    <td>${cat.category_image_url}</td>
                    <td>
                        <form action="categorymanagement" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa category này?');">
                            <input type="hidden" name="categoryId" value="${cat.category_id}" />
                            <input type="hidden" name="action" value="delete" />
                            <input type="submit" class="action-btn" value="Xóa" />
                        </form>
                        <form action="categorymanagement" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn sửa category này?');">
                            <input type="hidden" name="categoryId" value="${cat.category_id}" />
                            <input type="text" name="newName" placeholder="Tên mới" required />
                            <input type="text" name="newDescription" placeholder="Mô tả mới" required />
                            <input type="text" name="newImageUrl" placeholder="Image URL mới" required />
                            <input type="hidden" name="action" value="edit" />
                            <input type="submit" class="action-btn" value="Sửa" />
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
