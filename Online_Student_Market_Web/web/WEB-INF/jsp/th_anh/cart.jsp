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
            .card, .list-group-item {
                background-color: #fff6f0;
            }
            .quantity-group {
                display: flex;
                align-items: center;
                gap: 4px;
            }
            .quantity-group input {
                width: 36px;
                text-align: center;
                font-size: 14px;
                padding: 2px;
            }
            .quantity-btn {
                padding: 2px 6px;
                font-size: 14px;
                line-height: 1;
            }
        </style>
    </head>

    <body>
        <!--header-->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!--end header-->

        <div class="container my-5">
            <div class="content-section container my-5 auto" style="max-width:700px">
                <h2>Giỏ hàng</h2>

                <c:forEach var="item" items="${cartItems}">
                    <div class="history-item justify-content-between d-flex align-items-center mb-3">
                        <div class="item-info">
                            <div>${item.name}</div>
                            <div class="item-quantity mt-1 quantity-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary quantity-btn" onclick="decreaseQty(this)">-</button>
                                <input type="text" class="form-control form-control-sm quantity-input" 
                                       value="${item.quantity}" data-price="${item.price}" readonly />
                                <button type="button" class="btn btn-sm btn-outline-secondary quantity-btn" onclick="increaseQty(this)">+</button>
                            </div>
                        </div>
                        <span class="item-price">$${item.price * item.quantity}</span>
                    </div>
                </c:forEach>


                <!-- Tóm tắt đơn hàng -->
                <div class="content-section mt-4">
                    <h5>Tóm tắt đơn hàng</h5>
                    <p>🧾 Đơn hàng: <strong id="subtotal">$95</strong></p>
                    <p>🚚 Phí ship: <strong>Miễn phí</strong></p>
                    <p>💳 Tổng: <strong id="total">$95</strong></p>

                    <form action="${pageContext.request.contextPath}/personalinformation" method="post" class="mt-3">
                        <a href="${pageContext.request.contextPath}/personalinformation"><button type="submit" class="save-btn">Tiến hành thanh toán</button></a>

                    </form>
                </div>
            </div>
        </div>

        <!--footer-->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
        <!--end footer-->

        <!-- JavaScript cập nhật số lượng và tổng tiền -->
        <script>
            function updateTotal() {
                const inputs = document.querySelectorAll('.quantity-input');
                let subtotal = 0;

                inputs.forEach(input => {
                    const price = parseFloat(input.dataset.price);
                    const quantity = parseInt(input.value);
                    const itemTotal = price * quantity;
                    subtotal += itemTotal;

                    const itemPriceSpan = input.closest('.history-item').querySelector('.item-price');
                    itemPriceSpan.textContent = '$' + itemTotal;
                });

                document.getElementById('subtotal').textContent = '$' + subtotal;
                document.getElementById('total').textContent = '$' + subtotal;
            }

            function increaseQty(button) {
                const input = button.parentNode.querySelector('input');
                input.value = parseInt(input.value) + 1;
                updateTotal();
            }

            function decreaseQty(button) {
                const input = button.parentNode.querySelector('input');
                const current = parseInt(input.value);
                if (current > 1) {
                    input.value = current - 1;
                    updateTotal();
                }
            }

            window.onload = updateTotal;
        </script>
    </body>
</html>
