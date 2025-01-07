<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Đăng Nhập</title>
    <link rel="stylesheet" href="./assets/css/login.css">
</head>
<body>
    <div class="login-container">
        <h2>Đăng Nhập</h2>
        <div class="role-selection">
            <button onclick="showForm('customer')">Dành cho Khách Hàng</button>
            <button onclick="showForm('admin')">Dành cho Admin</button>
        </div>

        <!-- Form Đăng Nhập Khách Hàng -->
        <div class="login-form" id="customer-form" style="display:none;">
            <form action="login" method="POST">
                <input type="hidden" name="role" value="customer">
                <input type="text" name="username" placeholder="Tài khoản" id="customer-username" required>
                <input type="password" name="password" placeholder="Mật khẩu" id="customer-password" required>
                <button type="submit">Đăng Nhập</button>
            </form>
        </div>

        <!-- Form Đăng Nhập Admin -->
        <div class="login-form" id="admin-form" style="display:none;">
            <form action="login" method="POST">
                <input type="hidden" name="role" value="admin">
                <input type="text" name="username" placeholder="Tài khoản" id="admin-username" required>
                <input type="password" name="password" placeholder="Mật khẩu" id="admin-password" required>
                <button type="submit">Đăng Nhập</button>
            </form>
        </div>

        <!-- Thông báo lỗi nếu đăng nhập không thành công -->
        <div id="error-message" style="color: red; display: <% if(request.getAttribute("error") != null) { %>block<% } else { %>none<% } %>;">
            <p>Sai tài khoản hoặc mật khẩu! Vui lòng thử lại.</p>
        </div>
    </div>

    <script>
        function showForm(role) {
            if (role === 'customer') {
                document.getElementById('customer-form').style.display = 'block';
                document.getElementById('admin-form').style.display = 'none';
            } else if (role === 'admin') {
                document.getElementById('customer-form').style.display = 'none';
                document.getElementById('admin-form').style.display = 'block';
            }
        }
    </script>
</body>
</html>
