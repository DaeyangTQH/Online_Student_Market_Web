<%-- 
    Document   : editlisting
    Created on : Jun 17, 2025, 1:46:57 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Listing page</title>

        <%-- CSS chính của hệ thống (nếu có) --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />

        <%-- CSS riêng cho trang chỉnh sửa tin đăng --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vietcuong/editlisting.css" />

        <%-- Bootstrap 5 để dùng các class tiện lợi như form, container, grid --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

        <%-- Bootstrap Icons để dùng các icon như Facebook, Instagram... --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
    </head>

    <body>

        <%-- PHẦN NAVBAR (Thanh điều hướng đầu trang) --%>
        <nav class="navbar navbar-expand-lg bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">SVMarket</a>
                <div class="collapse navbar-collapse justify-content-end">
                    <ul class="navbar-nav mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="#">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Khám phá</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Yêu thích</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Tin nhắn</a></li>
                        <li class="nav-item">
                            <%-- Avatar người dùng --%>
                            <img src="https://i.pinimg.com/736x/a6/16/28/a6162845747ab6f081706e9a00552a13.jpg" class="avatar-img" alt="Avatar">
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <%-- PHẦN FORM CHỈNH SỬA TIN --%>
        <div class="container py-5 mx-auto" style="max-width: 600px;">
            <h2 class="fw-bold mb-4">Chỉnh sửa tin đăng</h2>
            <form>
                <%-- Nhập tiêu đề tin --%>
                <div class="mb-3">
                    <label class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" placeholder="Nhập tiêu đề...">
                </div>

                <%-- Nhập mô tả chi tiết --%>
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea class="form-control" rows="4" placeholder="Nhập mô tả..."></textarea>
                </div>

                <%-- Hộp tải hình ảnh --%>
                <div class="mb-4">
                    <label class="form-label">Hình ảnh</label>
                    <div class="image-upload-box text-center border rounded-3 py-5 px-3">
                        <p class="text-muted">Kéo và thả hoặc nhấp để tải lên</p>
                        <p class="small">Tải lên tối đa 5 hình ảnh</p>
                        <button type="button" class="btn btn-light border">Tải lên</button>
                    </div>
                </div>

                <%-- Nhập giá sản phẩm/dịch vụ --%>
                <div class="mb-3">
                    <label class="form-label">Giá</label>
                    <input type="text" class="form-control" placeholder="Nhập giá...">
                </div>

                <%-- Nhập danh mục --%>
                <div class="mb-4">
                    <label class="form-label">Danh mục</label>
                    <input type="text" class="form-control" placeholder="Nhập danh mục...">
                </div>

                <%-- Nút gửi form --%>
                <button type="submit" class="btn btn-primary w-100 rounded-pill bg-light border text-dark">
                    Cập nhật tin đăng
                </button>
            </form>
        </div>

        <%-- PHẦN FOOTER (chân trang) --%>
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>

    </body>
</html>

