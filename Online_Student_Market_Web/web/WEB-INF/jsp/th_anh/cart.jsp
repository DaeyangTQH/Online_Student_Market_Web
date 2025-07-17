<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/th_anh/stylecart.css" />
        <style>
            .product-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                margin-right: 10px;
                border-radius: 8px;
            }
            .quantity-group {
                display: flex;
                align-items: center;
                gap: 5px;
                margin-top: 5px;
            }
            .quantity-group input {
                width: 40px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>

        <div class="container my-5" style="max-width: 700px;">
            <div class="content-section">
                <h2>🛒 Giỏ hàng</h2>

                <!-- ✅ Thông báo -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-info text-center">${sessionScope.message}</div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <c:choose>
                    <c:when test="${empty sessionScope.cart}">
                        <p>Không có sản phẩm nào trong giỏ hàng.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <div class="history-item d-flex justify-content-between align-items-center mb-3">
                                <div class="d-flex align-items-center" style="flex: 1;">
                                    <img src="${item.product.image_url}" alt="${item.product.product_name}" class="product-img">
                                    <div>
                                        <strong>${item.product.product_name}</strong>
                                        <div class="quantity-group">
                                            <button class="btn btn-sm btn-outline-secondary" onclick="decreaseQty(this)">-</button>
                                            <input type="text" class="form-control form-control-sm quantity-input"
                                                   value="${item.quantity}" data-price="${item.product.price}" readonly />
                                            <button class="btn btn-sm btn-outline-secondary" onclick="increaseQty(this)">+</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <div>đ<span class="item-price">${item.product.price * item.quantity}</span></div>
                                    <form action="${pageContext.request.contextPath}/removeCartItem" method="post"
                                          onsubmit="return confirm('Bạn có chắc muốn xoá sản phẩm này không?');">
                                        <input type="hidden" name="cartItemId" value="${item.product.product_id}" />
                                        <button type="submit" class="btn btn-sm btn-danger mt-2">Xóa</button>
                                    </form>

                                </div>
                            </div>
                        </c:forEach>

                        <!-- ✅ Tóm tắt -->
                        <div class="content-section mt-4 text-center">
                            <h5>Tóm tắt đơn hàng</h5>
                            <p>🧾 Tạm tính: <strong id="subtotal">đ0</strong></p>
                            <p>🚚 Phí ship: <strong>Miễn phí</strong></p>
                            <p>💳 Tổng thanh toán: <strong id="total">đ0</strong></p>

                            <form action="${pageContext.request.contextPath}/personalinformation" method="post">
                                <button type="submit" class="save-btn mt-3">Tiến hành thanh toán</button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>

        <!-- ✅ Tính lại giá khi thay đổi -->
        <script>
            function updateTotal() {
                const inputs = document.querySelectorAll('.quantity-input');
                let subtotal = 0;
                inputs.forEach(input => {
                    const price = parseFloat(input.dataset.price);
                    const quantity = parseInt(input.value);
                    subtotal += price * quantity;
                    const span = input.closest('.history-item').querySelector('.item-price');
                    span.textContent = (price * quantity).toFixed(2);
                });
                document.getElementById('subtotal').textContent = 'đ' + subtotal.toFixed(2);
                document.getElementById('total').textContent = 'đ' + subtotal.toFixed(2);
            }

            function increaseQty(btn) {
                const input = btn.parentNode.querySelector('input');
                input.value = parseInt(input.value) + 1;
                updateTotal();
            }

            function decreaseQty(btn) {
                const input = btn.parentNode.querySelector('input');
                if (parseInt(input.value) > 1) {
                    input.value = parseInt(input.value) - 1;
                    updateTotal();
                }
            }

            window.onload = updateTotal;
        </script>
    </body>
</html>