document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('role').addEventListener('change', function() {
        const role = this.value;

        const customerForm = document.getElementById('customer-form');
        const adminForm = document.getElementById('admin-form');

        if (role === 'customer') {
            customerForm.style.display = 'block';
            adminForm.style.display = 'none';
        } else if (role === 'admin') {
            customerForm.style.display = 'none';
            adminForm.style.display = 'block';
        }
    });

    document.getElementById('registration-form').addEventListener('submit', function(event) {
        event.preventDefault();

        const role = document.getElementById('role').value;
        const username = role === 'customer' ? document.getElementById('username').value : document.getElementById('username-admin').value;
        const password = role === 'customer' ? document.getElementById('password').value : document.getElementById('password-admin').value;
        const phone = role === 'customer' ? document.getElementById('phone').value : document.getElementById('phone-admin').value;
        const fullname = role === 'customer' ? document.getElementById('fullname').value : document.getElementById('fullname-admin').value;

        console.log('Đăng ký thành công:', {
            role,
            username,
            password,
            phone,
            fullname
        });

        alert('Đăng ký thành công!');
        // Điều hướng dựa trên vai trò
        if (role === 'customer') {
            window.location.replace('./customer-home.html'); // Trang chính của khách hàng
        } else if (role === 'admin') {
            window.location.replace('./admin-dashboard.html'); // Trang quản trị
        } else {
            alert('Vui lòng chọn vai trò hợp lệ.');
        }
    });
});


function chuyen_den_dang_nhap() {
        window.location.href = './login.jsp';
}


