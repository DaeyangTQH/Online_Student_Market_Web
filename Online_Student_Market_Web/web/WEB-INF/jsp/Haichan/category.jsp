<%-- 
    Document   : category
    Created on : Jun 14, 2025, 10:04:39 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh mục sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Haichan/category.css"/>
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
                <h2 class="fw-bold mb-4">Categories</h2>

                <div class="row g-4">
                    <c:forEach items="${category}" var="c">
                        <div class="col-6 col-md-4 col-lg-2">
                            <a href="${pageContext.request.contextPath}/products?cid=${c.category_id}"
                               class="category-item d-block text-center text-decoration-none">
                                <!-- khung vuông 1:1 -->
                                <div class="ratio ratio-1x1 overflow-hidden rounded-3">
                                    <img class="category-img w-100 h-100"
                                         src="${empty c.category_image_url
                                                ? 'https://source.unsplash.com/400x400?'+fn:replace(c.category_name,' ','')
                                                : c.category_image_url}"
                                         alt="${c.category_name}">
                                </div>
                                <p class="category-title mt-2 mb-0">${c.category_name}</p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
