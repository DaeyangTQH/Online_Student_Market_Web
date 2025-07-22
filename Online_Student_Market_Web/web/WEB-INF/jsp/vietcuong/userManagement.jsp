<%-- 
    Document   : userManagement
    Created on : Jul 21, 2025, 9:06:59 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
    <head>
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
            .ban-btn {
                background: #dc3545;
                color: #fff;
                border: none;
                padding: 7px 15px;
                border-radius: 4px;
                cursor: pointer;
            }
            .unban-btn {
                background: #28a745;
                color: #fff;
                border: none;
                padding: 7px 15px;
                border-radius: 4px;
                cursor: pointer;
            }
            .ban-btn:hover, .unban-btn:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Quản lý User</h2>
            <table>
                <tr>
                    <th>ID</th><th>Tên</th><th>Email</th><th>Trạng thái</th><th>Hành động</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.user_id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.banned}">Bị chặn</c:when>
                                <c:otherwise>Hoạt động</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form action="userManagement" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn ${user.banned ? 'mở chặn' : 'chặn'} user này?');">
                                <input type="hidden" name="userId" value="${user.user_id}" />
                                <input type="hidden" name="action" value="${user.banned ? 'unban' : 'ban'}" />
                                <input type="submit" class="${user.banned ? 'unban-btn' : 'ban-btn'}" value="${user.banned ? 'Unban' : 'Ban'}" />
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <a href="<c:url value='/admin'/>">Quay lại Dashboard</a>
        </div>
    </body>
</html>
