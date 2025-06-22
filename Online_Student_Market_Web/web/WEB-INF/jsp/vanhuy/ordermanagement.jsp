<%-- 
    Document   : ordermanagement
    Created on : Jun 9, 2025, 10:34:14 PM
    Author     : Van Huy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng</title>
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
            href="${pageContext.request.contextPath}/resources/css/vanhuy/order.css"
            />
    </head>
    <body>
        <!-- Header -->
         <header>
            <div class="d-flex justify-content-between align-items-center navbar">
                <div class="d-flex align-items-center">
                    <div class="logo">SVMarket</div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></div>
                    <div class="nav-item"><a href="">Danh mục</a></div>
                    <div class="nav-item"><a href="#">Yêu thích</a></div>
                    <div class="nav-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="search-box me-3">
                        <i class="bi bi-search"></i>
                        <input
                            type="text"
                            placeholder="Search"
                            class="border-0 bg-transparent"
                            style="outline: none; width: 150px"
                            />
                    </div>
                    <div class="me-3">
                        <i class="bi bi-bell"></i>
                    </div>
                    <div class="avatar"></div>
                </div>
            </div>
        </header>
        <!-- End header -->
        
        <!--Content-->
        <main>
        <div class="container mt-4">
            
        </div>
        </main>
        <!--End Content-->

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
    </body>
</html>
