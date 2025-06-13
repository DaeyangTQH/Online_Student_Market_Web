<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
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
            href="${pageContext.request.contextPath}/resources/css/tson/style.css"
            />
</head>
<body>
<div class="container">
    <div class="header">
        <div class="logo">SVMarket</div>
        <div class="nav">
            <a href="#">Home</a>
            <a href="#">Categories</a>
            <a href="#">Sell</a>
            <a href="register.jsp"><button class="signup">Sign up</button></a>
        </div>
    </div>

    <h1>Welcome back</h1>
    <form action="login" method="post">
        <label>Username or email</label><br>
        <input type="text" name="username" placeholder="Enter your username or email" required><br>

        <label>Password</label><br>
        <input type="password" name="password" placeholder="Enter your password" required><br>

        <a href="#">Forgot password?</a><br>
        <button type="submit">Log in</button>
    </form>

    <div class="footer">
        <a href="#">About SVMarket</a>
        <a href="#">Terms of Service</a>
        <a href="#">Privacy Policy</a>
        <a href="#">Contact Us</a>
        <div class="socials">
            <span>🌐</span><span>🐦</span><span>📷</span>
        </div>
        <p>© 2024 SVMarket. All rights reserved.</p>
    </div>
</div>
</body>
</html>
