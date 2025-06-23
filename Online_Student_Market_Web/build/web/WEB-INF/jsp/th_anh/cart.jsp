<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/th_anh/stylecart.css" />
        <style>
            .bg-light {
                background-color: #fff6f0 !important;
            }
            .card,
            .list-group-item {
                background-color: #fff6f0;
            }
        </style>
    </head>

    <body>
        <div class="header py-3">
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
                        <div class="search-box me-3 d-flex align-items-center">
                            <i class="bi bi-search me-2"></i>
                            <input type="text" placeholder="Search" class="form-control border-0 bg-transparent p-0" style="width: 150px" />
                        </div>
                        <div class="me-3">
                            <i class="bi bi-bell fs-5"></i>
                        </div>
                        <div class="avatar bg-secondary rounded-circle" style="width: 32px; height: 32px;"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container my-5">
            <div class="content-section">
                <h2>Shopping cart</h2>
                <div class="history-item justify-content-between">
                    <div class="item-info">
                        <div>Used Textbook – Introduction to Economics</div>
                        <div class="item-quantity">Quantity: 1</div>
                    </div>
                    <span>$25</span>
                </div>
                <div class="history-item justify-content-between">
                    <div class="item-info">
                        <div>Scientific Calculator</div>
                        <div class="item-quantity">Quantity: 2</div>
                    </div>
                    <span>$30</span>
                </div>
                <div class="history-item justify-content-between">
                    <div class="item-info">
                        <div>Laptop Backpack</div>
                        <div class="item-quantity">Quantity: 1</div>
                    </div>
                    <span>$40</span>
                </div>

                <div class="content-section mt-4">
                    <h5>Order summary</h5>
                    <p>🧾 Subtotal: <strong>$95</strong></p>
                    <p>🚚 Shipping: <strong>Free</strong></p>
                    <p>💳 Total: <strong>$95</strong></p>

                    <form action="checkout" method="post" class="mt-3">
                        <button type="submit" class="save-btn">Proceed to Checkout</button>
                    </form>
                </div>
            </div>
        </div>

        <footer class="footer py-4">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <div class="d-flex justify-content-center mb-3 flex-wrap gap-3">
                            <a href="#">About Us</a>
                            <a href="#">Contact</a>
                            <a href="#">FAQ</a>
                            <a href="#">Terms of Service</a>
                            <a href="#">Privacy Policy</a>
                        </div>
                        <div class="d-flex justify-content-center mb-3 gap-3 social-links">
                            <a href="#" class="text-secondary"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="text-secondary"><i class="bi bi-twitter"></i></a>
                            <a href="#" class="text-secondary"><i class="bi bi-instagram"></i></a>
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
