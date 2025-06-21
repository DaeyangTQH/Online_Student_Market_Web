<%-- 
    Document   : product
    Created on : Jun 14, 2025, 10:04:47 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <main>
            
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
