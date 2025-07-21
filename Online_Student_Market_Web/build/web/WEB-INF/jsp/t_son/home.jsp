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
            <c:when
              test="${sessionScope.isLoggedIn && not empty sessionScope.user}"
            >
              <a href="${pageContext.request.contextPath}/infouser">
                <span>Xin chào, ${sessionScope.user.username}</span>
              </a>
              <a
                href="${pageContext.request.contextPath}/logout"
                class="login-btn"
                >Đăng xuất</a
              >
            </c:when>
            <c:otherwise>
              <a
                href="${pageContext.request.contextPath}/login"
                class="login-btn"
                >Đăng nhập</a
              >
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
          <input type="text" name="query" placeholder="Tìm kiếm sản phẩm..." />
          <button type="submit" class="search-btn">Tìm</button>
        </form>
      </div>

      <!-- Sản phẩm nổi bật -->
      <section class="featured-products">
        <h2>Sản phẩm nổi bật</h2>
        <div class="product-list">
          <c:choose>
            <c:when test="${not empty products}">
              <c:forEach var="product" items="${products}">
                <div class="product-item">
                  <img src="${product.image}" alt="${product.name}" />
                  <h3>${product.name}</h3>
                  <p>${product.description}</p>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <p>Không có sản phẩm nào được hiển thị.</p>
            </c:otherwise>
          </c:choose>
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
    <c:import url="/WEB-INF/jsp/common/footer.jsp" />
  </body>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tson/home.css" />
</head>
<body>
<!-- Header -->
<header>
    <div class="navbar">
        <div class="logo">SVMarket</div>
        <nav>
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/category">Danh mục</a>
            <a href="#">Bán</a>

            <c:choose>
                <c:when test="${sessionScope.isLoggedIn && not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/infouser">
                        <span>Xin chào, ${sessionScope.user.username}</span>
                    </a>
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
<main class="home-container container my-4">
    <!-- Search -->
    <div class="search-container mb-4 text-center">
        <form action="search.jsp" method="GET" class="d-flex justify-content-center">
            <input type="text" name="query" placeholder="Tìm kiếm sản phẩm..." class="form-control w-50 me-2" />
            <button type="submit" class="btn btn-warning">Tìm</button>
        </form>
    </div>

    <!-- Featured Products -->
    <section class="featured-products mb-5">
        <h2 class="mb-4">Sản phẩm nổi bật</h2>
        <c:choose>
            <c:when test="${not empty products}">
                <div class="row row-cols-1 row-cols-md-4 g-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col">
                            <div class="card h-100">
                                <img src="${pageContext.request.contextPath}/resources/img/${product.image_url}"
                                     class="card-img-top" alt="${product.product_name}" style="height:200px; object-fit:cover;" />
                                <div class="card-body">
                                    <h5 class="card-title">${product.product_name}</h5>
                                    <p class="card-text">${product.description}</p>
                                    <p class="fw-bold text-danger">${product.price} đ</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p>Không có sản phẩm nào được hiển thị.</p>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- Categories -->
    <section class="categories text-center">
        <h2>Danh mục</h2>
        <div class="category-list d-flex justify-content-center gap-3 mt-3 flex-wrap">
            <a href="#">Sách học</a>
            <a href="#">Đồ điện tử</a>
            <a href="#">Quần áo</a>
            <a href="#">Thể thao</a>
            <a href="#">Khác</a>
        </div>
    </section>
</main>

<!-- Footer -->
<c:import url="/WEB-INF/jsp/common/footer.jsp"/>
</body>

</html>
