<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map, java.util.HashMap, java.util.TreeMap" %>
<%@ page import="DAO.HoaDonDAO" %>
<%@ include file="admin-header.jsp" %> <!-- Tệp chứa phần header và layout -->

<div class="main-content">
    <div class="header">
        <h1>Báo cáo doanh thu theo tháng</h1>
        <div>
            <a href="index.jsp">Trang chủ</a>
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
    <div class="dashboard-content">
        <div class="chart-container">
            <canvas id="revenueChart"></canvas>
        </div>
        <div style="margin-bottom: 20px;">
            <form action="ExportRevenueCSV" method="get">
                <button type="submit" class="btn btn-primary">Xuất file CSV</button>
            </form>
        </div>
        <table>
            <thead>
            <tr>
                <th>Tháng</th>
                <th>Tổng số đơn hàng</th>
                <th>Doanh thu (VNĐ)</th>
            </tr>
            </thead>
            <tbody>
            <%
                HoaDonDAO hoaDonDAO = new HoaDonDAO();
                Map<String, Map<String, Object>> doanhThuTheoThang = hoaDonDAO.getDoanhThuTheoThang();

                // Sử dụng TreeMap để tự động sắp xếp theo key (tháng)
                TreeMap<String, Map<String, Object>> sortedDoanhThu = new TreeMap<>(doanhThuTheoThang);

                // Dữ liệu cho biểu đồ
                StringBuilder chartLabels = new StringBuilder("[");
                StringBuilder chartData = new StringBuilder("[");
                boolean first = true;

                for (Map.Entry<String, Map<String, Object>> entry : sortedDoanhThu.entrySet()) {
                    String thang = entry.getKey();
                    Map<String, Object> thongTin = entry.getValue();
                    long tongSoDonHang = (long) thongTin.get("tongSoDonHang");
                    double tongDoanhThu = (double) thongTin.get("tongDoanhThu");

                    // Thêm dữ liệu vào bảng
            %>
            <tr>
                <td><%= thang %></td>
                <td><%= tongSoDonHang %></td>
                <td><%= String.format("%,.0f", tongDoanhThu) %></td>
            </tr>
            <%
                    // Thêm dữ liệu vào biểu đồ
                    if (!first) {
                        chartLabels.append(", ");
                        chartData.append(", ");
                    }
                    chartLabels.append("\"").append(thang).append("\"");
                    chartData.append(tongDoanhThu);
                    first = false;
                }
                chartLabels.append("]");
                chartData.append("]");
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Dữ liệu biểu đồ
    const labels = <%= chartLabels.toString() %>;
    const data = {
        labels: labels,
        datasets: [{
            label: 'Doanh thu (VNĐ)',
            data: <%= chartData.toString() %>,
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    };

    // Cấu hình biểu đồ
    const config = {
        type: 'bar', // Loại biểu đồ: 'bar' (cột)
        data: data,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    };

    // Khởi tạo biểu đồ
    const revenueChart = new Chart(
        document.getElementById('revenueChart'),
        config
    );
</script>

<%@ include file="admin-footer.jsp" %> <!-- Tệp chứa phần footer -->
