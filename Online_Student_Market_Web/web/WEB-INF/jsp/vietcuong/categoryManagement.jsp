<%-- 
    Document   : categoryManagement
    Created on : Jul 21, 2025, 9:07:09 PM
    Author     : Haichann
--%>

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
        <title>Quản lý Category</title>
        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
            }
            .container {
                width: 900px;
                margin: 40px auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px #ccc;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background: #007bff;
                color: #fff;
            }
            .action-btn {
                background: #007bff;
                color: #fff;
                border: none;
                padding: 7px 15px;
                border-radius: 4px;
                cursor: pointer;
                margin: 0 2px;
            }
            .action-btn:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Quản lý Category</h2>
            <form action="categoryManagement" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn thêm category này?');">
                <input type="text" name="categoryName" placeholder="Tên category" required />
                <input type="text" name="categoryDescription" placeholder="Mô tả" required />
                <input type="text" name="categoryImageUrl" placeholder="Image URL" required />
                <input type="hidden" name="action" value="add" />
                <input type="submit" class="action-btn" value="Thêm mới" />
            </form>
            <br>
            <table>
                <tr>
                    <th>ID</th><th>Tên</th><th>Mô tả</th><th>Image URL</th><th>Hành động</th>
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
            <br>
            <a href="<c:url value='/admin'/>">Quay lại Dashboard</a>
        </div>
    </body>
</html>
