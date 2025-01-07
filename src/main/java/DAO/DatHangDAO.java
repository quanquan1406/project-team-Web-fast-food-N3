package DAO;

import Model.DatHang;
import Model.HoaDon;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatHangDAO {

    // Thêm một đơn hàng mới vào bảng DAT_HANG
    public boolean addDatHang(DatHang datHang) throws ClassNotFoundException, SQLException {
        String query = "INSERT INTO DAT_HANG (ID_DH, ID_KH, ID_HOADON, ID_SP, THANH_TOAN, THOIGIAN_DAT) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, datHang.getIdDh());  // ID đơn hàng
            pstmt.setString(2, datHang.getIdKh());  // ID khách hàng (có thể lấy từ session)
            pstmt.setString(3, datHang.getIdHoaDon());  // ID hóa đơn
            pstmt.setString(4, datHang.getIdSp());  // ID sản phẩm
            pstmt.setString(5, datHang.getThanhToan().toString());  // Thanh toán (varchar)
            pstmt.setTimestamp(6, Timestamp.valueOf(datHang.getThoiGianDat()));  // Thời gian đặt (datetime)

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu insert thành công
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    // Cập nhật trạng thái đơn hàng (nếu cần)
    public void updateDatHangStatus(String idDh, String trangThai) throws ClassNotFoundException, SQLException {
        String query = "UPDATE DAT_HANG SET TRANG_THAI = ? WHERE ID_DH = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, trangThai);
            pstmt.setString(2, idDh);
            pstmt.executeUpdate();
        }
    }
}
