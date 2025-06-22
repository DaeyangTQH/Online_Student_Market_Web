<%-- 
    Document   : product
    Created on : Jun 14, 2025, 10:04:47 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm</title>
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
            href="${pageContext.request.contextPath}/resources/css/Haichan/productDetail.css"
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
        <main class="container my-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/productList?cid=${product.category_id}">${categoryName}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.product_name}</li>
                </ol>
            </nav>

            <div class="row product-container">
                <div class="col-md-6">
                    <div class="product-image-container">
                        <img src="${product.image_url}" class="img-fluid product-image" alt="${product.product_name}">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="product-details">
                        <h1 class="product-title">${product.product_name}</h1>
                        <p class="product-price fw-bold"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> ₫</p>
                        <p class="product-description">${product.description}</p>

                        <div class="product-meta">
                            <p><strong>Stock:</strong> ${product.stock_quantity} available</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-4">
                            <input type="hidden" name="productId" value="${product.product_id}">
                            <div class="d-flex">
                                <input type="number" name="quantity" class="form-control quantity-input" value="1" min="1" max="${product.stock_quantity}">
                                <button type="submit" class="btn btn-primary btn-add-to-cart ms-2">Add to Cart</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <!-- content -->

        <!-- Footer -->
        <footer class="footer py-4 mt-5">
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
