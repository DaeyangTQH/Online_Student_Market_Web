
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 60px;
        }
        form {
            display: inline-block;
            text-align: left;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        input {
            width: 300px;
            padding: 10px;
            margin: 8px 0;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #2e8b57;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #246b45;
        }
        .message {
            margin-top: 20px;
            color: green;
        }
    </style>
</head>
<body>

    <h2>Reset Your Password</h2>

    <form action="forgot-password" method="post">
        <label>Email:</label><br>
        <input type="email" name="email" placeholder="Enter your email" required><br>

        <label>New Password:</label><br>
        <input type="password" name="newPassword" placeholder="Enter new password" required><br>

        <button type="submit">Update Password</button>
    </form>

    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>

</body>
</html>
