<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - SVMarket</title>
    <link rel="stylesheet" href="styles/login.css">
</head>
<body>
<header>
    <div class="navbar">
        <div class="logo">SVMarket</div>
        <nav>
            <a href="#">Home</a>
            <a href="#">Categories</a>
            <a href="#">Sell</a>
            <a href="signup.jsp" class="signup-btn">Sign up</a>
        </nav>
    </div>
</header>

<main class="login-container">
    <h1>Welcome back</h1>
    <form action="login" method="post" class="login-form">
        <label for="username">Username or email</label>
        <input type="text" id="username" name="username" placeholder="Enter your username or email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>

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

