package DAO;

import Model.TinTuc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TinTucDAO {

    // Lấy danh sách tin tức
    public List<TinTuc> getAllTinTuc() throws SQLException, ClassNotFoundException {
        List<TinTuc> newsList = new ArrayList<>();
        String query = "SELECT * FROM TIN_TUC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TinTuc tinTuc = new TinTuc(
                        rs.getString("ID_TINTUC"),
                        rs.getString("NOI_DUNG"),
                        rs.getString("ANH"),
                        rs.getString("TIEU_DE"),
                        rs.getDate("NGAY_DANG")
                );
                newsList.add(tinTuc);
            }
        }
        return newsList;
    }

    // Thêm tin tức
    public void addTinTuc(TinTuc tinTuc) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO TIN_TUC (ID_TINTUC, NOI_DUNG, ANH, TIEU_DE, NGAY_DANG) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, tinTuc.getId());
            ps.setString(2, tinTuc.getContent());
            ps.setString(3, tinTuc.getImage());
            ps.setString(4, tinTuc.getTitle());
            ps.setDate(5, new java.sql.Date(tinTuc.getDatePosted().getTime()));

            ps.executeUpdate();
        }
    }

    // Cập nhật tin tức
    public void updateTinTuc(TinTuc tinTuc) throws SQLException, ClassNotFoundException {
        String query = "UPDATE TIN_TUC SET NOI_DUNG = ?, ANH = ?, TIEU_DE = ?, NGAY_DANG = ? WHERE ID_TINTUC = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, tinTuc.getContent());
            ps.setString(2, tinTuc.getImage());
            ps.setString(3, tinTuc.getTitle());
            ps.setDate(4, new java.sql.Date(tinTuc.getDatePosted().getTime()));
            ps.setString(5, tinTuc.getId());

            ps.executeUpdate();
        }
    }

    // Xóa tin tức
    public void deleteTinTuc(String id) throws SQLException, ClassNotFoundException {
        String query = "DELETE FROM TIN_TUC WHERE ID_TINTUC = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }

    // Lấy tin tức theo ID
    public TinTuc getTinTucById(String id) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM TIN_TUC WHERE ID_TINTUC = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TinTuc(
                            rs.getString("ID_TINTUC"),
                            rs.getString("NOI_DUNG"),
                            rs.getString("ANH"),
                            rs.getString("TIEU_DE"),
                            rs.getDate("NGAY_DANG")
                    );
                }
            }
        }
        return null;
    }
}

