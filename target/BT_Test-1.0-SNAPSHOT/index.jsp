<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.SanPham" %>
<%@ page import="DAO.SanPhamDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.TinTuc" %>
<%@ page import="DAO.TinTucDAO" %>
<%
    int pageSize = 9; // Số sản phẩm mỗi trang
    int currentPage = 1; // Trang hiện tại (mặc định là 1)

    // Lấy tham số "page" từ URL nếu có
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    // Tạo DAO và lấy danh sách sản phẩm theo phân trang
    SanPhamDAO sanPhamDAO = new SanPhamDAO();
    List<SanPham> productList = sanPhamDAO.getSanPhamPaging(currentPage, pageSize);

    // Lấy tổng số sản phẩm và tính số trang
    int totalProducts = sanPhamDAO.getTotalProducts();
    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

    List<SanPham> topSellingProducts = sanPhamDAO.getTopSellingProducts(6); // Hiển thị top 5 sản phẩm

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Web ban do an nhanh</title>
    <link rel="stylesheet" href="./assets/css/style.css"/>
    <link
            rel="stylesheet"
            href="./assets/font/themify-icons/themify-icons.css"
    />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/responsive.css"/>


    <!-- CSS -->
    <style>


        /* Container chứa toàn bộ phần tin tức */
        .news-section {
            padding: 40px 10%;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 50px;
        }

        /* Tiêu đề của phần tin tức */
        .news-section h1 {
            font-family: 'Arial', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Danh sách các tin tức */
        .news-list {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
        }

        /* Mỗi tin tức trong danh sách */
        .news-item {
            width: calc(33% - 30px); /* Hiển thị 3 tin tức trong một hàng */
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Hiệu ứng hover cho mỗi tin tức */
        .news-item:hover {
            transform: translateY(-10px); /* Di chuyển lên khi hover */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        /* Phần hình ảnh của tin tức */
        .news-image img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 2px solid #ddd;
        }

        /* Nội dung tin tức */
        .news-content {
            padding: 20px;
        }

        /* Tiêu đề của mỗi tin tức */
        .news-content h3 {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
            font-family: 'Arial', sans-serif;
        }

        /* Nội dung chính của tin tức */
        .news-content p {
            font-size: 14px;
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        /* Ngày đăng */
        .news-date {
            font-size: 12px;
            color: #999;
            text-align: right;
        }

        /* Thêm khoảng cách giữa các tin tức nếu màn hình nhỏ */
        @media (max-width: 768px) {
            .news-item {
                width: calc(50% - 30px); /* Hiển thị 2 tin tức trên mỗi hàng */
            }
        }

        /* Trên màn hình nhỏ hơn 480px, hiển thị 1 tin tức trên mỗi hàng */
        @media (max-width: 480px) {
            .news-item {
                width: 100%;
            }
        }

        .slideshow-container {
            position: relative;
            /*max-width: 1000px;*/
            margin: 10px;
            border: 1px solid #ddd; /* Đường viền xung quanh */
            border-radius: 10px; /* Bo góc */
            overflow: hidden; /* Ẩn phần nội dung tràn ra ngoài */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Đổ bóng */
        }

        /* Các slide */
        .mySlides {
            display: none;
            text-align: center;
        }

        /* Dòng sản phẩm trong mỗi slide */
        .slide-row {
            display: flex;
            justify-content: space-between;
            gap: 20px; /* Khoảng cách giữa các sản phẩm */
            padding: 20px;
        }

        /* Thẻ chứa từng sản phẩm */
        .slide-card {
            width: 48%; /* Mỗi sản phẩm chiếm 48% chiều rộng */
            box-sizing: border-box; /* Bao gồm padding và border vào tổng chiều rộng */
            background-color: #fff;
            border-radius: 8px; /* Bo góc thẻ sản phẩm */
            overflow: hidden; /* Ẩn phần tràn ra ngoài */
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); /* Đổ bóng cho sản phẩm */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Thêm hiệu ứng khi hover */
        }

        /* Hiệu ứng hover cho sản phẩm */
        .slide-card:hover {
            transform: translateY(-5px); /* Di chuyển sản phẩm lên một chút */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* Đổ bóng mạnh hơn */
        }

        /* Kích thước ảnh */
        .slide-card img {
            width: 100%; /* Đảm bảo ảnh chiếm toàn bộ chiều rộng của thẻ */
            height: 200px; /* Chiều cao cố định cho ảnh */
            object-fit: cover; /* Giữ tỷ lệ ảnh và cắt bớt nếu cần */
            border-bottom: 1px solid #ddd; /* Đường viền dưới ảnh */
        }

        /* Nội dung của sản phẩm (tên, mô tả, giá) */
        .slide-card .content {
            padding: 15px;
            text-align: left;
        }

        /* Tên sản phẩm */
        .slide-card .content h3 {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        /* Mô tả sản phẩm */
        .slide-card .content p {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        /* Giá sản phẩm */
        .slide-card .content p.price {
            font-size: 16px;
            color: #e74c3c; /* Màu đỏ cho giá */
            font-weight: bold;
        }

        /* Nút điều hướng */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
            background-color: rgba(0, 0, 0, 0.5); /* Nền mờ cho nút */
        }

        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

        .prev:hover, .next:hover {
            background-color: rgba(0, 0, 0, 0.8); /* Tăng độ tối khi hover */
        }

        /* Đảm bảo nút điều hướng nằm ở giữa */
        .prev, .next {
            top: 50%;
            transform: translateY(-50%);
        }
        button{
            background-color: #d32f2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
    </style>
    <style>
        .categories-section {
            margin: 20px 0;
        }
        .category {
            margin-bottom: 30px;
        }
        .products-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
       
        
        .menu .product-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: calc(33.333% - 20px);
            margin-bottom: 20px;
            overflow: hidden;

        }
        .menu .product-card .img {
            width: 150px;
            height: 150px;
        }
        
        .menu .content-product-card{
            padding: 15px;
            text-align: center;
        }
        
        .menu .content-product-card h3 {
            margin: 10px 0;
            font-size: 18px;
            
        }
        
        .menu .content-product-card p {
            color: #757575;
            margin: 5px 0;
            
        }
        
        .menu .content-product-card .price {
            color: #d32f2f;
            font-weight: bold;
            
        }
        
        .menu .content-product-card .btn {
            background-color: #d32f2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .menu .content-product-card .btn:hover {
            background-color: #b71c1c;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            border: 1px solid #ccc;
            text-decoration: none;
            color: #000;
        }

        .pagination a.active {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .header .info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .header .info span {
            font-size: 16px;
            font-weight: bold;
        }

        .header .info a {
            text-decoration: none;
            color: #000;
            font-size: 14px;
        }    
    </style>

</head>

<body>
<div class="main">
    <!-- vi du semantic: cho nay dat thanh the main luon -->
    <div class="header">
        <!-- the header luon -->
        <div class="left">
            <div class="menu-btn">
                <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 448 512"
                        class="btn-menu-icon"
                >
                    <path
                            d="M0 96C0 78.3 14.3 64 32 64l384 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 128C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32l384 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 288c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32L32 448c-17.7 0-32-14.3-32-32s14.3-32 32-32l384 0c17.7 0 32 14.3 32 32z"
                    />
                </svg>
            </div>

            <div class="close-btn">
                <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 384 512"
                        class="btn-close-icon"
                >
                    <!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                    <path
                            d="M342.6 150.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 210.7 86.6 105.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L146.7 256 41.4 361.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L192 301.3 297.4 406.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L237.3 256 342.6 150.6z"
                    />
                </svg>
            </div>

            <button class="select-language">
                <img src="./assets/img/header/vi.png" alt="vi"/>
                <span>Tiếng Việt</span>
                <div class="dropdown-language">
                    <ul>
                        <li>
                            <img src="./assets/img/header/vi.png" alt="vi"/>
                            <span>Tiếng Việt</span>
                        </li>
                        <li>
                            <img src="./assets/img/header/en.png" alt="en"/>
                            <span>English</span>
                        </li>
                    </ul>
                </div>
            </button>

            <div class="select-location">
                <select name="location" id="location">
                    <option value="hanoi">Hà Nội</option>
                </select>
            </div>
        </div>

        <div class="logo">
            <img src="./assets/img/header/alf-logo.png" style="max-width: 80%; height:auto;" alt="logo"/>
        </div>

        <div class="right">
            <%-- Kiểm tra trạng thái đăng nhập --%>
            <%
                HttpSession s = request.getSession(false); // Lấy session hiện tại (không tạo mới)
                String username = (s != null) ? (String) s.getAttribute("username") : null;
                String role = (s != null) ? (String) s.getAttribute("role") : null;
            %>
            <% if (username == null) { %>
            <!-- Khi chưa đăng nhập -->
            <div class="info">
                <img src="./assets/img/header/i-person.png" alt="info"/>
                <a href="login.jsp">Đăng nhập</a>
                <span>/</span>
                <a href="sign.jsp">Đăng ký</a>
            </div>
            <% } else { %>
            <!-- Khi đã đăng nhập -->
            <div class="info">
                <%--                  <img src="./assets/img/header/avatar.png" alt="avatar" style="width: 40px; height: 40px; border-radius: 50%;" />--%>
                <a href="Profile.jsp">Xin chào, <%= username %></a>
                <a href="logout" style="margin-left: 10px; color: red;">Đăng xuất</a>
            </div>
            <% } %>
            <div class="cart1">
                <a href="">
                    <span>0</span>
                </a>
            </div>
        </div>
    </div>

    <div class="slider">
        <div class="list">
            <div class="item banner" onclick="window.location.href='tintuc.jsp'">
                <img src="./assets/img/list/banner test.jpg" alrt="Khuyến Mãi" class="place-img">
                <p class="place-body">Khuyến Mãi</p>
            </div>
            <div class="item type-food1">
                <a href="#gà-rán">
                        <img src="./assets/img/list/garan.jpg" alt="Gà Rán " class="place-img">
                        <p class="place-body">Gà Rán</p>
                    </a>
            </div>
            <div class="item type-food2">
                <a href="#tráng-miệng">
                        <img src="./assets/img/list/trangmieng1.jpg" alrt="Tráng Miệng" class="place-img">
                        <p class="place-body">Tráng Miệng</p>
                    </a>
            </div>        
            <div class="item type-food3">
                <a href="#mỳ">
                        <img src="./assets/img/list/my.jpg" alt="Mỳ" class="place-img">
                        <p class="place-body">Mỳ</p>
                    </a>
            </div>
            <div class="item type-food4">
                <a href="#burger">
                        <img src="./assets/img/list/hamburger-thit-heo-nuong.jpg" alt="Humburger" class="place-img">
                        <p class="place-body">Humburger</p>
                    </a>
            </div>
            <div class="item type-food5">
                <a href="#combo-nhóm">
                        <img src="./assets/img/list/combo.jpg" alt="Combo Nhóm" class="place-img">
                        <p class="place-body">Combo Nhóm</p>
                    </a>
            </div>
        </div>
    </div>

    <aside class="sidebar">
        <ul class="menu-list">
            <li>
                <a href="index.jsp">Trang chủ</a>
            </li>
            <li>
                <a href="tintuc.jsp">Khuyến mãi</a>
            </li>
        </ul>
        <div class="social">
            <a>
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512">
                        <!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path
                                d="M80 299.3V512H196V299.3h86.5l18-97.8H196V166.9c0-51.7 20.3-71.5 72.7-71.5c16.3 0 29.4 .4 37 1.2V7.9C291.4 4 256.4 0 236.2 0C129.3 0 80 50.5 80 159.4v42.1H14v97.8H80z"
                        />
                    </svg>
                </div>
            </a>

            <a>
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path
                                d="M549.7 124.1c-6.3-23.7-24.8-42.3-48.3-48.6C458.8 64 288 64 288 64S117.2 64 74.6 75.5c-23.5 6.3-42 24.9-48.3 48.6-11.4 42.9-11.4 132.3-11.4 132.3s0 89.4 11.4 132.3c6.3 23.7 24.8 41.5 48.3 47.8C117.2 448 288 448 288 448s170.8 0 213.4-11.5c23.5-6.3 42-24.2 48.3-47.8 11.4-42.9 11.4-132.3 11.4-132.3s0-89.4-11.4-132.3zm-317.5 213.5V175.2l142.7 81.2-142.7 81.2z"
                        />
                    </svg>
                </div>
            </a>

            <a>
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                        <!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path
                                d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"
                        />
                    </svg>
                </div>
            </a>
        </div>
    </aside>
    <div class="dark-transparent-bg"></div>
</div>
<%
    // Lấy danh sách các loại sản phẩm
    List<String> loaiSanPhamList = sanPhamDAO.getAllLoaiSanPham();
%>
<div class="nav">
    <%
        for (String loaiSanPham : loaiSanPhamList) {
            // Tạo id cho phần tử (chuyển tên loại sản phẩm thành định dạng id HTML hợp lệ)
            String id = loaiSanPham.toLowerCase().replaceAll("\\s+", "-");
    %>
    <a href="#<%= id %>">
        <%= loaiSanPham %>
    </a>
    <% } %>
</div>
<div class="MENU">
    <div class="container1">

        <div class="menu">
            <div class="slideshow-container">
                <br>
                <h1 style="padding-left: 10px">Sản phẩm bán chạy nhất</h1>
                <br>
                <%
                    int count = 0;
                    // Lặp qua danh sách sản phẩm và chia nhóm 2 sản phẩm mỗi slide
                    for (int i = 0; i < topSellingProducts.size(); i += 2) {
                        List<SanPham> twoProducts = new ArrayList<>();
                        for (int j = i; j < i + 2 && j < topSellingProducts.size(); j++) {
                            twoProducts.add(topSellingProducts.get(j));
                        }
                %>
                <div class="mySlides fade">
                    <div class="slide-row">
                        <% for (SanPham product : twoProducts) { %>
                        <div class="slide-card">
                            <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" style="width:100%">
                            <div class="content">
                                <h3><%= product.getName() %></h3>
                                <p><%= product.getDescription() %></p>
                                <p style="color: red">Giá: <%= String.format("%,.0f", product.getPrice()) %>đ</p>
                                <% if (username != null) { %>
                                <button class="btn"
                                        onclick="showProductInfo('<%= product.getName() %>', '<%= product.getPrice() %> VNĐ', '<%= product.getDescription() %>', '<%= product.getImage() %>')">
                                    CHỌN MUA
                                </button>
                                <% } else { %>
                                <button class="btn" onclick="checkLogin()">CHỌN MUA</button>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <!-- Nút điều hướng -->
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>

            <div class="categories-section">
                <% for (String loaiSanPham : loaiSanPhamList) { %>
                <div id="<%= loaiSanPham.toLowerCase().replaceAll("\\s+", "-") %>" class="category">
                    <h2><%= loaiSanPham %></h2>
                    <div class="products-row">
                        <%
                            // Lấy 3 sản phẩm theo loại
                            List<SanPham> top3Products = sanPhamDAO.getTopProductsByCategory(loaiSanPham);
                            for (SanPham product : top3Products) {
                        %>
                        
                        <div class="product-card">
                            <img src="<%= product.getImage() %>" height="150" width="300" alt="<%= product.getName() %>" />
                            <div class="content-product-card">
                            <h3><%= product.getName() %></h3>
                            <p><%= product.getDescription() %></p>
                            <p class="price" style="color: red;">Giá: <%= String.format("%,.0f", product.getPrice()) %>đ</p>
                            <% if (username != null) { %>
                            <button class="btn" onclick="showProductInfo('<%= product.getName() %>', '<%= product.getPrice() %> VNĐ', '<%= product.getDescription() %>', '<%= product.getImage() %>')">
                                CHỌN MUA
                            </button>
                            <% } else { %>
                            <button class="btn" onclick="checkLogin()">CHỌN MUA</button>
                            <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>
                
            </div>

            
        </div>

        <!-- Modal thông tin sản phẩm -->
        <div id="productModal" class="modal">
            <div class="modal-content">
                <table>
                    <tr>
                        <td><h3 id="productName"></h3></td>
                    </tr>
                    <tr>
                        <td>
                            <img id="productImage" src="" alt="Product Image" height="200" width ="300">
                            <p id="productDescription"></p>
                            <p>Giá:<span id="productPrice"></span></p>
                        </td>
                        <td>
                            <label for="customerNote">Ghi chú:</label><br>
                            <textarea id="customerNote" rows="10" cols="40"
                                      placeholder="Thêm ghi chú của bạn..."></textarea>

                            <!--  chức năng thêm số lượng-->


                        </td>
                    </tr>
                </table>
                <p id="productDescription"></p>
<p>Số lượng: <input type="number" value="1" min="1" id="count" required></input></p>
<button class="btn" id="confirmAddToCart">Đồng ý</button>
<button class="btn" onclick="closeModal()">Hủy</button>

            </div>
        </div>


        <!-- Giỏ hàng -->
        <div class="cart">
            <h3>Giỏ hàng <span class="cart-count">0</span></h3>
            <div class="giohang">
                <p class="empty">Giỏ hàng trống</p>
            </div>
            <div class="total">
                <p>Tổng tiền: <span class="total-price">0đ</span></p>
                <p>Thuế (1%): <span class="tax">0đ</span></p>
                <p>Tổng cộng: <span class="grand-total">0đ</span></p>
                <% if (username != null) { %>
                <button onclick="order()" class="btn">Thanh toán</button>
                <% } else { %>
                <button onclick="checkLogin()" class="btn">Thanh toán</button>
                <% } %>
            </div>
        </div>
    </div>
</div>
<div class="footer" style="background-color: #A52A2A; color: white; padding: 20px 0; text-align: center;">
    <h2 style="font-size: 24px; margin-bottom: 10px;">Liên hệ với chúng tôi</h2>
    <div class="footer-content" style="font-size: 16px;">
        <p>&copy; 2024 Hệ thống mua bán đồ ăn 
            <br> 
            Nhóm 3 - Lập Trình Web (Fintech)
            <br> 
            email: nhom3web@gmail.com
            <br>
            Điện thoại: 0987654321
        </p>
        <div class="social-icons" style="margin-top: 10px;">
            <h2 style="font-size: 18px; margin-bottom: 10px;">Mạng xã hội</h2>
            <a href="https://facebook.com" target="_blank" aria-label="Facebook" style="color: white; margin-right: 15px; font-size: 20px; text-decoration: none;">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="https://instagram.com" target="_blank" aria-label="Instagram" style="color: white; margin-right: 15px; font-size: 20px; text-decoration: none;">
                <i class="fab fa-instagram"></i>
            </a>
            <a href="https://youtube.com" target="_blank" aria-label="YouTube" style="color: white; margin-right: 15px; font-size: 20px; text-decoration: none;">
                <i class="fab fa-youtube"></i>
            </a>
        </div>
    </div>
</div>



</body>
</html>
<script>
    function checkLogin() {
        alert("Bạn cần đăng nhập để mua hàng")
        location.href = "login.jsp"
    }

    function order() {
        if (cart.length === 0) {
            alert("Giỏ hàng của bạn đang trống!");
            return;
        }

        // Gửi dữ liệu thanh toán đến server
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "processCheckout", true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert("Thanh toán thành công!");
                cart = []; // Làm trống giỏ hàng sau khi thanh toán
                updateCartDisplay();
            } else if (xhr.readyState === 4) {
                alert("Có lỗi xảy ra khi thanh toán!");
            }
        };
        xhr.send(JSON.stringify(cart));
    }


</script>
<script>
    let slideIndex = 0;
    showSlides();

    function showSlides() {
        let slides = document.getElementsByClassName("mySlides");
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) { slideIndex = 1; }
        slides[slideIndex - 1].style.display = "block";
        setTimeout(showSlides, 3000); // Tự động chuyển slide mỗi 3 giây
    }

    function plusSlides(n) {
        slideIndex += n;
        let slides = document.getElementsByClassName("mySlides");
        if (slideIndex > slides.length) { slideIndex = 1; }
        if (slideIndex < 1) { slideIndex = slides.length; }
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";
    }

    // Hàm thêm sản phẩm vào giỏ hàng
    function addToCart() {
    const quantityInput = document.getElementById("count");
    let quantity = parseInt(quantityInput.value); // Đảm bảo lấy giá trị số nguyên từ input

    if (!selectedProduct) return;

    // Kiểm tra xem số lượng có hợp lệ không
    if (isNaN(quantity) || quantity < 1) {
        alert("Vui lòng nhập số lượng hợp lệ (lớn hơn hoặc bằng 1).");
        return; // Dừng lại nếu số lượng không hợp lệ
    }

    const { name, price, image, description } = selectedProduct;

    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
    const existingProduct = cart.find(item => item.name === name);
    if (existingProduct) {
        existingProduct.quantity += quantity; // Cộng số lượng nếu sản phẩm đã có trong giỏ
    } else {
        cart.push({ name, price, image, description, quantity: quantity });
    }

    // Cập nhật hiển thị giỏ hàng
    updateCartDisplay();
    closeModal();

    // Đặt lại số lượng sau khi thêm vào giỏ hàng
    quantityInput.value = 1;
}

</script>

<script src="scripts.js"></script>
