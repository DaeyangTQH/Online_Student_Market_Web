<%-- 
    Document   : otp_email
    Created on : Jul 24, 2025, 12:13:46 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác thực OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .otp-container {
                max-width: 400px;
                margin: 100px auto;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 10px;
            }
            .otp-title {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }
            .form-control {
                margin-bottom: 20px;
            }
            .btn-submit {
                width: 100%;
                background-color: #007bff;
                border-color: #007bff;
                padding: 12px;
                font-size: 16px;
            }
            .btn-submit:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="otp-container">
                <h2 class="otp-title">Xác thực OTP</h2>

                <!-- Hiển thị thông báo thành công -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success text-center">
                        <strong>✓ ${success}</strong>
                        <br><br>
                        <p class="mb-0">Bạn đã xác thực thành công OTP!</p>
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                                Đăng nhập ngay
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Chỉ hiển thị form khi chưa thành công -->
                <c:if test="${empty success}">
                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center">
                            <strong>✗ ${error}</strong>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/otp_email" method="post">
                        <div class="mb-3">
                            <label for="otp" class="form-label">Mã OTP:</label>
                            <input type="text" class="form-control" id="otp" name="otp" 
                                   placeholder="Nhập mã OTP đã gửi về email của bạn" 
                                   required maxlength="6" 
                                   style="text-align: center; font-size: 18px; letter-spacing: 5px;">
                        </div>

                        <button type="submit" class="btn btn-primary btn-submit">
                            Xác thực OTP
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <small class="text-muted">
                            Vui lòng kiểm tra email của bạn để lấy mã OTP
                        </small>
                    </div>

                    <div class="text-center mt-2">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">
                            <small>← Quay lại nhập email</small>
                        </a>
                    </div>
                </c:if>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
