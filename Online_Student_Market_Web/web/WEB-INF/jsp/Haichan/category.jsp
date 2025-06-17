<%-- 
    Document   : category
    Created on : Jun 14, 2025, 10:04:39 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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


    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">SVMarket</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Danh mục</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Bán</a></li>
                    </ul>
                    <form class="d-flex me-3">
                        <input class="form-control rounded-pill me-2" type="search" placeholder="Search" aria-label="Search" style="min-width: 180px;">
                    </form>
                    <a href="#" class="me-3"><i class="bi bi-heart"></i></a>
                    <a href="#" class="me-3"><i class="bi bi-cart"></i></a>
                    <a href="#"><img src="https://randomuser.me/api/portraits/women/44.jpg" alt="avatar" class="rounded-circle" width="32" height="32"></a>
                </div>
            </div>
        </nav>

        <!-- Breadcrumb -->
        <div class="container mt-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-white px-0">
                    <li class="breadcrumb-item"><a href="#" class="text-decoration-none text-muted">Danh mục</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Điện tử</li>
                </ol>
            </nav>

            <!-- Title -->
            <h2 class="fw-bold mb-4">Điện tử</h2>

            <!-- Product Grid -->
            <div class="row g-4">
                <!-- Product Card 1 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/0y8Ftya.png" class="card-img-top p-3" alt="Tai nghe không dây">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Tai nghe không dây</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$49.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 2 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/1Q9Z1Zm.png" class="card-img-top p-3" alt="Máy tính xách tay">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Máy tính xách tay</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$799.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 3 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/2yaf2wb.png" class="card-img-top p-3" alt="Đồng hồ thông minh">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Đồng hồ thông minh</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$199.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 4 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/3Q1Z1Zm.png" class="card-img-top p-3" alt="Máy tính bảng">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Máy tính bảng</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$249.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 5 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/4Q2Z1Zm.png" class="card-img-top p-3" alt="Loa Bluetooth">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Loa Bluetooth</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$59.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 6 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/5Q3Z1Zm.png" class="card-img-top p-3" alt="Chuột chơi game">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Chuột chơi game</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$29.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 7 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/6Q4Z1Zm.png" class="card-img-top p-3" alt="Bàn phím">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Bàn phím</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$79.99</p>
                        </div>
                    </div>
                </div>
                <!-- Product Card 8 -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="https://i.imgur.com/7Q5Z1Zm.png" class="card-img-top p-3" alt="Màn hình">
                        <div class="card-body text-center">
                            <h6 class="card-title mb-1">Màn hình</h6>
                            <p class="text-muted mb-0" style="font-size: 0.95rem;">$149.99</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <nav class="d-flex justify-content-center mt-5" aria-label="Page navigation">
                <ul class="pagination pagination-rounded">
                    <li class="page-item disabled"><span class="page-link">&lt;</span></li>
                    <li class="page-item active"><span class="page-link">1</span></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                    <li class="page-item"><a class="page-link" href="#">10</a></li>
                    <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
                </ul>
            </nav>
        </div>

        <!-- Footer -->
        <footer class="bg-white mt-5 py-4 border-top">
            <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center">
                <div class="mb-3 mb-md-0">
                    <a href="#" class="text-decoration-none me-4">About Us</a>
                    <a href="#" class="text-decoration-none me-4">Contact</a>
                </div>
                <div class="mb-3 mb-md-0">
                    <a href="#" class="text-muted me-3"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="text-muted me-3"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-muted"><i class="bi bi-instagram"></i></a>
                </div>
                <div>
                    <a href="#" class="text-decoration-none me-4">Privacy Policy</a>
                    <a href="#" class="text-decoration-none">Terms of Service</a>
                </div>
            </div>
            <div class="container text-center mt-3 text-muted" style="font-size: 0.95rem;">
                © 2024 SVMarket. All rights reserved.
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
