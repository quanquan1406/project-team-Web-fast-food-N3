<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.KhachHangDAO" %>
<%@ page import="Model.KhachHang" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>

<%@ include file="admin-header.jsp" %> <!-- Tệp chứa phần header và layout -->

<div class="main-content">
    <div class="header">
        <h1>Quản lý Khách Hàng</h1>
        <div>
            <a href="index.jsp">Trang chủ</a>
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
    <div class="dashboard-content">
        <table>
            <thead>
            <tr>
                <th>ID Khách Hàng</th>
                <th>Họ Tên</th>
                <th>Số Điện Thoại</th>
                <th>Địa Chỉ</th>
                <th>Tài Khoản</th>
                <th>Mật Khẩu</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Lấy danh sách khách hàng từ KhachHangDAO
                KhachHangDAO khachHangDAO = new KhachHangDAO();
                List<KhachHang> customers = khachHangDAO.getAllCustomers();

                // Hiển thị thông tin khách hàng trong bảng
                for (KhachHang customer : customers) {
            %>
            <tr>
                <td><%= customer.getIdKh() %></td>
                <td><%= customer.getHoTen() %></td>
                <td><%= customer.getSdt() %></td>
                <td><%= customer.getDiaChi() %></td>
                <td><%= customer.getTaiKhoan() %></td>
                <td><%= customer.getMatKhau() %></td>
                <td>
                    <!-- Liên kết Xóa khách hàng -->
                    <a href="Quan_ly_khach_hang.jsp?action=delete&id=<%= customer.getIdKh() %>">Xóa</a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="admin-footer.jsp" %> <!-- Tệp chứa phần footer -->
<%!
    // Kiểm tra nếu có yêu cầu xóa khách hàng
    public void deleteCustomerIfRequested(HttpServletRequest request, HttpServletResponse response) throws IOException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action) && id != null) {
            KhachHangDAO khachHangDAO = new KhachHangDAO();
            boolean isDeleted = khachHangDAO.deleteCustomer(id);

            // Kiểm tra nếu xóa thành công
            if (isDeleted) {
                response.getWriter().write("<script>alert('Khách hàng đã được xóa');window.location.href='Quan_ly_khach_hang.jsp';</script>");
            } else {
                response.getWriter().write("<script>alert('Lỗi khi xóa khách hàng');</script>");
            }
        }
    }
%>

<%
    // Gọi phương thức xử lý yêu cầu xóa nếu có
    deleteCustomerIfRequested(request, response);
%>