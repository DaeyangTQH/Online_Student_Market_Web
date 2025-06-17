<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Haichan/category.css"/>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="#"><i class="bi bi-list"></i> ShopAll</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">Categories</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Deals</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">New Arrivals</a></li>
                </ul>
                <form class="d-flex me-3">
                    <input class="form-control search-bar" type="search" placeholder="Search" aria-label="Search">
                </form>
                <a href="#" class="me-3"><i class="bi bi-heart"></i></a>
                <a href="#" class="me-3"><i class="bi bi-cart"></i></a>
                <a href="#"><i class="bi bi-person-circle"></i></a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <h2 class="fw-bold mb-4">Categories</h2>
        <div class="row g-4">
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/1Q9Z1Zm.png" alt="Clothing" class="img-fluid rounded-4">
                    <div class="category-label">Clothing</div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/0y8Ftya.png" alt="Electronics" class="img-fluid rounded-4">
                    <div class="category-label">Electronics</div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/2yaf2wb.png" alt="Stationery" class="img-fluid rounded-4">
                    <div class="category-label">Stationery</div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/3Q1Z1Zm.png" alt="Home & Kitchen" class="img-fluid rounded-4">
                    <div class="category-label">Home & Kitchen</div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/4Q2Z1Zm.png" alt="Books" class="img-fluid rounded-4">
                    <div class="category-label">Books</div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card">
                    <img src="https://i.imgur.com/5Q3Z1Zm.png" alt="Toys & Games" class="img-fluid rounded-4">
                    <div class="category-label">Toys & Games</div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer mt-auto py-4 bg-white border-top">
        <div class="container d-flex flex-column flex-md-row justify-content-center justify-content-md-between align-items-center">
            <div class="footer-links mb-2 mb-md-0">
                <a href="#" class="footer-link">Terms of Service</a>
                <a href="#" class="footer-link">Privacy Policy</a>
                <a href="#" class="footer-link">Contact Us</a>
            </div>
            <div class="footer-copyright text-muted">
                ©2024 ShopAll Inc. All rights reserved.
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"/>
</body>
</html> 