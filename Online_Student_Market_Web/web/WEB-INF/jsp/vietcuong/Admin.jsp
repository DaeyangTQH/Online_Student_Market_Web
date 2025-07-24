<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <style>
            body {
                font-family: 'Roboto', Arial, sans-serif;
                background: #fff;
                margin: 0;
            }
            .container {
                width: 420px;
                margin: 60px auto;
                background: #fff;
                padding: 32px 32px 24px 32px;
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
            .admin-menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .admin-menu li {
                margin: 20px 0;
            }
            .admin-menu a {
                display: block;
                background: #fff;
                color: #FF6B2C;
                border: 2px solid #FF6B2C;
                text-decoration: none;
                padding: 16px 0;
                border-radius: 14px;
                text-align: center;
                font-size: 18px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(255, 107, 44, 0.06);
                transition: background 0.2s, color 0.2s, box-shadow 0.2s;
            }
            .admin-menu a:hover {
                background: #FF6B2C;
                color: #fff;
                box-shadow: 0 4px 16px rgba(255, 107, 44, 0.15);
            }
            /* Footer style */
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
            /* Header style */
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
                letter-spacing: 1px;
            }
            .main-header .nav {
                display: flex;
                align-items: center;
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
                align-items: center;
                gap: 16px;
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
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="main-header">
            <div class="logo">SVMarket</div>
            <div class="nav">
                <a href="${pageContext.request.contextPath}/home" class="active">Trang chủ</a>
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
            <h1>Admin Management</h1>
            <!-- ...existing code... -->
<ul class="admin-menu">
    <li><a href="${pageContext.request.contextPath}/userManagement">Quản lý User</a></li>
    <li><a href="${pageContext.request.contextPath}/categoryManagement">Quản lý Category</a></li>
    <li><a href="${pageContext.request.contextPath}/subcategoryadmin">Quản lý Subcategory</a></li>
    <li><a href="${pageContext.request.contextPath}/productManagement">Quản lý Product</a></li>
    <li><a href="${pageContext.request.contextPath}/adminorder">Quản lý Order</a></li>
</ul>
<!-- ...existing code... -->
        </div>
        <!-- Footer -->
        <div class="footer">
            &copy; 2025 SVMarket. All rights reserved.
        </div>
    </body>
</html>