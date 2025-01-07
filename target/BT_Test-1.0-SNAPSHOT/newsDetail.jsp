<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.TinTuc" %>
<%@ page import="DAO.TinTucDAO" %>

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

  <!-- CSS -->
  <style>
    /* Một số kiểu CSS cơ bản để làm đẹp trang chi tiết tin tức */
    .news-detail {
      padding: 40px;
      max-width: 80%;
      margin: 0 auto;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .news-detail h1 {
      font-size: 28px;
      color: #333;
      margin-bottom: 20px;
    }
    .news-detail .news-image img {
      width: 100%;
      height: auto;
      border-radius: 8px;
      margin-bottom: 20px;
    }
    .news-detail .content {
      font-size: 16px;
      line-height: 1.8;
      color: #555;
    }
    .news-detail .date {
      font-size: 14px;
      color: #999;
      text-align: right;
      margin-top: 20px;
    }
    .back-button {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 20px;
      background-color: #007bff;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
    }
    .back-button:hover {
      background-color: #0056b3;
    }
  </style>
  <style>
    .footer {
      margin-bottom: 50px;
      text-align: center;
      margin-top: 50px;
      color: #888;
    }
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
    .btn{
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
      <div class="item banner">
        <img src="./assets/img/list/banner test.jpg" alrt="Khuyến Mãi" class="place-img">
        <p class="place-body">Khuyến Mãi</p>
      </div>
      <div class="item type-food1">
        <img src="./assets/img/list/garan.jpg" alrt="Gà Rán " class="place-img">
        <p class="place-body">Gà Rán</p>
      </div>
      <div class="item type-food2">
        <img src="./assets/img/list/trangmieng1.jpg" alrt="Tráng Miệng" class="place-img">
        <p class="place-body">Tráng Miệng</p>
      </div>
      <div class="item type-food3">
        <img src="./assets/img/list/my.jpg" alrt="Mỳ" class="place-img">
        <p class="place-body">Mỳ</p>
      </div>
      <div class="item type-food4">
        <img src="./assets/img/list/hamburger-thit-heo-nuong.jpg" alrt="Humburger" class="place-img">
        <p class="place-body">Humburger</p>
      </div>
      <div class="item type-food5">
        <img src="./assets/img/list/combo.jpg" alrt="Combo Nhóm" class="place-img">
        <p class="place-body">Combo Nhóm</p>
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
      <li>
        <a href="about_us.jsp">Về chúng tôi</a>
      </li>
      <li>
        <a href="contact.jsp">Liên hệ</a>
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

<div class="nav">
  <a href="#ga-ran">
    Gà Rán
  </a>
  <a href="#trang-mieng">
    Tráng Miệng
  </a>
  <a href="#my">
    Mỳ
  </a>
  <a href="#humburger">
    Humburger
  </a>
  <a href="#combo">
    COMBO Nhóm
  </a>
</div>

<%
  TinTuc tinTuc = (TinTuc) request.getAttribute("tinTuc");
%>
<div class="news-detail">
  <!-- Hiển thị hình ảnh -->
  <div class="news-image">
    <img src="<%= tinTuc.getImage() %>" alt="<%= tinTuc.getTitle() %>">
  </div>

  <!-- Tiêu đề tin tức -->
  <h1><%= tinTuc.getTitle() %></h1>

  <!-- Nội dung tin tức -->
  <div class="content">
    <%= tinTuc.getContent() %>
  </div>

  <!-- Ngày đăng -->
  <div class="date">
    Ngày đăng: <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tinTuc.getDatePosted()) %>
  </div>

  <!-- Nút quay lại -->
  <a href="index.jsp" class="back-button">Quay lại</a>
</div>

<div class="footer">
  <p>&copy; 2024 Hệ thống mua bán đồ ăn</p>
</div>
</body>
</html>
<script src="scripts.js"></script>

