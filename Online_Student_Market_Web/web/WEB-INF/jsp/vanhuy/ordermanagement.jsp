<%-- 
    Document   : ordermanagement
    Created on : Jun 9, 2025, 10:34:14 PM
    Author     : Van Huy
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng</title>
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
            href="${pageContext.request.contextPath}/resources/css/vanhuy/order.css"
            />
    </head>
    <body>
        <!-- Header -->
         <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!-- End header -->
        
        <!--Content-->
        <main>
        <div class="container mt-4">
            
        </div>
        </main>
        <!--End Content-->

        <!-- Footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
    </body>
</html>
