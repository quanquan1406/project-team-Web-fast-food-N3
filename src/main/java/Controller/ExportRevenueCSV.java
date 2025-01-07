package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.HoaDonDAO;

@WebServlet("/ExportRevenueCSV")
public class ExportRevenueCSV extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập header cho file CSV
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"doanh_thu.csv\"");

        HoaDonDAO hoaDonDAO = new HoaDonDAO();
        Map<String, Map<String, Object>> doanhThuTheoThang = hoaDonDAO.getDoanhThuTheoThang();

        try (PrintWriter writer = response.getWriter()) {
            // Ghi tiêu đề cột
            writer.println("Tháng,Tổng số đơn hàng,Doanh thu (VNĐ)");

            // Ghi dữ liệu
            for (Map.Entry<String, Map<String, Object>> entry : doanhThuTheoThang.entrySet()) {
                String thang = entry.getKey();
                Map<String, Object> thongTin = entry.getValue();
                long tongSoDonHang = (long) thongTin.get("tongSoDonHang");
                double tongDoanhThu = (double) thongTin.get("tongDoanhThu");

                writer.printf("%s,%d,%.0f%n", thang, tongSoDonHang, tongDoanhThu);
            }
        }
    }
}

