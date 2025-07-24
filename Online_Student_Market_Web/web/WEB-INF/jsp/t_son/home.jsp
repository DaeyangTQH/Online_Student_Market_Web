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

                <!-- Danh mục -->
                <section class="categories">
                    <h2>Danh mục</h2>
                    <div class="category-list">
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <c:forEach var="category" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/productList?cid=${category.category_id}">
                                        <i class="bi
                                           <c:choose>
                                               <c:when test="${category.category_name == 'Stationery'}">bi-pencil</c:when>
                                               <c:when test="${category.category_name == 'Notebooks'}">bi-journal-bookmark</c:when>
                                               <c:when test="${category.category_name == 'Writing Instruments'}">bi-pen</c:when>
                                               <c:when test="${category.category_name == 'Art Supplies'}">bi-palette</c:when>
                                               <c:when test="${category.category_name == 'Desk Organizers'}">bi-archive</c:when>
                                               <c:when test="${category.category_name == 'Backpacks'}">bi-bag</c:when>
                                               <c:when test="${category.category_name == 'School Uniforms'}">bi-person</c:when>
                                               <c:when test="${category.category_name == 'Sports Gear'}">bi-trophy</c:when>
                                               <c:otherwise>bi-box</c:otherwise>
                                           </c:choose>
                                           "></i>


                                        <span>${category.category_name}</span>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có danh mục nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

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
            </main>

            <!-- Footer -->
            <c:import url="/WEB-INF/jsp/common/footer.jsp" />
        </body>
    </html>
