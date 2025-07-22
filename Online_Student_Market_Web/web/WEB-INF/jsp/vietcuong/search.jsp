<%-- 
    Document   : search
    Created on : Jul 21, 2025, 10:06:40 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Kết quả tìm kiếm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Haichan/productList.css" />
    </head>
    <body>
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <main>
            <div class="container py-5">
                <h2 class="fw-bold mb-4">Kết quả tìm kiếm cho: "${keyword}"</h2>
                <div class="row g-4">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="col-12"><p>Không tìm thấy sản phẩm nào.</p></div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${products}">
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
                                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ"/>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
    </body>
</html>
