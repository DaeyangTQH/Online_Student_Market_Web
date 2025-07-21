<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>SVMarket - Trang chủ</title>
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
    </head>
    
    <header>
        <div class="navbar">
            <div class="logo"><a href="${pageContext.request.contextPath}/home">SVMarket</a></div>
            <nav>
                <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/category">Danh mục</a>
                <a href="${pageContext.request.contextPath}/cart" class="me-4">Giỏ hàng</a>
                <c:choose>
                    <c:when test="${sessionScope.isLoggedIn}">
                        <a href="${pageContext.request.contextPath}/infouser" class="fw-bold"><span class="">Xin chào, ${sessionScope.user.username}</span></a>
                        <a href="${pageContext.request.contextPath}/logout" class="login-btn">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${pageContext.request.servletPath == '/WEB-INF/jsp/t_son/login.jsp'}">
                                <a href="${pageContext.request.contextPath}/signup" class="signup-btn">Đăng ký</a>
                            </c:when>
                            <c:when test="${pageContext.request.servletPath == '/WEB-INF/jsp/t_son/signup.jsp'}">
                                <a href="${pageContext.request.contextPath}/login" class="login-btn">Đăng nhập</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="login-btn">Đăng nhập</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>
</html>