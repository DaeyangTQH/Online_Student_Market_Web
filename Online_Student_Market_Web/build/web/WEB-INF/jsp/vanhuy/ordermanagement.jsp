<%-- Document : ordermanagement Created on : Jun 9, 2025, 10:34:14 PM Author :
Van Huy --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Quản lí đơn hàng</title>
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
      href="${pageContext.request.contextPath}/resources/css/vanhuy/order.css"
    />
  </head>
  <body>
    <!-- Header -->
    <c:import url="/WEB-INF/jsp/common/header.jsp" />
    <!-- End header -->

    <!--Content-->
    <main>
      <div class="container mt-4">
        <div class="order-management">
          <h2 class="om-title">Quản lý đơn hàng</h2>

          <!-- Hiển thị thông tin đơn hàng được gửi từ OrderManagement.doPost -->
          <c:if test="${not empty fullName}">
            <div class="alert alert-success mt-3">
              <h5 class="mb-3">
                <i class="bi bi-check-circle-fill"></i> 
                Đặt hàng thành công!
              </h5>
              
              <div class="row">
                <div class="col-md-6">
                  <h6 class="mb-2">Thông tin giao hàng</h6>
                  <p class="mb-1"><strong>Họ tên:</strong> ${fullName}</p>
                  <p class="mb-1"><strong>Số điện thoại:</strong> ${phoneNumber}</p>
                  <p class="mb-1"><strong>Email:</strong> ${email}</p>
                  <p class="mb-1"><strong>Địa chỉ giao hàng:</strong> ${shippingAddress}</p>
                  <p class="mb-0"><strong>Phương thức thanh toán:</strong> ${paymentMethod}</p>
                </div>
                <div class="col-md-6">
                  <h6 class="mb-2">Chi tiết đơn hàng</h6>
                  
                  <!-- Buy Now Order -->
                  <c:if test="${orderType == 'buyNow' && not empty orderProduct}">
                    <div class="order-item d-flex align-items-center mb-2">
                      <img src="${orderProduct.image_url}" alt="${orderProduct.product_name}" 
                           class="me-3" style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px;">
                      <div>
                        <p class="mb-0 fw-semibold">${orderProduct.product_name}</p>
                        <p class="mb-0 text-muted small">Số lượng: ${orderQuantity}</p>
                        <p class="mb-0 text-primary fw-bold">
                          <fmt:formatNumber value="${orderProduct.price * orderQuantity}" type="number" pattern="#,##0"/> ₫
                        </p>
                      </div>
                    </div>
                  </c:if>
                  
                  <!-- Checkout Order -->
                  <c:if test="${orderType == 'checkout' && not empty cartItems}">
                    <c:forEach var="item" items="${cartItems}">
                      <div class="order-item d-flex align-items-center mb-2">
                        <img src="${item.product.image_url}" alt="${item.product.product_name}" 
                             class="me-3" style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px;">
                        <div>
                          <p class="mb-0 fw-semibold">${item.product.product_name}</p>
                          <p class="mb-0 text-muted small">Số lượng: ${item.quantity}</p>
                          <p class="mb-0 text-primary fw-bold">
                            <fmt:formatNumber value="${item.product.price * item.quantity}" type="number" pattern="#,##0"/> ₫
                          </p>
                        </div>
                      </div>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
            </div>
          </c:if>

          <!-- Hiển thị các sản phẩm trong giỏ hàng -->
          <c:if test="${not empty cartItems}">
            <div class="mt-4">
              <h5>Sản phẩm đặt hàng</h5>
              <ul class="list-group">
                <c:forEach var="ci" items="${cartItems}">
                  <li
                    class="list-group-item d-flex justify-content-between align-items-center"
                  >
                    ${ci.product.product_name}
                    <span class="badge bg-secondary rounded-pill"
                      >${ci.quantity}</span
                    >
                  </li>
                </c:forEach>
              </ul>
            </div>
          </c:if>

          <!-- Tabs -->
          <ul class="nav nav-tabs" id="orderTab" role="tablist">
            <li class="nav-item" role="presentation">
              <button
                class="nav-link active"
                id="all-tab"
                data-bs-toggle="tab"
                data-bs-target="#all"
                type="button"
                role="tab"
              >
                Tất cả
              </button>
            </li>
            <li class="nav-item" role="presentation">
              <button
                class="nav-link"
                id="pending-tab"
                data-bs-toggle="tab"
                data-bs-target="#pending"
                type="button"
                role="tab"
              >
                Chờ xác nhận
              </button>
            </li>
            <li class="nav-item" role="presentation">
              <button
                class="nav-link"
                id="shipping-tab"
                data-bs-toggle="tab"
                data-bs-target="#shipping"
                type="button"
                role="tab"
              >
                Chờ giao hàng
              </button>
            </li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content pt-4" id="orderTabContent">
            <!-- Tất cả -->
            <div class="tab-pane fade show active" id="all" role="tabpanel">
              <c:forEach var="order" items="${allOrders}">
                <c:set var="item" value="${order.items[0]}" />
                <div
                  class="order-card d-flex align-items-center justify-content-between mb-3"
                >
                  <div>
                    <h5 class="mb-1">${item.productName}</h5>
                    <p class="small text-muted mb-2">
                      ${order.items.size()} sản phẩm
                    </p>
                    <a
                      href="${pageContext.request.contextPath}/order/detail?id=${order.id}"
                      class="btn btn-outline-dark btn-sm"
                      >Xem chi tiết</a
                    >
                  </div>
                  <img
                    src="${item.thumbnailUrl}"
                    alt="${item.productName}"
                    class="order-thumb"
                  />
                </div>
              </c:forEach>
            </div>

            <!-- Chờ xác nhận -->
            <div class="tab-pane fade" id="pending" role="tabpanel">
              <c:forEach var="order" items="${pendingOrders}">
                <%-- Nhúng lại cấu trúc order-card như trên --%>
              </c:forEach>
            </div>

            <!-- Chờ giao hàng -->
            <div class="tab-pane fade" id="shipping" role="tabpanel">
              <div class="order-list">
                <c:forEach var="order" items="${shippingOrders}">
                  <div class="order-list-item">
                    <img
                      src="${order.items[0].thumbnailUrl}"
                      alt="${order.items[0].productName}"
                    />
                    <div>
                      <p class="mb-0 fw-semibold">
                        ${order.items[0].productName}
                      </p>
                      <p class="small text-muted mb-0">
                        Mã đơn hàng: ${order.code}
                      </p>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!--End Content-->
    <!-- Bootstrap Bundle (đã gồm Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Footer -->
    <c:import url="/WEB-INF/jsp/common/footer.jsp" />
  </body>
</html>
