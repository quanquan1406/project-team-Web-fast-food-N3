function showForm(role) {
    // Ẩn tất cả form
    document.getElementById('customer-form').style.display = 'none';
    document.getElementById('admin-form').style.display = 'none';

    // Hiển thị form tương ứng
    if (role === 'customer') {
        document.getElementById('customer-form').style.display = 'flex';
    } else if (role === 'admin') {
        document.getElementById('admin-form').style.display = 'flex';
    }
}

function login(role) {
    // Chuyển hướng đến trang tương ứng
    if (role === 'customer') {
        window.location.href = './index.jsp'; // Link customer
    } else if (role === 'admin') {
        window.location.href = './index.jsp'; // Link admin
    }
}
