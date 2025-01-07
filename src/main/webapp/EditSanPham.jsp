<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.SanPham" %>
<%@ page import="DAO.SanPhamDAO" %>
<%@ include file="admin-header.jsp" %>
<!-- Tệp chứa phần header và layout -->

<div class="main-content">
    <div class="header">
        <h1>Chỉnh sửa Sản Phẩm</h1>
        <div>
            <a href="Quan_ly_san_pham.jsp">Quay lại</a>
        </div>
    </div>
    <div class="dashboard-content">
        <%
            SanPhamDAO sanPhamDAO = new SanPhamDAO();
            String id = request.getParameter("id");
            SanPham product = sanPhamDAO.getSanPhamById(id);

            if (product != null) {
        %>
        <br>
        <br>
        <form action="product" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <label>Tên:</label>
            <input type="text" name="name" value="<%= product.getName() %>" required>
            <label>Loại:</label>
            <input type="text" name="category" value="<%= product.getCategory() %>" required>
            <label>Giá:</label>
            <input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" required>
            <label>Mô tả:</label>
            <input type="text" name="description" value="<%= product.getDescription() %>">
            <label>Hình ảnh:</label>
            <input type="text" name="image" value="<%= product.getImage() %>">
            <input type="submit" class="button" value="Cập nhật sản phẩm">
        </form>

        <% } else { %>
        <div class="message error">Không tìm thấy san pham!</div>
        <% } %>
    </div>
</div>
<%@ include file="admin-footer.jsp" %>
