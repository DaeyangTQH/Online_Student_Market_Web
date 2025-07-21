<%-- 
    Document   : productManagement
    Created on : Jul 21, 2025, 9:07:19 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Product"%>
<%@page import="Model.Category"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String selectedCategoryId = (String) request.getAttribute("selectedCategoryId");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Product</title>
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
            <h2>Quản lý Sản phẩm</h2>
            <form method="get" action="productManagement" style="margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                <label for="categoryId"><b>Lọc theo danh mục:</b></label>
                <select name="categoryId" id="categoryId" onchange="this.form.submit()" style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc;">
                    <option value="">Tất cả</option>
                    <c:forEach var="cat" items="${categories}">
                        <c:choose>
                            <c:when test="${selectedCategoryId eq cat.category_id}">
                                <option value="${cat.category_id}" selected>
                                    ${cat.category_name}
                                </option>
                            </c:when>
                            <c:otherwise>
                                <option value="${cat.category_id}">
                                    ${cat.category_name}
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                </select>
            </form>
            <form action="productManagement" method="post" style="margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
                <select name="categoryId" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc;">
                    <option value="">Chọn danh mục</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.category_id}">${cat.category_name}</option>
                    </c:forEach>
                </select>
                <input type="text" name="productName" placeholder="Tên sản phẩm" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc;" />
                <input type="text" name="description" placeholder="Mô tả" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc;" />
                <input type="number" name="price" placeholder="Giá" step="0.01" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc; width: 100px;" />
                <input type="number" name="stockQuantity" placeholder="Số lượng" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc; width: 100px;" />
                <input type="text" name="imageUrl" placeholder="Image URL" required style="padding: 6px 10px; border-radius: 4px; border: 1px solid #ccc; width: 200px;" />
                <input type="hidden" name="action" value="add" />
                <input type="submit" class="action-btn" value="Thêm mới" style="background: #28a745;" />
            </form>
            <table style="background: #fff;">
                <tr>
                    <th>ID</th><th>Danh mục</th><th>Tên</th><th>Mô tả</th><th>Giá</th><th>Số lượng</th><th>Image URL</th><th>Hành động</th>
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
                            <form action="productManagement" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                <input type="hidden" name="productId" value="${pro.product_id}" />
                                <input type="hidden" name="action" value="delete" />
                                <input type="submit" class="action-btn" value="Xóa" style="background: #dc3545;" />
                            </form>
                            <form action="productManagement" method="post" style="display:inline; margin-top: 5px;" onsubmit="return confirm('Bạn có chắc chắn muốn sửa sản phẩm này?');">
                                <select name="newCategoryId" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;">
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.category_id}" <c:if test="${cat.category_id == pro.category_id}">selected</c:if>>${cat.category_name}</option>
                                    </c:forEach>
                                </select>
                                <input type="text" name="newName" placeholder="Tên mới" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc; width: 100px;" />
                                <input type="text" name="newDescription" placeholder="Mô tả mới" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc; width: 120px;" />
                                <input type="number" name="newPrice" placeholder="Giá mới" step="0.01" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc; width: 80px;" />
                                <input type="number" name="newStockQuantity" placeholder="Số lượng mới" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc; width: 80px;" />
                                <input type="text" name="newImageUrl" placeholder="Image URL mới" required style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc; width: 150px;" />
                                <input type="hidden" name="productId" value="${pro.product_id}" />
                                <input type="hidden" name="action" value="edit" />
                                <input type="submit" class="action-btn" value="Sửa" style="background: #ffc107; color: #333;" />
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <a href="<c:url value='/admin'/>" style="color: #007bff; text-decoration: underline;">Quay lại Dashboard</a>
        </div>
    </body>
</html>
