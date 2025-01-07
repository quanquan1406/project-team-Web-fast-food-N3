<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.HoaDon" %>
<%@ page import="DAO.HoaDonDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%
    request.setCharacterEncoding("UTF-8");

    List<HoaDon> hoaDonList = null;
    String message = "";

    try {
        HoaDonDAO hoaDonDAO = new HoaDonDAO();

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String idHoaDon = request.getParameter("idHoaDon");
            String newStatus = request.getParameter("status");

            if (idHoaDon != null && newStatus != null) {
                hoaDonDAO.updateStatus(idHoaDon, newStatus);
                message = "Cập nhật trạng thái thành công!";
            }
        }

        hoaDonList = hoaDonDAO.getAllHoaDon();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        message = "Đã xảy ra lỗi: " + e.getMessage();
    }
%>
<%@ include file="admin-header.jsp" %> <!-- Tệp chứa phần header và layout -->
<div class="main-content">
    <div class="header">
        <h1>Quản lý hóa đơn</h1>
        <div>
            <a href="index.jsp">Trang chủ</a>
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
    <div class="dashboard-content">
        <!-- Hiển thị thông báo -->
        <% if (!message.isEmpty()) { %>
        <p class="<%= message.startsWith("Đã xảy ra") ? "error" : "message" %>"><%= message %></p>
        <% } %>

        <table>
            <tr>
                <th>ID Hóa Đơn</th>
                <th>ID NV Giao Hàng</th>
                <th>Số Lượng Sản Phẩm</th>
                <th>Số Tiền Phải Trả</th>
                <th>Trạng Thái</th>
                <th>Thao Tác</th>
            </tr>
            <% if (hoaDonList != null && !hoaDonList.isEmpty()) { %>
            <% for (HoaDon hoaDon : hoaDonList) { %>
            <tr>
                <td><%= hoaDon.getIdHoaDon() %></td>
                <td><%= hoaDon.getIdNhanVienGiaoHang() %></td>
                <td><%= hoaDon.getSoLuongSanPham() %></td>
                <td><%= hoaDon.getSoTienPhaiTra() %></td>
                <td><%= hoaDon.getTrangThai() %></td>
                <td>
                    <!-- Form cập nhật trạng thái -->
                    <form action="" method="post">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="idHoaDon" value="<%= hoaDon.getIdHoaDon() %>">
                        <select name="status">
                            <option value="Đã Giao" <%= hoaDon.getTrangThai().equals("Đã Giao") ? "selected" : "" %>>Đã Giao</option>
                            <option value="Đang Giao" <%= hoaDon.getTrangThai().equals("Đang Giao") ? "selected" : "" %>>Đang Giao</option>
                            <option value="Chờ Xác Nhận" <%= hoaDon.getTrangThai().equals("Chờ Xác Nhận") ? "selected" : "" %>>Chờ Xác Nhận</option>
                        </select>
                        <input type="submit" class="button button-update" value="Cập Nhật">
                    </form>
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="6">Không có hóa đơn nào.</td>
            </tr>
            <% } %>
        </table>
    </div>

</div>

<%@ include file="admin-footer.jsp" %> <!-- Tệp chứa phần footer -->



