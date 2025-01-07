<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Ký</title>
  <link rel="stylesheet" href="./assets/css/sign.css">
</head>
<body>
  <div class="container">
    <h2>Đăng Ký</h2>
    <form id="registration-form" action="sign" method="post">
      <!-- Thông tin đăng ký -->
      <input type="text" id="hoTen" name="hoTen" placeholder="Họ và tên" required>
      <input type="tel" id="sdt" name="sdt" placeholder="Số điện thoại" required>
      <input type="text" id="diaChi" name="diaChi" placeholder="Địa chỉ" required>
      <input type="text" id="taiKhoan" name="taiKhoan" placeholder="Tài khoản" required>
      <input type="password" id="matKhau" name="matKhau" placeholder="Mật khẩu" required>

      <button type="submit">Đăng ký</button>
    </form>
  </div>

  <script src="./assets/js/sign.js"></script>
</body>
</html>
