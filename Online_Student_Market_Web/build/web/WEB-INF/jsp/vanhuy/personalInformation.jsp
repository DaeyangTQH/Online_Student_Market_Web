<%-- Document : personalInformation Created on : Jun 9, 2025, 8:25:10 PM Author
: Van Huy --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Thông tin cá nhân</title>
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
      href="${pageContext.request.contextPath}/resources/css/vanhuy/personalinfomation.css"
    />
  </head>
  <body>
    <!-- include header -->
    <c:import url="/WEB-INF/jsp/common/header.jsp" />

    <!-- Main Content -->

    <div class="container mt-4">
      <div class="row">
        <!-- Personal Information Form -->
        <div class="col-md-8">
          <div class="content-section">
            <h2 class="mb-4">Thông tin cá nhân</h2>

            <!-- DEBUG INFO -->
            <div class="alert alert-warning">
              <strong>DEBUG INFO (personalInformation.jsp):</strong><br />
              - User: ${not empty sessionScope.user ? sessionScope.user.username
              : 'NO USER'}<br />
              - CartId: ${not empty sessionScope.cartId ? sessionScope.cartId :
              'NO CART'}<br />
              - Form will POST to:
              ${pageContext.request.contextPath}/ordermanagement
            </div>

            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty requestScope.errorMessage}">
              <div class="alert alert-danger" role="alert">
                ${requestScope.errorMessage}
              </div>
            </c:if>

            <!-- Hiển thị thông báo thành công -->
            <c:if test="${not empty sessionScope.successMessage}">
              <div class="alert alert-success" role="alert">
                ${sessionScope.successMessage}
              </div>
              <c:remove var="successMessage" scope="session" />
            </c:if>

            <!-- Hiển thị thông báo lỗi từ session -->
            <c:if test="${not empty sessionScope.errorMessage}">
              <div class="alert alert-danger" role="alert">
                ${sessionScope.errorMessage}
              </div>
              <c:remove var="errorMessage" scope="session" />
            </c:if>

            <form
              class="needs-validation"
              method="POST"
              action="${pageContext.request.contextPath}/ordermanagement"
              novalidate
            >
              <div class="mb-3">
                <label for="name" class="form-label">Tên</label>
                <input
                  type="text"
                  class="form-control w-75"
                  id="name"
                  name="fullName"
                  value="${sessionScope.user.full_name}"
                  required
                />
              </div>

              <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input
                  type="tel"
                  class="form-control w-75"
                  id="phone"
                  name="phoneNumber"
                  value="${sessionScope.user.phone_number}"
                  required
                />
              </div>

              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input
                  type="email"
                  class="form-control w-75"
                  id="email"
                  name="email"
                  value="${sessionScope.user.email}"
                  required
                />
              </div>

              <div class="mb-3">
                <label for="address" class="form-label"
                  >Địa chỉ giao hàng</label
                >
                <input
                  type="text"
                  class="form-control w-75"
                  id="address"
                  name="shippingAddress"
                  required
                />
              </div>

              <div class="mb-3">
                <label for="paymentMethod" class="form-label"
                  >Phương thức thanh toán</label
                >
                <select
                  class="form-control w-75"
                  id="paymentMethod"
                  name="paymentMethod"
                  required
                >
                  <option value="">Chọn phương thức thanh toán</option>
                  <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                  <option value="BANK_TRANSFER">Chuyển khoản ngân hàng</option>
                  <option value="CREDIT_CARD">Thẻ tín dụng</option>
                </select>
              </div>

              <div class="text-end mt-4">
                <input
                  type="submit"
                  class="save-btn"
                  value="Lưu thay đổi và đặt hàng"
                />
              </div>
            </form>

            <script>
              document
                .querySelector("form")
                .addEventListener("submit", function (e) {
                  console.log("=== FORM SUBMISSION DEBUG ===");
                  console.log("Form action:", this.action);
                  console.log("Form method:", this.method);
                  console.log("Form data:");
                  const formData = new FormData(this);
                  for (let [key, value] of formData.entries()) {
                    console.log(key + ":", value);
                  }
                  console.log("=== END FORM SUBMISSION DEBUG ===");
                });
            </script>
          </div>
        </div>

        <!-- Purchase History -->
        <div class="col-md-4">
          <div class="content-section">
            <h5 class="mb-4">Lịch sử mua hàng</h5>

            <div class="history-item">
              <div class="history-icon">
                <i class="bi bi-headphones"></i>
              </div>
              <div>
                <div>Tai nghe không dây</div>
                <div class="text-muted small color-text-primary">
                  15/07/2024
                </div>
              </div>
            </div>

            <div class="history-item">
              <div class="history-icon">
                <i class="bi bi-book"></i>
              </div>
              <div>
                <div>Bàn học sinh viên</div>
                <div class="text-muted small color-text-primary">
                  07/07/2024
                </div>
              </div>
            </div>

            <div class="history-item">
              <div class="history-icon">
                <i class="bi bi-journal-text"></i>
              </div>
              <div>
                <div>Sách giáo trình</div>
                <div class="text-muted small color-text-primary">
                  20/06/2024
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <c:import url="/WEB-INF/jsp/common/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
