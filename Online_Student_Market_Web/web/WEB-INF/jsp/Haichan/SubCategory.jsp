<%-- 
    Document   : SubCategory
    Created on : Jul 23, 2025, 9:49:04 AM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.SubCategory" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý SubCategory</title>
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
        <div class="container" style="display: flex; gap: 32px; align-items: flex-start;">
            <!-- Sidebar filter category -->
            <c:if test="${not empty categories}">
            <div style="width: 220px; min-width: 180px;">
                <form action="${pageContext.request.contextPath}/subCategory" method="get">
                    <label for="cid" style="font-weight: bold; margin-bottom: 8px; display: block;">Lọc theo Category:</label>
                    <select name="cid" id="cid" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #ccc;">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.category_id}" <c:if test="${cat.category_id == param.cid}">selected</c:if>>${cat.category_name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="action-btn" style="width: 100%; margin-top: 10px;">Lọc</button>
                </form>
            </div>
            </c:if>
            <!-- Main content -->
            <div style="flex: 1;">
                <h1>Quản lý SubCategory</h1>
                <form action="#" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn thêm subcategory này?');">
                    <input type="text" name="subCategoryName" placeholder="Tên subcategory" required />
                    <input type="text" name="subCategoryImageUrl" placeholder="Image URL" required />
                    <input type="hidden" name="action" value="add" />
                    <input type="submit" class="action-btn" value="Thêm mới" />
                </form>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Hình ảnh</th>
                        <th>Image URL</th>
                        <th>Hành động</th>
                    </tr>
                    <c:forEach var="sub" items="${subCategoryList}">
                        <tr>
                            <td>${sub.subCategory_id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${param.editId == sub.subCategory_id}">
                                        <form action="#" method="post" style="display:inline;">
                                            <input type="hidden" name="subCategoryId" value="${sub.subCategory_id}" />
                                            <input type="text" name="newName" value="${sub.subCategory_name}" required style="width:120px;" />
                                            <input type="text" name="newImageUrl" value="${sub.subCategory_image_url}" required style="width:180px;" />
                                            <input type="hidden" name="action" value="edit" />
                                            <input type="submit" class="action-btn" value="Lưu" />
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        ${sub.subCategory_name}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><img src="${empty sub.subCategory_image_url ? 'https://source.unsplash.com/400x400?' : sub.subCategory_image_url}" alt="img" style="width:60px;height:60px;object-fit:cover;"></td>
                            <td>${sub.subCategory_image_url}</td>
                            <td>
                                <form action="#" method="post" style="display:inline;">
                                    <input type="hidden" name="subCategoryId" value="${sub.subCategory_id}" />
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="submit" class="action-btn" value="Xóa" />
                                </form>
                                <c:choose>
                                    <c:when test="${param.editId == sub.subCategory_id}">
                                        <!-- Đang sửa -->
                                    </c:when>
                                    <c:otherwise>
                                        <form action="" method="get" style="display:inline;">
                                            <input type="hidden" name="cid" value="${param.cid}" />
                                            <input type="hidden" name="editId" value="${sub.subCategory_id}" />
                                            <button type="submit" class="action-btn" style="background:#FF6B2C;">Sửa</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <a href="${pageContext.request.contextPath}/admin" class="back-link">Quay lại Dashboard</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy; 2025 SVMarket. All rights reserved.
        </div>
    </body>
</html>
