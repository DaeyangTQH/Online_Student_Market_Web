    <%-- 
    Document   : productList
    Created on : Jun 14, 2025, 10:07:27 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh mục</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
            />

        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/resources/css/main.css"
            />

        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/resources/css/Haichan/productList.css"
            />

    </head>
    <body>
        <!-- Header -->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!-- End header -->

        <!-- content -->
        <main>
            <div class="container py-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="category">Danh mục</a></li>
                        <c:if test="${not empty categoryName}">
                            <li class="breadcrumb-item"><a href="subcategory?cid=${cid}">${categoryName}</a></li>
                        </c:if>
                        <c:if test="${not empty subCategoryName}">
                            <li class="breadcrumb-item active" aria-current="page">${subCategoryName}</li>
                        </c:if>
                    </ol>
                </nav>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold m-0 catName">${categoryName}</h2>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                        <a href="createlisting?cid=${cid}" class="btn btn-success" style="height: 40px; display: flex; align-items: center; font-weight: 500;">
                            <i class="bi bi-plus-circle me-2"></i> Tạo sản phẩm
                        </a>
                    </c:if>
                </div>
                <div class="row">
                    <!-- Sidebar Filter -->
                    <aside class="col-lg-3 mb-4 mb-lg-0">
                        <div class="card shadow-sm sticky-top" style="top: 90px;">
                            <div class="card-body">
                                <h5 class="card-title mb-3"><i class="bi bi-funnel"></i> Bộ lọc</h5>
                                <form class="row g-3" method="get" action="">
                                    <input type="hidden" name="subCategoryId" value="${subCategoryId}"/>
                                    <div class="col-12 mb-3">
                                        <label class="form-label">Nhập khoảng giá phù hợp với bạn:</label>
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <input type="number" class="form-control text-end" id="minPriceInput" name="minPrice"
                                                   style="max-width:120px"
                                                   value="${not empty param.minPrice ? param.minPrice : ''}"
                                                   min="${minPriceValue}" max="${maxPriceValue}" placeholder="${minPriceValue}">
                                            <span>~</span>
                                            <input type="number" class="form-control text-end" id="maxPriceInput" name="maxPrice"
                                                   style="max-width:120px"
                                                   value="${not empty param.maxPrice ? param.maxPrice : ''}"
                                                   min="${minPriceValue}" max="${maxPriceValue}" placeholder="${maxPriceValue}">
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label for="type" class="form-label">Sắp xếp giá</label>
                                        <select class="form-select" id="type" name="type">
                                            <option value="" ${empty param.type ? 'selected' : ''}>Mặc định</option>
                                            <option value="asc" ${param.type == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                            <option value="desc" ${param.type == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-funnel"></i> Lọc</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </aside>
                    <!-- Product List -->
                    <section class="col-lg-9">
                        <div class="row g-4">
                            <c:forEach items="${productlist}" var="p">
                                <div class="col-6 col-md-4 col-lg-3">
                                    <a href="${pageContext.request.contextPath}/product?pid=${p.product_id}" class="product-link">
                                        <div class="product-card text-center">
                                            <div class="ratio ratio-1x1 mb-2">
                                                <img class="product-img w-100 h-100 object-fit-cover rounded-3"
                                                     src="${empty p.image_url ? 'https://i.pinimg.com/736x/06/06/fb/0606fbfad46069334cfc398ed9e96cab.jpg' : p.image_url}"
                                                     alt="${p.product_name}">
                                            </div>
                                            <div class="product-name fw-semibold">${p.product_name}</div>
                                            <div class="product-price text-muted">
                                                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>&nbsp;đ
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- Pagination -->
                        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-5">
                            <ul class="pagination">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?subCategoryId=${subCategoryId}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&type=${param.type}&page=${currentPage - 1}"><i class="bi bi-chevron-left"></i></a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="?subCategoryId=${subCategoryId}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&type=${param.type}&page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?subCategoryId=${subCategoryId}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&type=${param.type}&page=${currentPage + 1}"><i class="bi bi-chevron-right"></i></a>
                                </li>
                            </ul>
                        </nav>
                    </section>
                    <!-- End Product List -->
                </div>
            </div>
        </main>
        <!-- content -->

        <!-- Footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>

        <!--Footer styles--> 
        <style>
            .px-2 {
                position: relative;
                height: auto;
            }
        </style>
    </body>
</html>
