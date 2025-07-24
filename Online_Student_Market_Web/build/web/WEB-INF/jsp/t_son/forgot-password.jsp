<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Forgot Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/main.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/tson/home.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/tson/forgot-password.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <c:import url="/WEB-INF/jsp/common/header.jsp" />

    <div class="forgot-password-container">
      <div class="forgot-password-card">
        <!-- Icon -->
        <div class="forgot-password-icon">
          <i class="bi bi-shield-lock"></i>
        </div>

        <!-- Title and Subtitle -->
        <h2 class="forgot-password-title">Reset Your Password</h2>
        <p class="forgot-password-subtitle">
          Don't worry! Enter your email address and we'll send you instructions
          to reset your password.
        </p>

        <!-- Form -->
        <form action="otp_email" method="get">
          <div class="form-group">
            <label class="form-label">Email Address:</label>
            <input
              type="email"
              name="email"
              class="form-input"
              placeholder="Enter your email address"
              required
            />
          </div>

          <button type="submit" class="btn-reset">
            <i class="bi bi-arrow-right-circle me-2"></i>Send Reset Instructions
          </button>
        </form>

        <!-- Error Message -->
        <c:if test="${not empty error}">
          <div class="message error">${error}</div>
        </c:if>

        <!-- Back to Login Link -->
        <div class="back-to-login">
          <a href="${pageContext.request.contextPath}/login">
            <i class="bi bi-arrow-left me-1"></i>Back to Login
          </a>
        </div>
      </div>
    </div>

    <c:import url="/WEB-INF/jsp/common/footer.jsp" />
  </body>
</html>
