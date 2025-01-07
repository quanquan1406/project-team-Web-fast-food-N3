package DAO;

import Model.HoaDon;
import Model.SanPham;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HoaDonDAO {

    public List<SanPham> getSanPhamByHoaDon(String idHoaDon) throws SQLException {
        List<SanPham> sanPhams = new ArrayList<>();
        String query = "SELECT sp.* FROM SAN_PHAM sp JOIN DAT_HANG dh ON sp.ID_SP = dh.ID_SP WHERE dh.ID_HOADON = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, idHoaDon);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham(
                            rs.getString("ID_SP"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")
                    );
                    sanPhams.add(sp);
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return sanPhams;
    }


    public List<HoaDon> getHoaDonByKhachHang(String idKh) throws SQLException {
        List<HoaDon> hoaDons = new ArrayList<>();
        String sql =
                " SELECT DISTINCT hd.*"
                        + " FROM Hoa_Don hd"
                        +" INNER JOIN Dat_Hang dh ON hd.ID_HOADON = dh.ID_HOADON"
                        + " WHERE dh.ID_KH = ?";


        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idKh);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    HoaDon hoaDon = new HoaDon(
                            rs.getString("ID_HOADON"),
                            rs.getString("ID_NVGH"),
                            rs.getInt("SOLUONG_SP"),
                            rs.getDouble("SOTIEN_PHAITRA"),
                            rs.getString("TRANG_THAI")
                    );
                    hoaDons.add(hoaDon);
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return hoaDons;
    }
    // Lấy tất cả hóa đơn
    public List<HoaDon> getAllHoaDon() throws ClassNotFoundException, SQLException {
        List<HoaDon> hoaDonList = new ArrayList<>();
        String query = "SELECT * FROM HOA_DON";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String idHoaDon = rs.getString("ID_HOADON");
                String idNhanVienGiaoHang = rs.getString("ID_NVGH");
                int soLuongSanPham = rs.getInt("SOLUONG_SP");
                double soTienPhaiTra = rs.getDouble("SOTIEN_PHAITRA");
                String trangThai = rs.getString("TRANG_THAI");

                HoaDon hoaDon = new HoaDon(idHoaDon, idNhanVienGiaoHang, soLuongSanPham, soTienPhaiTra, trangThai);
                hoaDonList.add(hoaDon);
            }
        }
        return hoaDonList;
    }

    // Cập nhật trạng thái hóa đơn
    public void updateStatus(String idHoaDon, String trangThai) throws ClassNotFoundException, SQLException {
        String query = "UPDATE HOA_DON SET TRANG_THAI = ? WHERE ID_HOADON = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, trangThai);
            pstmt.setString(2, idHoaDon);
            pstmt.executeUpdate();
        }
    }

    // Thêm hóa đơn mới vào cơ sở dữ liệu
    public boolean addHoaDon(HoaDon hoaDon) throws ClassNotFoundException, SQLException {
        String query = "INSERT INTO HOA_DON (ID_HOADON, ID_NVGH, SOLUONG_SP, SOTIEN_PHAITRA, TRANG_THAI) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, hoaDon.getIdHoaDon());
            pstmt.setString(2, hoaDon.getIdNhanVienGiaoHang());
            pstmt.setInt(3, hoaDon.getSoLuongSanPham());
            pstmt.setDouble(4, hoaDon.getSoTienPhaiTra());
            pstmt.setString(5, hoaDon.getTrangThai());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public Map<String, Map<String, Object>> getDoanhThuTheoThang() {
        Map<String, Map<String, Object>> doanhThuTheoThang = new HashMap<>();

        String query = "SELECT DATE_FORMAT(THOIGIAN_DAT, '%Y-%m') AS Thang, COUNT(*) AS TongSoDonHang, SUM(SOTIEN_PHAITRA) AS TongDoanhThu " +
                "FROM HOA_DON hd " +
                "JOIN DAT_HANG dh ON hd.ID_HOADON = dh.ID_HOADON " +
                " where hd.TRANG_THAI = 'Đã Giao' GROUP BY Thang " +
                "ORDER BY Thang ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String thang = rs.getString("Thang");
                long tongSoDonHang = rs.getLong("TongSoDonHang");
                double tongDoanhThu = rs.getDouble("TongDoanhThu");

                Map<String, Object> thongTin = new HashMap<>();
                thongTin.put("tongSoDonHang", tongSoDonHang);
                thongTin.put("tongDoanhThu", tongDoanhThu);

                doanhThuTheoThang.put(thang, thongTin);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return doanhThuTheoThang;
    }
}
