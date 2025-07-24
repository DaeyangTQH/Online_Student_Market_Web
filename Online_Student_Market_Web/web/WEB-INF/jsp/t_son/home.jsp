<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
    prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <title>SVMarket - Trang chủ</title>

            <link
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                rel="stylesheet"
                />
            <link
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
                rel="stylesheet"
                />
            <link
                rel="stylesheet"
                href="${pageContext.request.contextPath}/resources/css/main.css"
                />
            <link
                rel="stylesheet"
                href="${pageContext.request.contextPath}/resources/css/tson/home.css"
                />
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

        </head>

        <body>
            <!-- Header -->
            <c:import url="/WEB-INF/jsp/common/header.jsp"/>
            <!-- End header -->
            <section class="hero-banner">
                <div class="banner-content">
                    <h1>Chào mừng bạn đến với <span>SVMarket</span></h1>
                    <p>Nơi mua sắm lý tưởng cho sinh viên!</p>
                    <div class="search-container in-banner">
                        <form action="search" method="GET">
                            <input type="text" name="query" placeholder="Tìm kiếm sản phẩm..." />
                            <button type="submit" class="search-btn">Tìm</button>
                        </form>
                    </div>
                </div>
            </section>

            <!-- Main content -->
            <main class="home-container">

                <!-- Sản phẩm nổi bật -->
                <section class="featured-products">
                    <h2>Sản phẩm nổi bật</h2>
                    <div class="product-list">
                        <c:forEach var="product" items="${featuredProducts}">
                            <a class="product-item" href="${pageContext.request.contextPath}/product?pid=${product.product_id}">
                                <c:choose>
                                    <c:when test="${not empty product.image_url}">
                                        <img src="${product.image_url}" alt="${product.product_name}" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/300x200/ff6b35/ffffff?text=No+Image" alt="No image" />
                                    </c:otherwise>
                                </c:choose>
                                <h3>${product.product_name}</h3>
                                <p>${product.description}</p>
                                <div class="product-price">${product.price} VNĐ</div>
                            </a>
                        </c:forEach>
                    </div>
                </section>
                <!-- Why Choose Us section -->
                <section class="why-choose-us">
                    <div class="container">
                        <h2>Vì sao chọn <span>SVMarket</span>?</h2>
                        <div class="reasons">
                            <div class="reason">
                                <i class="bi bi-stars"></i>
                                <h3>Sản phẩm chất lượng</h3>
                                <p>Chúng tôi cam kết cung cấp các sản phẩm chính hãng, chất lượng cao, phù hợp với nhu cầu của sinh viên.</p>
                            </div>
                            <div class="reason">
                                <i class="bi bi-currency-dollar"></i>
                                <h3>Giá cả hợp lý</h3>
                                <p>Giá cả cạnh tranh, nhiều ưu đãi hấp dẫn giúp bạn tiết kiệm chi phí mua sắm.</p>
                            </div>
                            <div class="reason">
                                <i class="bi bi-truck"></i>
                                <h3>Giao hàng nhanh chóng</h3>
                                <p>Dịch vụ giao hàng nhanh, đảm bảo sản phẩm đến tay bạn an toàn và đúng hẹn.</p>
                            </div>
                            <div class="reason">
                                <i class="bi bi-people"></i>
                                <h3>Hỗ trợ tận tâm</h3>
                                <p>Đội ngũ hỗ trợ thân thiện, luôn sẵn sàng giải đáp mọi thắc mắc của bạn 24/7.</p>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

            <!-- Footer -->
            <c:import url="/WEB-INF/jsp/common/footer.jsp" />
        </body>
    </html>
