<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.TinTucDAO, Model.TinTuc" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="admin-header.jsp" %>

<div class="main-content">
    <div class="header">
        <h1>Chỉnh sửa Tin Tức</h1>
        <div>
            <a href="Quan_ly_tin_tuc.jsp">Quay lại</a>
        </div>
    </div>
    <div class="dashboard-content">
        <%
            String id = request.getParameter("id");
            TinTucDAO tinTucDAO = new TinTucDAO();
            TinTuc tinTuc = null;

            try {
                tinTuc = tinTucDAO.getTinTucById(id);
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }

            if (tinTuc != null) {
        %>
        <br>
        <br>
        <form action="QuanLyTinTuc.jsp" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= tinTuc.getId() %>">

            <label for="content">Nội Dung:</label>
            <textarea id="content" name="content" required><%= tinTuc.getContent() %></textarea>

            <label for="image">Ảnh:</label>
            <input type="text" id="image" name="image" value="<%= tinTuc.getImage() %>">

            <label for="title">Tiêu Đề:</label>
            <input type="text" id="title" name="title" value="<%= tinTuc.getTitle() %>" required>

            <label for="datePosted">Ngày Đăng:</label>
            <input type="date" id="datePosted" name="datePosted" value="<%= tinTuc.getDatePosted() != null ? tinTuc.getDatePosted().toString() : "" %>" required>

            <input type="submit" value="Cập nhật">
        </form>
        <% } else { %>
        <div class="message error">Không tìm thấy tin tức!</div>
        <% } %>
    </div>
</div>

<%@ include file="admin-footer.jsp" %>
