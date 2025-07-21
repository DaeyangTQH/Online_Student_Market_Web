<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
            }
            .container {
                width: 400px;
                margin: 60px auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px #ccc;
            }
            h1 {
                text-align: center;
            }
            .admin-menu {
                list-style: none;
                padding: 0;
            }
            .admin-menu li {
                margin: 20px 0;
            }
            .admin-menu a {
                display: block;
                background: #007bff;
                color: #fff;
                text-decoration: none;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
                font-size: 18px;
                transition: background 0.2s;
            }
            .admin-menu a:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Admin Management</h1>
            <ul class="admin-menu">
                <li><a href="userManagement">Quản lý User</a></li>
                <li><a href="categoryManagement">Quản lý Category</a></li>
                <li><a href="productManagement">Quản lý Product</a></li>
            </ul>
        </div>
    </body>
</html>