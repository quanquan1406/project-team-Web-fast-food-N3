<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị Admin</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            background: bisque;
        }

        .container {
            display: flex;
            flex: 1; /* Đảm bảo nội dung chính và menu chiếm không gian cần thiết */
            width: 90%;
            margin: 5px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .menu {
            width: 220px; /* Giữ menu nằm bên trái với chiều rộng cố định */
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
            margin-right: 20px;
        }

        .main-content {
            flex-grow: 1; /* Nội dung chính chiếm toàn bộ không gian còn lại */
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .footer {
            text-align: center;
            padding: 10px 0;
            background-color: #f4f4f4;
            color: #888;
            box-shadow: 0 -1px 5px rgba(0, 0, 0, 0.1);
            width: 100%;
            margin-top: auto; /* Đẩy footer xuống dưới */
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
            width: 220px; /* Đặt chiều rộng cố định */
            min-width: 220px; /* Chiều rộng tối thiểu để tránh thu nhỏ */
            max-width: 220px; /* Chiều rộng tối đa để tránh vượt kích thước */
            height: auto; /* Đặt chiều cao tự động (hoặc cố định nếu cần) */
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
    <style>
        .container {
            width: 90%;
            margin: 5px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .message {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
        }
        .error {
            background-color: #f8d7da;
            color: #842029;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
            margin-bottom: 20px;
        }
        label {
            width: 120px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"] {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .button {
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
        }
        .button-danger {
            background-color: #f44336;
            color: white;
        }
        .button-danger:hover {
            background-color: #d32f2f;
        }
        .button-edit {
            background-color: #008CBA;
            color: white;
        }
        .button-edit:hover {
            background-color: #005f8d;
        }
        .menu a.active {
            background-color: #d32f2f; /* Màu nền active */
            color: #ffffff; /* Màu chữ active */
            font-weight: bold; /* Chữ đậm */
        }


    </style>

</head>
<body>
<div class="container">
    <div class="menu">
        <h2>Menu Quản Trị</h2>
        <ul>
            <li><a href="Quan_ly_khach_hang.jsp" class="<%= request.getRequestURI().contains("Quan_ly_khach_hang.jsp") ? "active" : "" %>">Quản lý khách hàng</a></li>
            <li><a href="Quan_ly_don_hang.jsp" class="<%= request.getRequestURI().contains("Quan_ly_don_hang.jsp") ? "active" : "" %>">Quản lý đơn hàng</a></li>
            <li><a href="Quan_ly_san_pham.jsp" class="<%= request.getRequestURI().contains("Quan_ly_san_pham.jsp") ? "active" : "" %>">Quản lý sản phẩm</a></li>
            <li><a href="Quan_ly_tin_tuc.jsp" class="<%= request.getRequestURI().contains("Quan_ly_tin_tuc.jsp") ? "active" : "" %>">Quản lý tin tức</a></li>
            <li><a href="doanh_thu.jsp" class="<%= request.getRequestURI().contains("doanh_thu.jsp") ? "active" : "" %>">Doanh thu</a></li>
        </ul>

    </div>
