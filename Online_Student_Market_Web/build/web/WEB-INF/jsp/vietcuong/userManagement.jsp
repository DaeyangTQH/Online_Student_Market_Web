<%-- 
    Document   : userManagement
    Created on : Jul 21, 2025, 9:06:59 PM
    Author     : Haichann
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý User</title>
        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
            }
            .container {
                width: 900px;
                margin: 40px auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px #ccc;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background: #007bff;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Quản lý User</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Email</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.user_id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <a href="<c:url value='/admin' />">Quay lại Dashboard</a>
        </div>
    </body>
</html>
