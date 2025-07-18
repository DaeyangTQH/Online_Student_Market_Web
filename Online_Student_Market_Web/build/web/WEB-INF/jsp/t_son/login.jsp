<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
    prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Login - SVMarket</title>
            <title>SVMarket - Login</title>
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
                href="${pageContext.request.contextPath}/resources/css/tson/login.css"
                />
        </head>
        <body>
            <header>
                <div class="navbar">
                    <div class="logo">SVMarket</div>
                    <nav>
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <a href="${pageContext.request.contextPath}/category">Categories</a>
                        <a href="#">Sell</a>
                        <a href="${pageContext.request.contextPath}/signup" class="signup-btn"
                           >Sign up</a
                        >
                    </nav>
                </div>
            </header>

            <main class="login-container">
                <h1>Welcome back</h1>
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-warning text-center">${sessionScope.message}</div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">${errorMessage}</div>
                </c:if>

                <form
                    action="${pageContext.request.contextPath}/login"
                    method="post"
                    class="login-form"
                    >
                    <label for="username">Username or email</label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username or email"
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

                    <div class="forgot-password">
                        <a href="#">Forgot password?</a>
                    </div>

                    <button type="submit" class="login-btn">Log in</button>
                </form>
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
                <p>© 2024 SVMarket. All rights reserved.</p>
            </footer>
        </body>
    </html>
