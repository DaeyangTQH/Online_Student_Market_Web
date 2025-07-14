<%-- 
    Document   : info_account
    Created on : Jun 22, 2025, 10:35:10 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông tin người dùng</title>
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
            href="${pageContext.request.contextPath}/resources/css/vanhuy/infoUser.css"
            />
    </head>
    <body>

        <!-- include header -->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>

        <c:choose>
            <c:when test="${sessionScope.isLoggedIn}">
                
                <div class="welcome-section">
                    <div class="welcome-image">
                        <i class="bi bi-person-check welcome-icon"></i>
                    </div>
                    <div class="welcome-content">
                        <div class="user-info-card">
                            <h2 class="mb-4">Thông tin người dùng</h2>

                            <div class="d-flex align-items-center mb-3">
                                <div class="user-avatar">
                                    ${fn:toUpperCase(
                                      fn:substring(
                                      fn:split(sessionScope.user.full_name, ' ')[fn:length(fn:split(sessionScope.user.full_name, ' ')) - 1],
                                      0, 1
                                      )
                                      )}
                                </div>
                                <div class="ms-3">
                                    <h4 class="mb-1">${sessionScope.user.full_name}</h4>
                                    <p class="text-muted mb-0">@${sessionScope.user.username}</p>
                                    <small class="text-muted">${sessionScope.user.email}</small>
                                </div>
                            </div>

                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-number">0</div>
                                    <div class="text-muted">Sản phẩm đã bán</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number">0</div>
                                    <div class="text-muted">Đang bán</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number">0</div>
                                    <div class="text-muted">Đã mua</div>
                                </div>
                            </div>

                            <div class="mt-4">
                                <h6>Thông tin tài khoản:</h6>
                                <p><strong>Vai trò:</strong> ${sessionScope.user.role}</p>
                                <p><strong>Số điện thoại:</strong> ${sessionScope.user.phone_number}</p>
                                <p><strong>Ngày tham gia:</strong> ${sessionScope.user.created_at}</p>
                            </div>

                            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>

            </c:otherwise>
        </c:choose>

        <!-- include footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
    </body>
</html>
