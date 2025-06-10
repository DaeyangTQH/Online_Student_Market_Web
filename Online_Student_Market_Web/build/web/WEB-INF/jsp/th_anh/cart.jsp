<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Shopping Cart</title>
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
      href="${pageContext.request.contextPath}/resources/css/stylecart.css"
    />
</head>
<body>
        <div class="header">
      <div class="container">
        <div class="d-flex justify-content-between align-items-center">
          <div class="d-flex align-items-center">
            <div class="fw-bold me-4">◼ SVMarket</div>
            <div class="nav-item"><a href="#">Trang chủ</a></div>
            <div class="nav-item"><a href="#">Danh mục</a></div>
            <div class="nav-item"><a href="#">Yêu thích</a></div>
            <div class="nav-item"><a href="#">Giỏ hàng</a></div>
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
      </div>
    </div>
    <div class="row">
        <div class="col-md-3"></div>
    <div class="col-md-6">
        <h1>Shopping Cart</h1>
    <div class="cart">
        <div class="item">Used Textbook – Introduction to Economics (x1) <span>$25</span></div>
        <div class="item">Scientific Calculator (x2) <span>$30</span></div>
        <div class="item">Laptop Backpack (x1) <span>$40</span></div>
    </div>
         <div class="summary">
        <h3>Order Summary</h3>
        <p>Subtotal: $95</p>
        <p>Shipping: Free</p>
        <p>Total: $95</p>
        <form action="checkout" method="post">
            <button type="submit">Proceed to Checkout</button>
        </form>
    </div>
    </div>
    </div>
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
