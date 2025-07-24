<%-- 
    Document   : SubCategory
    Created on : Jul 23, 2025, 9:49:04 AM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SubCategory</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Haichan/category.css"/>
        <style>
            .breadcrumb-item a {
                color: #1976d2;
                text-decoration: none;
                transition: text-decoration 0.2s;
            }
            .breadcrumb-item a:hover {
                text-decoration: underline !important;
            }
            .breadcrumb-item.active {
                color: #444;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!-- End header -->

        <main>
            <div class="container py-5">
                <nav aria-label="breadcrumb" style="margin-bottom: 1.5rem">
                    <ol class="breadcrumb mb-1" style="--bs-breadcrumb-divider: '/';">
                        <li class="breadcrumb-item">
                            <a href="category" style="color: #1976d2; text-decoration: none;">Danh mục</a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page" style="color: #444;">${categoryName}</li>
                    </ol>
                </nav>

                <div class="row g-4">
                    <c:forEach var="sub" items="${subCategoryList}">
                        <div class="col-6 col-md-4 col-lg-2">
                            <a href="${pageContext.request.contextPath}/productList?subCategoryId=${sub.subCategory_id}"
                               class="category-item d-block text-center text-decoration-none">
                                <div class="ratio ratio-1x1 overflow-hidden rounded-3">
                                    <img class="category-img w-100 h-100"
                                         src="${empty sub.subCategory_image_url
                                                ? "https://source.unsplash.com/400x400?"
                                                : sub.subCategory_image_url}"
                                         alt="${sub.subCategory_name}">
                                </div>
                                <p class="category-title mt-2 mb-0">${sub.subCategory_name}</p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
        <!--Footer styles--> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
