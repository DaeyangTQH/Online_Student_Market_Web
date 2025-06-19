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
        <header>
            <div class="navbar">
                <div class="logo">SVMarket</div>
                <nav>
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <a href="#">Categories</a>
                    <a href="#">Sell</a>
                    <a href="signup.jsp" class="signup-btn">Sign up</a>
                </nav>
            </div>
        </header>
        <!-- End header -->

        <!-- content -->
        <main>
            <div class="container py-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Danh mục</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${categoryName}</li>
                    </ol>
                </nav>
                <h2 class="fw-bold mb-4">${categoryName}</h2>
                <div class="row g-4">
                    <c:forEach items="${productlist}" var="p">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="product-card text-center">
                                <div class="ratio ratio-1x1 mb-2">
                                    <img class="product-img w-100 h-100 object-fit-cover rounded-3"
                                         src="${empty p.image_url ? 'https://source.unsplash.com/400x400?product' : p.image_url}"
                                         alt="${p.product_name}">
                                </div>
                                <div class="product-name fw-semibold">${p.product_name}</div>
                                <div class="product-price text-muted">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$"/>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Pagination -->
                <nav aria-label="Page navigation" class="d-flex justify-content-center mt-5">
                    <ul class="pagination">
                        <li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">...</a></li>
                        <li class="page-item"><a class="page-link" href="#">10</a></li>
                        <li class="page-item"><a class="page-link" href="#"><i class="bi bi-chevron-right"></i></a></li>
                    </ul>
                </nav>
            </div>
        </main>
        <!-- content -->

        <!-- Footer -->
        <footer class="footer py-4">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <div class="d-flex justify-content-center mb-3">
                            <a href="#" class="text-decoration-none text-secondary"
                               >About Us</a
                            >
                            <a href="#" class="text-decoration-none text-secondary"
                               >Contact</a
                            >
                            <a href="#" class="text-decoration-none text-secondary">FAQ</a>
                            <a href="#" class="text-decoration-none text-secondary"
                               >Terms of Service</a
                            >
                            <a href="#" class="text-decoration-none text-secondary"
                               >Privacy Policy</a
                            >
                        </div>

                        <div class="d-flex justify-content-center mb-3 social-links">
                            <a href="#" class="text-secondary">
                                <i class="bi bi-facebook"></i>
                            </a>
                            <a href="#" class="text-secondary">
                                <i class="bi bi-twitter"></i>
                            </a>
                            <a href="#" class="text-secondary">
                                <i class="bi bi-instagram"></i>
                            </a>
                        </div>

                        <div class="text-secondary small">
                            &copy; 2025 SVMarket. All rights reserved.
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!--Footer styles--> 
    </body>
</html>
