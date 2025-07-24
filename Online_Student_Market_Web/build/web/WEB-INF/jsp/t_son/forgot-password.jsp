<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Forgot Password</title>
        <style>
            
        </style>

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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>

        <h2>Reset Your Password</h2>

        <form action="otp_email" method="get">
            <label>Email:</label><br>
            <input type="email" name="email" placeholder="Enter your email" required><br>

            <button type="submit">Update Password</button>
        </form>

        <div class="message">${error}</div>

        <c:import url="/WEB-INF/jsp/common/footer.jsp" />
    </body>
</html>