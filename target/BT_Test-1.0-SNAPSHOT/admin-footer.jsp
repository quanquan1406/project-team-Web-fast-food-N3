<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

</div>
<div class="footer">
    <p>&copy; 2024 Hệ thống Quản trị Admin</p>
</div>
</div>
<script src="script.js"></script> <!-- Tệp JS chung -->
</body>
</html>
<script>
    // Lấy URL hiện tại
    const currentURL = window.location.href;

    // Lấy tất cả các phần tử liên kết trong menu
    const menuLinks = document.querySelectorAll('.menu a');

    // Lặp qua các liên kết và kiểm tra URL
    menuLinks.forEach(link => {
        if (currentURL.includes(link.getAttribute('href'))) {
            link.classList.add('active');
        }
    });
</script>
