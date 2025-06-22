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
                        <li class="breadcrumb-item active catName" aria-current="page">${categoryName}</li>
                    </ol>
                </nav>
                 
                <h2 class="fw-bold m-0 catName">${categoryName}</h2>

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
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$"/>
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
                            <a class="page-link" href="?cid=${cid}&page=${currentPage - 1}"><i class="bi bi-chevron-left"></i></a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="?cid=${cid}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?cid=${cid}&page=${currentPage + 1}"><i class="bi bi-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </main>
        <!-- content -->

        <!-- Footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>

        <!--Footer styles--> 
    </body>
</html>
