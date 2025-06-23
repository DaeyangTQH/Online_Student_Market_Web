// Active Navigation Handler
document.addEventListener("DOMContentLoaded", function () {
  // Lấy URL hiện tại
  const currentPath = window.location.pathname;

  // Tìm tất cả các navigation links
  const navLinks = document.querySelectorAll("nav a, .navbar nav a");

  // Loại bỏ class active khỏi tất cả links
  navLinks.forEach((link) => {
    link.classList.remove("active");
  });

  // Thêm class active cho link hiện tại
  navLinks.forEach((link) => {
    const linkPath = link.getAttribute("href");

    // Kiểm tra nếu href khớp với current path
    if (
      linkPath &&
      (currentPath.includes(linkPath) || currentPath.endsWith(linkPath))
    ) {
      // Loại bỏ active khỏi các link khác trước
      navLinks.forEach((otherLink) => otherLink.classList.remove("active"));
      // Thêm active cho link hiện tại
      link.classList.add("active");
    }

    // Xử lý trường hợp đặc biệt cho trang chủ
    if (
      linkPath &&
      linkPath.includes("/home") &&
      (currentPath === "/" || currentPath.includes("/home"))
    ) {
      link.classList.add("active");
    }
  });
});

// Thêm hiệu ứng click cho tất cả navigation links
document.addEventListener("DOMContentLoaded", function () {
  const allNavLinks = document.querySelectorAll("nav a, .footer a");

  allNavLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      // Thêm class active khi click
      this.classList.add("active");

      // Loại bỏ active khỏi các links khác cùng container
      const container = this.closest("nav") || this.closest(".footer");
      if (container) {
        const siblingLinks = container.querySelectorAll("a");
        siblingLinks.forEach((siblingLink) => {
          if (siblingLink !== this) {
            siblingLink.classList.remove("active");
          }
        });
      }
    });
  });
});
