<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Subcategory</title>
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
            .filter-form {
                margin-bottom: 24px;
                text-align: right;
            }
            .filter-form select {
                padding: 6px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body>
        <div class="container" style="display: flex; gap: 32px; align-items: flex-start;">
            <!-- Sidebar filter category -->
            <div style="width: 220px; min-width: 180px;">
                <form action="${pageContext.request.contextPath}/subcategoryadmin" method="get">
                    <label for="cid" style="font-weight: bold; margin-bottom: 8px; display: block;">Lọc theo Category:</label>
                    <select name="cid" id="cid" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #ccc;">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.category_id}" ${cat.category_id == param.cid ? 'selected' : ''}>${cat.category_name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="action-btn" style="width: 100%; margin-top: 10px;">Lọc</button>
                </form>
            </div>
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
                    <c:forEach var="sub" items="${subCategories}">
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
    </body>
</html>