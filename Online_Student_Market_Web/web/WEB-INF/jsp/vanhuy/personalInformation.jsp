<%-- Document : personalInformation Created on : Jun 9, 2025, 8:25:10 PM Author
: Van Huy --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Thông tin cá nhân</title>
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
            href="${pageContext.request.contextPath}/resources/css/vanhuy/personalinfomation.css"
            />


    </head>
    <body>
        <!-- include header -->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>

        <!-- Main Content -->

        <div class="container mt-4">
            <div class="row">
                <!-- Personal Information Form -->
                <div class="col-md-8">
                    <div class="content-section">
                        <h2 class="mb-4">Thông tin cá nhân</h2>

                        <form class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="name" class="form-label">Tên</label>
                                <input
                                    type="text"
                                    class="form-control w-75"
                                    id="name"
                                    required
                                    />
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input
                                    type="tel"
                                    class="form-control w-75"
                                    id="phone"
                                    required
                                    />
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input
                                    type="email"
                                    class="form-control w-75"
                                    id="email"
                                    required
                                    />
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label"
                                       >Địa chỉ giao hàng</label
                                >
                                <input
                                    type="text"
                                    class="form-control w-75"
                                    id="address"
                                    required
                                    />
                            </div>

                            <div class="text-end mt-4">
                                <button type="submit" class="save-btn">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Purchase History -->
                <div class="col-md-4">
                    <div class="content-section">
                        <h5 class="mb-4">Lịch sử mua hàng</h5>

                        <div class="history-item">
                            <div class="history-icon">
                                <i class="bi bi-headphones"></i>
                            </div>
                            <div>
                                <div>Tai nghe không dây</div>
                                <div class="text-muted small color-text-primary">15/07/2024</div>
                            </div>
                        </div>

                        <div class="history-item">
                            <div class="history-icon">
                                <i class="bi bi-book"></i>
                            </div>
                            <div>
                                <div>Bàn học sinh viên</div>
                                <div class="text-muted small color-text-primary">07/07/2024</div>
                            </div>
                        </div>

                        <div class="history-item">
                            <div class="history-icon">
                                <i class="bi bi-journal-text "></i>
                            </div>
                            <div>
                                <div>Sách giáo trình</div>
                                <div class="text-muted small color-text-primary">20/06/2024</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

       <c:import url="/WEB-INF/jsp/common/footer.jsp"/>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
