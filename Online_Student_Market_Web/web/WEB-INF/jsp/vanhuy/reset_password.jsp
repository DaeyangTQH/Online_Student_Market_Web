<%-- Document : reset_password Created on : Jul 24, 2025, 12:30:00 AM Author :
Admin --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Đổi mật khẩu</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      .reset-container {
        max-width: 500px;
        margin: 100px auto;
        padding: 40px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        background-color: #fff;
      }
      .reset-title {
        text-align: center;
        margin-bottom: 30px;
        color: #333;
        font-weight: 600;
      }
      .form-control {
        margin-bottom: 20px;
        padding: 12px;
        border-radius: 8px;
        border: 1px solid #ddd;
      }
      .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
      }
      .btn-submit {
        width: 100%;
        background-color: #28a745;
        border-color: #28a745;
        padding: 12px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 8px;
      }
      .btn-submit:hover {
        background-color: #218838;
        border-color: #1e7e34;
      }
      .password-requirements {
        font-size: 12px;
        color: #6c757d;
        margin-top: -15px;
        margin-bottom: 20px;
      }
      .alert {
        border-radius: 8px;
        font-weight: 500;
      }
    </style>
  </head>
  <body class="bg-light">
    <div class="container">
      <div class="reset-container">
        <h2 class="reset-title">Đặt lại mật khẩu</h2>

        <!-- Hiển thị thông báo lỗi -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger text-center">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <strong>${error}</strong>
          </div>
        </c:if>

        <div class="alert alert-info text-center">
          <i class="bi bi-shield-check"></i>
          Xác thực OTP thành công! Vui lòng nhập mật khẩu mới.
        </div>

        <form
          action="${pageContext.request.contextPath}/reset_password"
          method="post"
        >
          <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới:</label>
            <input
              type="password"
              class="form-control"
              id="newPassword"
              name="newPassword"
              placeholder="Nhập mật khẩu mới"
              required
              minlength="6"
            />
            <div class="password-requirements">
              Mật khẩu phải có ít nhất 6 ký tự
            </div>
          </div>

          <div class="mb-4">
            <label for="confirmPassword" class="form-label"
              >Xác nhận mật khẩu:</label
            >
            <input
              type="password"
              class="form-control"
              id="confirmPassword"
              name="confirmPassword"
              placeholder="Nhập lại mật khẩu mới"
              required
              minlength="6"
            />
          </div>

          <button type="submit" class="btn btn-success btn-submit">
            <i class="bi bi-key-fill"></i>
            Đổi mật khẩu
          </button>
        </form>

        <div class="text-center mt-3">
          <small class="text-muted">
            Sau khi đổi mật khẩu thành công, bạn sẽ được chuyển về trang chủ
          </small>
        </div>
      </div>
    </div>

    <!-- Bootstrap Icons -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // Kiểm tra mật khẩu xác nhận
      document
        .getElementById("confirmPassword")
        .addEventListener("input", function () {
          const password = document.getElementById("newPassword").value;
          const confirmPassword = this.value;

          if (password !== confirmPassword) {
            this.setCustomValidity("Mật khẩu xác nhận không khớp");
          } else {
            this.setCustomValidity("");
          }
        });

      document
        .getElementById("newPassword")
        .addEventListener("input", function () {
          const confirmPassword = document.getElementById("confirmPassword");
          if (confirmPassword.value) {
            confirmPassword.dispatchEvent(new Event("input"));
          }
        });
    </script>
  </body>
</html>
