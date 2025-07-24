<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background: #fff;
            margin: 0;
        }
        .container {
            width: 900px;
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
            font-size: 2rem;
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
            color: #fff;
        }
        a.back-link {
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
        a.back-link:hover {
            background: #e85b1c;
        }

        /* Header & Footer - copied from admin.jsp */
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
        .main-header .user-info .logout-btn {
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
        .main-header .user-info .logout-btn:hover {
            background: #FF6B2C;
            color: #fff;
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
            <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                <button type="submit" class="logout-btn">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- Main content -->
    <div class="container">
        <h1>Quản lý người dùng</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Email</th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.user_id}</td>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                </tr>
            </c:forEach>
        </table>
        <a href="<c:url value='/admin' />" class="back-link">Quay lại Dashboard</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2025 SVMarket. All rights reserved.
    </div>
</body>
</html>

