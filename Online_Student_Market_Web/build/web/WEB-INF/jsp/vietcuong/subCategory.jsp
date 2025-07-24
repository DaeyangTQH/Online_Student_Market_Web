<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Subcategory</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .container { width: 90%; margin: 40px auto; background: #fff; padding: 32px; border-radius: 18px; box-shadow: 0 4px 24px rgba(255, 107, 44, 0.08);}
        h1 { text-align: center; color: #222; font-weight: 700; margin-bottom: 32px; letter-spacing: 1px; font-size: 2rem;}
        table { width: 100%; border-collapse: collapse; margin-bottom: 24px;}
        th, td { border: 1px solid #eee; padding: 12px 8px; text-align: center;}
        th { background: #FFF3EA; color: #FF6B2C;}
        .action-btn { background: #FF6B2C; color: #fff; border: none; border-radius: 8px; padding: 6px 14px; cursor: pointer; font-size: 15px; margin: 0 2px;}
        .action-btn:hover { background: #e65c1a;}
        .back-link { display: inline-block; margin-top: 18px; color: #FF6B2C; text-decoration: none; font-weight: 500;}
        .back-link:hover { text-decoration: underline;}
        .filter-form { margin-bottom: 24px; text-align: right;}
        .filter-form select { padding: 6px 12px; border-radius: 6px; border: 1px solid #ccc;}
    </style>
</head>
<body>
    <div class="container">
        <h1>Quản lý Subcategory</h1>
        <form class="filter-form" method="get" action="subCategory">
            <label for="categoryId"><strong>Lọc theo Category:</strong></label>
            <select name="categoryId" id="categoryId" onchange="this.form.submit()">
                <option value="">Tất cả</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.category_id}" <c:if test="${selectedCategoryId == cat.category_id}">selected</c:if>>${cat.category_name}</option>
                </c:forEach>
            </select>
        </form>
        <table>
            <tr>
                <th>ID</th>
                <th>Tên Subcategory</th>
                <th>Tên Category</th>
                <th>Ngày tạo</th>
                <th>Ngày cập nhật</th>
                <th>Hình ảnh</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="sub" items="${subCategories}">
                <tr>
                    <td>${sub.subCategory_id}</td>
                    <td>${sub.subCategory_name}</td>
                    <td>
                        <c:forEach var="cat" items="${categories}">
                            <c:if test="${cat.category_id == sub.category_id}">${cat.category_name}</c:if>
                        </c:forEach>
                    </td>
                    <td>${sub.created_at}</td>
                    <td>${sub.updated_at}</td>
                    <td>
                        <c:if test="${not empty sub.subCategory_image_url}">
                            <img src="${sub.subCategory_image_url}" alt="img" style="width:60px;height:60px;object-fit:cover;">
                        </c:if>
                    </td>
                    <td>
                        <button class="action-btn">Sửa</button>
                        <button class="action-btn">Xóa</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <a href="<c:url value='/admin'/>" class="back-link">Quay lại Dashboard</a>
    </div>
</body>
</html>