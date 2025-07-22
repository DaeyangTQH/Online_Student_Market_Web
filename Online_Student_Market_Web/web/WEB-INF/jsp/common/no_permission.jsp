<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Không đủ quyền truy cập</title>
    <style>
        body { font-family: Arial; background: #f5f5f5; }
        .container { width: 400px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px #ccc; text-align: center; }
        h1 { color: #d9534f; }
        .message { margin-top: 20px; font-size: 18px; color: #333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Không đủ quyền truy cập</h1>
        <div class="message">
            <c:out value="${errorMessage}"/>
        </div>
        <a href="${pageContext.request.contextPath}/home">Quay về trang chủ</a>
    </div>
</body>
</html> 