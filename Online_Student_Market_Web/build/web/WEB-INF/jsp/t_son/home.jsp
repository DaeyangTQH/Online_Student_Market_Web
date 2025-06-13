<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SVMarket - Trang chủ</title>
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="navbar">
            <div class="logo">SVMarket</div>
            <nav>
                <a href="#">Trang chủ</a>
                <a href="#">Danh mục</a>
                <a href="#">Bán</a>
                <a href="login.jsp" class="login-btn">Đăng nhập</a>
            </nav>
        </div>
    </header>

    <!-- Main content -->
    <main class="home-container">
        <!-- Tìm kiếm -->
        <div class="search-container">
            <form action="search.jsp" method="GET">
                <input type="text" name="query" placeholder="Tìm kiếm sản phẩm...">
                <button type="submit" class="search-btn">Tìm</button>
            </form>
        </div>

        <!-- Sản phẩm nổi bật -->
        <section class="featured-products">
            <h2>Sản phẩm nổi bật</h2>
            <div class="product-list">
                <!-- Sử dụng tag <c:forEach> để lặp qua sản phẩm từ servlet hoặc controller -->
                <c:forEach var="product" items="${products}">
                    <div class="product-item">
                        <img src="${product.image}" alt="${product.name}">
                        <h3>${product.name}</h3>
                        <p>${product.description}</p>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Danh mục -->
        <section class="categories">
            <h2>Danh mục</h2>
            <div class="category-list">
                <a href="#">Sách học</a>
                <a href="#">Đồ điện tử</a>
                <a href="#">Quần áo</a>
                <a href="#">Thể thao</a>
                <a href="#">Khác</a>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-links">
            <a href="#">Về SVMarket</a>
            <a href="#">Trung tâm trợ giúp</a>
            <a href="#">Điều khoản dịch vụ</a>
            <a href="#">Chính sách bảo mật</a>
        </div>
        <div class="social-icons">
            <i class="fa fa-facebook"></i>
            <i class="fa fa-twitter"></i>
            <i class="fa fa-instagram"></i>
        </div>
        <p>© 2024 SVMarket. Mọi quyền được bảo lưu.</p>
    </footer>
</body>
</html>
