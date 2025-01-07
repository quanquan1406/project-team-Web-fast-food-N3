<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.KhachHang, DAO.KhachHangDAO, DAO.HoaDonDAO, Model.HoaDon" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Title</title>
    <style>
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 5px;
            max-width: 500px;
            width: 100%;
        }

        .close {
            float: right;
            font-size: 20px;
            cursor: pointer;
        }

        body {

            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }

        .main-content {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #444;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 30px;
        }

        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        form input[type="text"],
        form input[type="password"],
        form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
            background: #f9f9f9;
        }

        form input[type="submit"] {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            text-align: left;
        }

        table thead {
            background-color: #4caf50;
            color: white;
        }

        table th, table td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

    </style>
</head>
<body>

<div class="main-content">
    
    <%
    HttpSession s = request.getSession(false);
    if (s == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Kiểm tra vai trò người dùng
    String role = (String) s.getAttribute("role");
    if ("admin".equals(role)) {
        response.sendRedirect("Quan_ly_khach_hang.jsp");
        return;
    }
    String username = (s != null) ? (String) s.getAttribute("username") : null;
    KhachHang khachHang = new KhachHangDAO().getCustomerByUsername(username);

    HoaDonDAO hoaDonDAO = new HoaDonDAO();
    List<HoaDon> hoaDons = hoaDonDAO.getHoaDonByKhachHang(khachHang.getIdKh());
    %>
    
    <h1>Thông tin cá nhân</h1>
    <a href="index.jsp">Quay lại</a>
    <form action="ProfileServlet" method="post">
        <input type="hidden" name="action" value="updateProfile">

        <label for="hoTen">Họ và tên:</label>
        <input type="text" id="hoTen" name="hoTen" value="<%= khachHang.getHoTen() %>" required>

        <label for="sdt">Số điện thoại:</label>
        <input type="text" id="sdt" name="sdt" value="<%= khachHang.getSdt() %>" required>

        <label for="diaChi">Địa chỉ:</label>
        <textarea id="diaChi" name="diaChi" required><%= khachHang.getDiaChi() %></textarea>

        <label for="taiKhoan">Tên tài khoản:</label>
        <input type="text" id="taiKhoan" name="taiKhoan" value="<%= khachHang.getTaiKhoan() %>" readonly>

        <label for="matKhau">Mật khẩu:</label>
        <input type="password" id="matKhau" name="matKhau" value="<%= khachHang.getMatKhau() %>" required>

        <input type="submit" value="Cập nhật thông tin">
    </form>

    <h1>Danh sách hóa đơn</h1>
    <table>
        <thead>
        <tr>
            <th>Mã hóa đơn</th>
            <th>Nhân viên giao hàng</th>
            <th>Số lượng sản phẩm</th>
            <th>Số tiền phải trả</th>
            <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <% if (hoaDons != null && !hoaDons.isEmpty()) {
            for (HoaDon hd : hoaDons) { %>
        <tr>
            <td>
                <a href="#" class="view-products" data-id="<%= hd.getIdHoaDon() %>"><%= hd.getIdHoaDon() %>
                </a>
            </td>
            <td><%= hd.getIdNhanVienGiaoHang() != null ? hd.getIdNhanVienGiaoHang() : "Chưa có" %>
            </td>
            <td><%= hd.getSoLuongSanPham() %>
            </td>
            <td><%= hd.getSoTienPhaiTra() %> VNĐ</td>
            <td><%= hd.getTrangThai() %>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="5">Bạn chưa có hóa đơn nào.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Modal -->
    <div id="productModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Danh sách sản phẩm</h2>
            <table>
                <thead>
                <tr>
                    <th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Ảnh</th>
                </tr>
                </thead>
                <tbody id="modalBody">
                <!-- Nội dung sẽ được thêm vào đây -->
                </tbody>
            </table>
        </div>
    </div>

</div>


</body>
</html>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('productModal');
        const modalBody = document.getElementById('modalBody');
        const closeBtn = modal.querySelector('.close');

        document.querySelectorAll('.view-products').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                let hoaDonId = this.innerHTML;

                // Gửi AJAX yêu cầu danh sách sản phẩm
                fetch(`GetSanPhamByHoaDon?idHoaDon=` + hoaDonId)
                    .then(response => response.json())
                    .then(data => {
                        console.log(data)
                        console.log(data)
                        modalBody.innerHTML = '';
                        for (const sp of data) {
                            modalBody.innerHTML += " <tr> <td> " + sp.id + " </td> <td> " + sp.name + " </td> <td> " + sp.price + " </td> <td> <img src='" + sp.image + "' width='100' height='70'> </td> </tr>";
                        }
                        modal.style.display = 'flex';
                    });
            });
        });

        closeBtn.addEventListener('click', function () {
            modal.style.display = 'none';
        });

        window.addEventListener('click', function (e) {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    });
</script>


