<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Sign Up - SVMarket</title>
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
      href="${pageContext.request.contextPath}/resources/css/tson/signup.css"
    />
  </head>
  <body>
    <header>
      <div class="navbar">
        <div class="logo">SVMarket</div>
        <nav>
          <a href="#">Home</a>
          <a href="#">Categories</a>
          <a href="#">Sell</a>
          <a href="login.jsp" class="signup-btn">Log in</a>
        </nav>
      </div>
    </header>

    <main class="signup-container">
      <h1>Create a New Account</h1>
      <form action="signup" method="post" class="signup-form">
        <label for="username">Username</label>
        <input
          type="text"
          id="username"
          name="username"
          placeholder="Enter your username"
          required
        />

        <label for="email">Email</label>
        <input
          type="email"
          id="email"
          name="email"
          placeholder="Enter your email"
          required
        />

        <label for="password">Password</label>
        <input
          type="password"
          id="password"
          name="password"
          placeholder="Enter your password"
          required
        />

        <label for="confirm-password">Confirm Password</label>
        <input
          type="password"
          id="confirm-password"
          name="confirm-password"
          placeholder="Confirm your password"
          required
        />

        <button type="submit" class="signup-btn">Sign Up</button>
      </form>

      <div class="login-link">
        <p>
          Already have an account?
          <a href="${pageContext.request.contextPath}">Log in here</a>
        </p>
      </div>
    </main>

    <footer>
      <div class="footer-links">
        <a href="#">About SVMarket</a>
        <a href="#">Terms of Service</a>
        <a href="#">Privacy Policy</a>
        <a href="#">Contact Us</a>
      </div>
      <div class="social-icons">
        <i class="fa fa-facebook"></i>
        <i class="fa fa-twitter"></i>
        <i class="fa fa-instagram"></i>
      </div>
      <p>© 2025 SVMarket. All rights reserved.</p>
    </footer>
  </body>
</html>
