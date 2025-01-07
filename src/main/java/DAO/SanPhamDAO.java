package DAO;

import Model.SanPham;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SanPhamDAO {

    public List<String> getAllLoaiSanPham() {
        List<String> loaiSanPhamList = new ArrayList<>();
        String query = "SELECT DISTINCT LOAI_SP FROM SAN_PHAM";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String loaiSp = resultSet.getString("LOAI_SP");
                loaiSanPhamList.add(loaiSp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return loaiSanPhamList;
    }

    public List<SanPham> getTopSellingProducts(int limit) throws SQLException, ClassNotFoundException {
        List<SanPham> topProducts = new ArrayList<>();
        String query =
                "SELECT sp.ID_SP, sp.TEN_SP, sp.GIA_TIEN, sp.MO_TA,sp.LOAI_SP, sp.ANH, COUNT(dh.ID_SP) AS total_orders"
                        + " FROM SAN_PHAM sp"
                        + " JOIN DAT_HANG dh ON sp.ID_SP = dh.ID_SP"
                        + " GROUP BY sp.ID_SP"
                        + " ORDER BY total_orders DESC"
                        + " LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham product = new SanPham(
                            rs.getString("ID_SP"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")
                    );
                    topProducts.add(product);
                }
            }
        }
        return topProducts;
    }


    public List<SanPham> getSanPhamPaging(int page, int pageSize) throws SQLException, ClassNotFoundException {
        List<SanPham> productList = new ArrayList<>();
        String query = "SELECT * FROM SAN_PHAM LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, pageSize); // Số sản phẩm mỗi trang
            ps.setInt(2, (page - 1) * pageSize); // Bỏ qua số sản phẩm đã hiển thị

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham product = new SanPham(
                            rs.getString("id_sp"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")

                    );
                    productList.add(product);
                }
            }
        }
        return productList;
    }

    // Đếm tổng số sản phẩm
    public int getTotalProducts() throws SQLException, ClassNotFoundException {
        String query = "SELECT COUNT(*) AS total FROM SAN_PHAM";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }


    // Xóa sản phẩm
    public void deleteSanPham(String id) throws SQLException, ClassNotFoundException {
    String deleteDatHangQuery = "DELETE FROM DAT_HANG WHERE ID_SP = ?";
    String deleteSanPhamQuery = "DELETE FROM SAN_PHAM WHERE ID_SP = ?";

    try (Connection conn = DBConnection.getConnection()) {
        conn.setAutoCommit(false); // Bắt đầu transaction

        try (PreparedStatement psDatHang = conn.prepareStatement(deleteDatHangQuery);
             PreparedStatement psSanPham = conn.prepareStatement(deleteSanPhamQuery)) {

            // Xóa dữ liệu trong bảng DAT_HANG
            psDatHang.setString(1, id);
            psDatHang.executeUpdate();

            // Xóa dữ liệu trong bảng SAN_PHAM
            psSanPham.setString(1, id);
            psSanPham.executeUpdate();

            conn.commit(); // Xác nhận transaction
        } catch (SQLException ex) {
            conn.rollback(); // Rollback nếu có lỗi
            throw ex;
        }
    }
}

    // Lấy danh sách tất cả sản phẩm
    public List<SanPham> getAllSanPham() throws SQLException, ClassNotFoundException {
        List<SanPham> topProducts = new ArrayList<>();
        String query =
                "SELECT sp.ID_SP, sp.TEN_SP, sp.GIA_TIEN, sp.MO_TA,sp.LOAI_SP, sp.ANH, COUNT(dh.ID_SP) AS total_orders"
                        + " FROM SAN_PHAM sp"
                        + " left JOIN DAT_HANG dh ON sp.ID_SP = dh.ID_SP"
                        + " GROUP BY sp.ID_SP"
                        + " ORDER BY total_orders DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham product = new SanPham(
                            rs.getString("ID_SP"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")
                    );
                    product.setSales(rs.getInt("total_orders"));
                    topProducts.add(product);
                }
            }
        }
        return topProducts;
    }

    public SanPham getSanPhamByName(String name) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM SAN_PHAM WHERE TEN_SP = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            // Sử dụng tham số hóa để bảo mật
            ps.setString(1, name);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SanPham(
                            rs.getString("id_sp"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")

                    );
                } else {
                    return null;  // Không tìm thấy sản phẩm
                }
            }
        } catch (Exception e) {
            // Ghi lại lỗi và trả về null hoặc ném lỗi tùy vào yêu cầu
            e.printStackTrace();
            return null;
        }
    }


    // Lấy thông tin sản phẩm theo ID
    public SanPham getSanPhamById(String id) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM SAN_PHAM WHERE id_sp = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SanPham(
                            rs.getString("id_sp"),
                            rs.getString("TEN_SP"),
                            rs.getDouble("GIA_TIEN"),
                            rs.getString("MO_TA"),
                            rs.getString("ANH"),
                            rs.getString("LOAI_SP")

                    );
                }
            }
        }
        return null; // Trả về null nếu không tìm thấy sản phẩm
    }

    public void addSanPham(SanPham sanPham) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO SAN_PHAM (ID_SP, TEN_SP, GIA_TIEN, MO_TA, ANH,LOAI_SP) VALUES (?, ?, ?, ?, ?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, sanPham.getId());
            ps.setString(2, sanPham.getName());
            ps.setDouble(3, sanPham.getPrice());
            ps.setString(4, sanPham.getDescription());
            ps.setString(5, sanPham.getImage());
            ps.setString(6, sanPham.getCategory());

            ps.executeUpdate();
        }
    }

    public void updateSanPham(SanPham sanPham) throws SQLException, ClassNotFoundException {
        String query = "UPDATE SAN_PHAM SET TEN_SP = ?, GIA_TIEN = ?, MO_TA = ?, ANH = ?, LOAI_SP = ? WHERE ID_SP = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, sanPham.getName());
            ps.setDouble(2, sanPham.getPrice());
            ps.setString(3, sanPham.getDescription());
            ps.setString(4, sanPham.getImage());
            ps.setString(5, sanPham.getCategory());
            ps.setString(6, sanPham.getId());

            ps.executeUpdate();
        }
    }
    // Trong SanPhamDAO.java
    public List<SanPham> getTopProductsByCategory(String category) {
        List<SanPham> productList = new ArrayList<>();
        String query = "SELECT * FROM San_Pham WHERE LOAI_SP = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SanPham product = new SanPham();
                product.setId(rs.getString("id_sp"));
                product.setName(rs.getString("TEN_SP"));
                product.setDescription(rs.getString("MO_TA"));
                product.setPrice(rs.getDouble("GIA_TIEN"));
                product.setImage(rs.getString("ANH"));
                product.setCategory(rs.getString("LOAI_SP"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }

}
