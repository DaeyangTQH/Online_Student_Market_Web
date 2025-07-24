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
                <div class="dropdown category-dropdown" style="display:inline-block; position:relative;">
                    <a href="${pageContext.request.contextPath}/category" class="dropdown-toggle" id="categoryDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Danh mục 
                    </a>
                    <ul class="dropdown-menu category-menu" aria-labelledby="categoryDropdown" style="min-width:220px;">
                        <c:forEach var="cat" items="${categories}">
                            <li class="dropdown-submenu position-relative">
                                <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/subcategory?cid=${cat.category_id}">
                                    ${cat.category_name}
                                </a>
                                <ul class="dropdown-menu subcategory-menu position-absolute start-100 top-0" style="min-width:200px;">
                                    <c:forEach var="sub" items="${subCategories}">
                                        <c:if test="${sub.category_id == cat.category_id}">
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/productList?subCategoryId=${sub.subCategory_id}">${sub.subCategory_name}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <a href="${pageContext.request.contextPath}/cart" class="me-4">Giỏ hàng</a>
                <c:choose>
                    <c:when test="${sessionScope.isLoggedIn}">
                        <div class="dropdown user-dropdown" style="display:inline-block; position:relative;">
                            <a href="#" class="fw-bold dropdown-toggle user-dropdown-toggle" id="userDropdown" role="button" aria-expanded="false">
                                <span class="">Xin chào, ${sessionScope.user.username}</span>
                            </a>
                            <ul class="dropdown-menu user-menu" aria-labelledby="userDropdown" style="min-width:200px;">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/infouser">
                                        <i class="bi bi-person-circle me-2"></i>Tài Khoản Của Tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/ordermanagement">
                                        <i class="bi bi-bag-check me-2"></i>Đơn Mua
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng Xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
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
    <style>
        .category-dropdown {
            position: relative;
            display: inline-block;
        }
        .category-dropdown .dropdown-toggle {
            font-weight: 500;
            /*color: #ff6b35;*/
            background: none;
            border: none;
            outline: none;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 16px;
            transition: color 0.3s, background 0.3s;
        }
        .category-dropdown .dropdown-toggle:hover,
        .category-dropdown .dropdown-toggle:focus {
            color: #d35400;
            background: #fff3eb;
        }
        .category-dropdown .dropdown-menu {
            display: none;
            position: absolute;
            left: 0;
            right: unset;
            top: 100%;
            z-index: 1000;
            background: #fff;
            border: none;
            box-shadow: 0 8px 32px rgba(255,107,53,0.10);
            min-width: 220px;
            padding: 0.5rem 0;
            border-radius: 12px;
            margin-top: 6px;
            transition: box-shadow 0.25s;
        }
        .category-dropdown:hover > .dropdown-menu {
            display: block;
        }
        .dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu > .dropdown-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 500;
            color: #222;
            border-radius: 8px;
            padding: 10px 22px;
            transition: background 0.25s, color 0.25s;
        }
        .dropdown-submenu > .dropdown-item:hover,
        .dropdown-submenu > .dropdown-item:focus {
            color: #ff6b35;
            background: #fff3eb;
        }
        .dropdown-submenu > .subcategory-menu {
            display: none;
            position: absolute;
            left: 100%;
            right: unset;
            top: 0;
            min-width: 180px;
            background: #fff;
            box-shadow: 0 8px 32px rgba(255,107,53,0.10);
            border-radius: 12px;
            padding: 0.5rem 0;
            margin-left: 4px;
            transition: box-shadow 0.25s;
        }
        .dropdown-submenu:hover > .subcategory-menu {
            display: block;
        }
        .subcategory-menu .dropdown-item {
            padding-left: 2rem;
            color: #444;
            font-weight: 400;
            border-radius: 8px;
            transition: background 0.25s, color 0.25s;
        }
        .subcategory-menu .dropdown-item:hover,
        .subcategory-menu .dropdown-item:focus {
            color: #ff6b35;
            background: #fff3eb;
        }
        .dropdown-item {
            cursor: pointer;
            border-radius: 8px;
            padding: 10px 22px;
            transition: background 0.25s, color 0.25s;
        }
        .dropdown-item i.bi {
            margin-left: 8px;
            font-size: 0.9em;
        }
        /* User Dropdown Styles */
        .user-dropdown {
            position: relative;
            display: inline-block;
        }
        .user-dropdown .user-dropdown-toggle {
            font-weight: 500;
            color: #333;
            background: none;
            border: none;
            outline: none;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 16px;
            text-decoration: none;
            transition: color 0.3s, background 0.3s;
        }
        .user-dropdown .user-dropdown-toggle:hover,
        .user-dropdown .user-dropdown-toggle:focus {
            color: #ff6b35;
            background: #fff3eb;
            text-decoration: none;
        }
        .user-dropdown .user-menu {
            display: none;
            position: absolute;
            right: -50px;
            left: unset;
            top: 100%;
            z-index: 1000;
            background: #fff;
            border: none;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
            min-width: 220px;
            padding: 0.5rem 0;
            border-radius: 12px;
            margin-top: 6px;
            transition: box-shadow 0.25s;
        }
        .user-dropdown:hover > .user-menu {
            display: block;
        }
        .user-menu .dropdown-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            font-weight: 400;
            border-radius: 8px;
            margin: 2px 8px;
            transition: background 0.25s, color 0.25s;
        }
        .user-menu .dropdown-item:hover,
        .user-menu .dropdown-item:focus {
            color: #ff6b35;
            background: #fff3eb;
            text-decoration: none;
        }
        .user-menu .dropdown-item i {
            font-size: 16px;
            width: 20px;
        }
        .user-menu .dropdown-divider {
            margin: 8px 0;
            border-top: 1px solid #eee;
        }
        @media (max-width: 900px) {
            .category-dropdown .dropdown-menu,
            .dropdown-submenu > .subcategory-menu {
                min-width: 140px;
            }
            .subcategory-menu .dropdown-item {
                padding-left: 1.2rem;
            }
            .user-dropdown .user-menu {
                min-width: 180px;
            }
        }
    </style>
</html>