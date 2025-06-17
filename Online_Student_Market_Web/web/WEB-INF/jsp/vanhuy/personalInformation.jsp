<%-- Document : personalInformation Created on : Jun 9, 2025, 8:25:10 PM Author
: Van Huy --%>
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

    <style>
      /* Override Bootstrap's background colors */
      .bg-light {
        background-color: #fff6f0 !important;
      }

      .card,
      .list-group-item {
        background-color: #fff6f0;
      }
    </style>
  </head>
  <body>
    <!-- Header -->
    <div class="header">
      <div class="container">
        <div class="d-flex justify-content-between align-items-center">
          <div class="d-flex align-items-center">
            <div class="fw-bold me-4">◼ SVMarket</div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></div>
            <div class="nav-item"><a href="">Danh mục</a></div>
            <div class="nav-item"><a href="#">Yêu thích</a></div>
            <div class="nav-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></div>
          </div>
          <div class="d-flex align-items-center">
            <div class="search-box me-3">
              <i class="bi bi-search"></i>
              <input
                type="text"
                placeholder="Search"
                class="border-0 bg-transparent"
                style="outline: none; width: 150px"
              />
            </div>
            <div class="me-3">
              <i class="bi bi-bell"></i>
            </div>
            <div class="avatar"></div>
          </div>
        </div>
      </div>
    </div>

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

    <!-- Footer -->
    <footer class="footer py-4">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">
            <div class="d-flex justify-content-center mb-3">
              <a href="#" class="text-decoration-none text-secondary"
                >About Us</a
              >
              <a href="#" class="text-decoration-none text-secondary"
                >Contact</a
              >
              <a href="#" class="text-decoration-none text-secondary">FAQ</a>
              <a href="#" class="text-decoration-none text-secondary"
                >Terms of Service</a
              >
              <a href="#" class="text-decoration-none text-secondary"
                >Privacy Policy</a
              >
            </div>

            <div class="d-flex justify-content-center mb-3 social-links">
              <a href="https://www.facebook.com/tranquochai411" class="text-secondary">
                <i class="bi bi-facebook"></i>
              </a>
              <a href="#" class="text-secondary">
                <i class="bi bi-twitter"></i>
              </a>
              <a href="https://www.instagram.com/_haichann_/" class="text-secondary">
                <i class="bi bi-instagram"></i>
              </a>
            </div>

            <div class="text-secondary small">
              &copy; 2025 SVMarket. All rights reserved.
            </div>
          </div>
        </div>
      </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
