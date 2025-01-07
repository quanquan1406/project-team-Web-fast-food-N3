<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.TinTucDAO, Model.TinTuc" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>

<%@ include file="admin-header.jsp" %> <!-- Tệp chứa phần header và layout -->
<div class="main-content">
    <div class="header">
        <h1>Quản lý Tin Tức</h1>
        <div>
            <a href="index.jsp">Trang chủ</a>
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
    <div class="dashboard-content">
        <table>
            <thead>
            <tr>
                <th>ID Tin Tức</th>
                <th>Nội Dung</th>
                <th>Ảnh</th>
                <th>Tiêu Đề</th>
                <th>Ngày Đăng</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <%
                String errorMessage = "";
                String successMessage = "";

                TinTucDAO tinTucDAO = new TinTucDAO();
                List<TinTuc> newsList = null;
                try {
                    // Lấy danh sách tin tức
                    newsList = tinTucDAO.getAllTinTuc();
                } catch (SQLException | ClassNotFoundException e) {
                    errorMessage = "Lỗi khi lấy dữ liệu tin tức.";
                    e.printStackTrace();
                }

                if (newsList != null && !newsList.isEmpty()) {
                    for (TinTuc tinTuc : newsList) {
            %>
            <tr>
                <td><%= tinTuc.getId() %></td>
                <td><%= tinTuc.getContent() %></td>
                <td><img src="<%= tinTuc.getImage() %>" alt="Image" width="100" height="60"></td>
                <td><%= tinTuc.getTitle() %></td>
                <td><%= tinTuc.getDatePosted() %></td>
                <td>
                    <form action="QuanLyTinTuc.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= tinTuc.getId() %>">
                        <input type="submit" value="Xóa">
                    </form>
                    <form action="editTinTuc.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= tinTuc.getId() %>">
                        <input type="submit" value="Sửa">
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <% if (!errorMessage.isEmpty()) { %>
        <div class="message error"><%= errorMessage %></div>
        <% } %>
        <% if (!successMessage.isEmpty()) { %>
        <div class="message success"><%= successMessage %></div>
        <% } %>

        <!-- Form thêm tin tức -->
        <h2>Thêm Tin Tức</h2>
        <form action="QuanLyTinTuc.jsp" method="post">
            <input type="hidden" name="action" value="add">
            <label for="id">ID Tin Tức:</label>
            <input type="text" id="id" name="id" required>
            <label for="content">Nội Dung:</label>
            <textarea id="content" name="content" required></textarea>
            <label for="image">Ảnh:</label>
            <input type="text" id="image" name="image">
            <label for="title">Tiêu Đề:</label>
            <input type="text" id="title" name="title" required>
            <label for="datePosted">Ngày Đăng:</label>
            <input type="date" id="datePosted" name="datePosted" required>
            <input type="submit" value="Thêm">
        </form>
    </div>
</div>
<%@ include file="admin-footer.jsp" %>
