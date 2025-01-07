<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị Admin</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            display: flex;
            height: 100vh;
            flex-direction: row;
            justify-content: space-between;
            padding: 20px;
            box-sizing: border-box;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #d32f2f;  /* Đổi sang màu đỏ */
            padding: 15px;
            color: white;
            border-radius: 5px;
            width: 100%;
        }
        .header h1 {
            font-size: 24px;
            margin: 0;
        }
        .header a {
            text-decoration: none;
            color: #fff;  /* Chữ màu trắng để nổi bật trên nền đỏ */
            margin-left: 20px;
            padding: 10px 15px;
            background-color: #FF9800;  /* Nền nút màu cam nhạt */
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .header a:hover {
            background-color: #FF5722;  /* Màu nền khi hover chuyển thành cam đậm */
        }

        .menu {
            min-width: 270px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
            margin-right: 20px;
        }
        .menu h2 {
            font-size: 20px;
            color: #d32f2f;  /* Đổi sang màu đỏ */
            font-weight: 600;
            margin-bottom: 20px;
        }
        .menu ul {
            list-style-type: none;
            padding: 0;
        }
        .menu ul li {
            margin: 12px 0;
        }
        .menu ul li a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            padding: 10px;
            border-radius: 5px;
            display: block;
            transition: background-color 0.3s ease;
        }
        .menu ul li a:hover {
            background-color: #f1f1f1;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #888;
        }

        /* Responsive design */
        @media screen and (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .menu {
                width: 100%;
                margin-right: 0;
                margin-bottom: 20px;
            }
            .main-content {
                width: 100%;
            }
            .header h1 {
                font-size: 20px;
            }
            .header a {
                font-size: 14px;
                padding: 6px 12px;
            }
            .menu ul li a {
                font-size: 14px;
            }
        }

        /* Responsive design for smaller devices (mobile) */
        @media screen and (max-width: 480px) {
            .header h1 {
                font-size: 18px;
            }
            .header a {
                font-size: 12px;
                padding: 5px 10px;
            }
            .menu ul li a {
                font-size: 12px;
            }
        }

    </style>
</head>
<body>

    <div class="container">
        <!-- Left Side Menu -->
        <div class="menu">
            <h2>Menu Quản Trị</h2>
            <ul>
                <li><a href="Quan_ly_khach_hang.jsp">Quản lý khách hàng</a></li>
                <li><a href="Quan_ly_don_hang.jsp">Quản lý đơn hàng</a></li>
                <li><a href="Quan_ly_san_pham.jsp">Quản lý sản phẩm</a></li>
                <li><a href="Quan_ly_tin_tuc.jsp">Quản lý tin tức</a></li>
            </ul>
        </div>

        <!-- Main Content Area -->
        <div class="main-content">
            <div class="header">
                <h1>Xin chào, Admin</h1>
                <div>
                    <a href="index.jsp">Trang chủ</a>
                    <a href="#">Đăng xuất</a>
                </div>
            </div>

            <!-- Admin Dashboard Content Here -->
            <div class="dashboard-content">
                <h3>Dashboard Overview</h3>
                <p>Chào mừng bạn đến với trang quản trị. Tại đây, bạn có thể quản lý các thông tin liên quan đến khách hàng, đơn hàng, sản phẩm, và tin tức.</p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Hệ thống Quản trị Admin</p>
    </div>

</body>
</html>
