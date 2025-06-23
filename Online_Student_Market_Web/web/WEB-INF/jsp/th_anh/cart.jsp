<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <!--header-->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!--end header-->

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
        
        <!--footer-->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
        <!--end footer-->   
    </body>
</html>
