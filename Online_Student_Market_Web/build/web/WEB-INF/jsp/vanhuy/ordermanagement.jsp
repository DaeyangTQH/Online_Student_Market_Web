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

          <!-- Hiển thị thông báo thành công -->
          <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success mt-3">
              ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session" />
          </c:if>

          <!-- Hiển thị thông báo lỗi -->
          <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger mt-3">
              ${sessionScope.errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session" />
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
              <!-- DEBUG INFO -->
<!--              <div class="alert alert-info">
                <strong>DEBUG:</strong> Số lượng đơn hàng: ${not empty allOrders ? allOrders.size() : 0}<br/>
                Map size: ${not empty orderItemsMap ? orderItemsMap.size() : 0}<br/>
                User ID: ${sessionScope.user != null ? sessionScope.user.user_id : 'null'}
              </div>-->
              
              <c:choose>
                <c:when test="${empty allOrders}">
                  <div class="text-center py-4">
                    <p class="text-muted">Chưa có đơn hàng nào.</p>
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="order" items="${allOrders}">
                    <div class="order-card mb-4 border rounded p-3">
                      <!-- Thông tin đơn hàng -->
                      <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                          <h6 class="mb-1">Đơn hàng #${order.order_id}</h6>
                          <p class="small text-muted mb-1">
                            Ngày đặt: <fmt:formatDate value="${order.order_date}" pattern="dd/MM/yyyy HH:mm" />
                          </p>
                          <p class="small mb-1">
                            Tổng tiền: <strong><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0"/> ₫</strong>
                          </p>
                          <p class="small mb-2">
                            Trạng thái: 
                            <c:choose>
                              <c:when test="${order.status == 'PROCESSING'}">
                                <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                              </c:when>
                              <c:when test="${order.status == 'SHIPPING'}">
                                <span class="badge bg-info">Đang giao hàng</span>
                              </c:when>
                              <c:when test="${order.status == 'DELIVERED'}">
                                <span class="badge bg-success">Đã giao hàng</span>
                              </c:when>
                              <c:otherwise>
                                <span class="badge bg-secondary">${order.status}</span>
                              </c:otherwise>
                            </c:choose>
                          </p>
                          <p class="small text-muted mb-0">
                            Địa chỉ: ${order.shipping_address}
                          </p>
                        </div>
                        <div class="text-end">
                          <p class="small text-muted">${order.payment_method}</p>
                        </div>
                      </div>
                      
                      <!-- Danh sách sản phẩm trong đơn hàng -->
                      <div class="order-products border-top pt-3">
                        <h6 class="mb-2">Sản phẩm đặt hàng:</h6>
                        <!-- DEBUG: Items for order ${order.order_id}: ${not empty orderItemsMap[order.order_id] ? orderItemsMap[order.order_id].size() : 0} -->
                        
                        <c:choose>
                          <c:when test="${empty orderItemsMap[order.order_id]}">
                            <p class="text-muted">Không tìm thấy sản phẩm trong đơn hàng này.</p>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="item" items="${orderItemsMap[order.order_id]}">
                              <div class="d-flex align-items-center mb-2">
                                <img src="${item.product.image_url}" 
                                     alt="${item.product.product_name}" 
                                     class="me-3"
                                     style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">
                                <div class="flex-grow-1">
                                  <p class="mb-1 fw-semibold">${item.product.product_name}</p>
                                  <p class="small text-muted mb-0">
                                    Số lượng: ${item.orderItem.quantity} × 
                                    <fmt:formatNumber value="${item.orderItem.unit_price}" type="number" pattern="#,##0"/> ₫
                                    = <strong><fmt:formatNumber value="${item.orderItem.unit_price * item.orderItem.quantity}" type="number" pattern="#,##0"/> ₫</strong>
                                  </p>
                                </div>
                              </div>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Chờ xác nhận -->
            <div class="tab-pane fade" id="pending" role="tabpanel">
              <c:choose>
                <c:when test="${empty pendingOrders}">
                  <div class="text-center py-4">
                    <p class="text-muted">Không có đơn hàng chờ xác nhận.</p>
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="order" items="${pendingOrders}">
                    <div class="order-card mb-4 border rounded p-3">
                      <!-- Thông tin đơn hàng -->
                      <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                          <h6 class="mb-1">Đơn hàng #${order.order_id}</h6>
                          <p class="small text-muted mb-1">
                            Ngày đặt: <fmt:formatDate value="${order.order_date}" pattern="dd/MM/yyyy HH:mm" />
                          </p>
                          <p class="small mb-1">
                            Tổng tiền: <strong><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0"/> ₫</strong>
                          </p>
                          <p class="small text-muted mb-0">
                            Địa chỉ: ${order.shipping_address}
                          </p>
                        </div>
                        <div class="text-end">
                          <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                          <p class="small text-muted mt-1">${order.payment_method}</p>
                        </div>
                      </div>
                      
                      <!-- Danh sách sản phẩm trong đơn hàng -->
                      <div class="order-products border-top pt-3">
                        <h6 class="mb-2">Sản phẩm đặt hàng:</h6>
                        <!-- DEBUG: Items for order ${order.order_id}: ${not empty orderItemsMap[order.order_id] ? orderItemsMap[order.order_id].size() : 0} -->
                        
                        <c:choose>
                          <c:when test="${empty orderItemsMap[order.order_id]}">
                            <p class="text-muted">Không tìm thấy sản phẩm trong đơn hàng này.</p>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="item" items="${orderItemsMap[order.order_id]}">
                              <div class="d-flex align-items-center mb-2">
                                <img src="${item.product.image_url}" 
                                     alt="${item.product.product_name}" 
                                     class="me-3"
                                     style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">
                                <div class="flex-grow-1">
                                  <p class="mb-1 fw-semibold">${item.product.product_name}</p>
                                  <p class="small text-muted mb-0">
                                    Số lượng: ${item.orderItem.quantity} × 
                                    <fmt:formatNumber value="${item.orderItem.unit_price}" type="number" pattern="#,##0"/> ₫
                                    = <strong><fmt:formatNumber value="${item.orderItem.unit_price * item.orderItem.quantity}" type="number" pattern="#,##0"/> ₫</strong>
                                  </p>
                                </div>
                              </div>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Chờ giao hàng -->
            <div class="tab-pane fade" id="shipping" role="tabpanel">
              <c:choose>
                <c:when test="${empty shippingOrders}">
                  <div class="text-center py-4">
                    <p class="text-muted">Không có đơn hàng đang giao.</p>
                  </div>
                </c:when>
                <c:otherwise>
                  <c:forEach var="order" items="${shippingOrders}">
                    <div class="order-card mb-4 border rounded p-3">
                      <!-- Thông tin đơn hàng -->
                      <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                          <h6 class="mb-1">Đơn hàng #${order.order_id}</h6>
                          <p class="small text-muted mb-1">
                            Ngày đặt: <fmt:formatDate value="${order.order_date}" pattern="dd/MM/yyyy HH:mm" />
                          </p>
                          <p class="small mb-1">
                            Tổng tiền: <strong><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0"/> ₫</strong>
                          </p>
                          <p class="small text-muted mb-0">
                            Địa chỉ: ${order.shipping_address}
                          </p>
                        </div>
                        <div class="text-end">
                          <span class="badge bg-info">Đang giao hàng</span>
                          <p class="small text-muted mt-1">${order.payment_method}</p>
                        </div>
                      </div>
                      
                      <!-- Danh sách sản phẩm trong đơn hàng -->
                      <div class="order-products border-top pt-3">
                        <h6 class="mb-2">Sản phẩm đặt hàng:</h6>
                        <!-- DEBUG: Items for order ${order.order_id}: ${not empty orderItemsMap[order.order_id] ? orderItemsMap[order.order_id].size() : 0} -->
                        
                        <c:choose>
                          <c:when test="${empty orderItemsMap[order.order_id]}">
                            <p class="text-muted">Không tìm thấy sản phẩm trong đơn hàng này.</p>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="item" items="${orderItemsMap[order.order_id]}">
                              <div class="d-flex align-items-center mb-2">
                                <img src="${item.product.image_url}" 
                                     alt="${item.product.product_name}" 
                                     class="me-3"
                                     style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">
                                <div class="flex-grow-1">
                                  <p class="mb-1 fw-semibold">${item.product.product_name}</p>
                                  <p class="small text-muted mb-0">
                                    Số lượng: ${item.orderItem.quantity} × 
                                    <fmt:formatNumber value="${item.orderItem.unit_price}" type="number" pattern="#,##0"/> ₫
                                    = <strong><fmt:formatNumber value="${item.orderItem.unit_price * item.orderItem.quantity}" type="number" pattern="#,##0"/> ₫</strong>
                                  </p>
                                </div>
                              </div>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
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
