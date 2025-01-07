<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.SanPham" %>
<%@ page import="DAO.SanPhamDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%
    String errorMessage = "";
    String successMessage = "";
    List<SanPham> productList = null;

    try {
        SanPhamDAO sanPhamDAO = new SanPhamDAO();
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            String category = request.getParameter("category");

            SanPham newProduct = new SanPham(id, name, price, description, image,category);
            sanPhamDAO.addSanPham(newProduct);
            successMessage = "Thêm sản phẩm thành công!";
        } else if ("edit".equals(action)) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            String category = request.getParameter("category");

            SanPham updatedProduct = new SanPham(id, name, price, description, image,category);
            sanPhamDAO.updateSanPham(updatedProduct);
            successMessage = "Cập nhật sản phẩm thành công!";
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            sanPhamDAO.deleteSanPham(id);
            successMessage = "Xóa sản phẩm thành công!";
        }

        productList = sanPhamDAO.getAllSanPham();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        errorMessage = "Đã xảy ra lỗi: " + e.getMessage();
    }
%>
<%@ include file="admin-header.jsp" %>
<div class="main-content">
    <div class="header">
        <h1>Quản lý Sản Phẩm</h1>
        <div>
            <a href="index.jsp">Trang chủ</a>
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
    <div class="dashboard-content">
        <% if (!errorMessage.isEmpty()) { %>
        <div class="message error"><%= errorMessage %></div>
        <% } %>
        <% if (!successMessage.isEmpty()) { %>
        <div class="message success"><%= successMessage %></div>
        <% } %>
        <br>

        <!-- Form thêm sản phẩm -->
        <form action="Quan_ly_san_pham.jsp" method="post">
            <input type="hidden" name="action" value="add">
            <label for="id">Mã sản phẩm:</label>
            <input type="text" id="id" name="id" required>
            <label for="name">Tên sản phẩm:</label>
            <input type="text" id="name" name="name" required>
            <label for="category">Loại sản phẩm:</label>
            <input type="text" id="category" name="category" required>
            <label for="price">Giá:</label>
            <input type="number" id="price" name="price" step="0.01" required>
            <label for="description">Mô tả:</label>
            <input type="text" id="description" name="description">
            <label for="image">Hình ảnh:</label>
            <input type="text" id="image" name="image">
            <input type="submit" value="Thêm sản phẩm">
        </form>

        <!-- Bảng danh sách sản phẩm -->
        <table>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Số lượt bán</th>
                <th>Mô tả</th>
                <th>Hình ảnh</th>
                <th>Thao tác</th>
            </tr>
            <% if (productList != null && !productList.isEmpty()) { %>
                        <% java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("#,##0.00"); %>

            <% for (SanPham product : productList) { %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getSales() %></td>
                <td><%= product.getDescription() %></td>
                <td><img src="<%= product.getImage() %>" width="100" height="60"></td>
                <td>
                    <form action="Quan_ly_san_pham.jsp" method="post" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <input type="submit" class="button button-danger" value="Xóa">
                    </form>
                    <form action="EditSanPham.jsp" method="get" class="inline">
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <input type="submit" class="button button-edit" value="Sửa">
                    </form>
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="6">Không có sản phẩm nào.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

<%@ include file="admin-footer.jsp" %>
