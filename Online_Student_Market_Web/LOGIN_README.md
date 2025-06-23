# SVMarket - Login System Setup

## Mô tả

Hệ thống login cho SVMarket với giao diện đẹp và tính năng đăng nhập bằng database.

## Tính năng đã triển khai

### 1. Login với Database

- **UserDAO**: Xử lý truy vấn database cho user
- **LoginServlet**: Xử lý đăng nhập với username/password
- **LogoutServlet**: Xử lý đăng xuất
- **Home**: Hiển thị trang chủ với thông tin user

### 2. Giao diện Login

- Form login đẹp với Bootstrap
- Hiển thị thông báo lỗi khi đăng nhập sai
- Layout responsive

### 3. Trang chủ sau đăng nhập

- **Bên trái**: Ảnh gradient với icon động
- **Bên giữa**: Form hiển thị thông tin user:
  - Avatar với chữ cái đầu tên
  - Tên đầy đủ, username, email
  - Thống kê (sản phẩm đã bán, đang bán, đã mua)
  - Thông tin tài khoản (vai trò, số điện thoại, ngày tham gia)
  - Nút đăng xuất

## Cách sử dụng

### 1. Setup Database

Chạy script SQL trong file `database_setup.sql`

### 2. Dữ liệu test

- **user1** / **pass1** - Nguyễn Văn A
- **user2** / **pass2** - Trần Thị B
- **admin** / **admin123** - Administrator

### 3. Truy cập

1. Vào `http://localhost:8080/yourapp/login`
2. Nhập username và password
3. Đăng nhập thành công sẽ redirect về `/home`

## URL Routes

- `/login` - Trang đăng nhập
- `/home` - Trang chủ
- `/logout` - Đăng xuất
