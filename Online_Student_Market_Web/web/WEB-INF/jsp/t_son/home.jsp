<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>SVMarket - Trang chủ</title>
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
            href="${pageContext.request.contextPath}/resources/css/tson/home.css"
            />
    </head>
    <body>
        <!-- Header -->
        <header>
            <div class="navbar">
                <div class="logo">SVMarket</div>
                <nav>
                    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/category">Danh mục</a>
                    <a href="#" class="me-4">Bán</a>
                    <c:choose>
                        <c:when test="${sessionScope.isLoggedIn}">
                            <a href="${pageContext.request.contextPath}/infouser"><span class="">Xin chào, ${sessionScope.user.username}</span></a>
                            <a href="${pageContext.request.contextPath}/logout" class="login-btn">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="login-btn">Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
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

        <!-- include footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
    </body>
</html>
