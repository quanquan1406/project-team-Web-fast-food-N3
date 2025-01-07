package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {

    public boolean validateAdmin(String username, String password) {
        // Query kiểm tra tài khoản admin với tài khoản và mật khẩu
        String query = "SELECT * FROM ADMIN WHERE TAI_KHOAN = ? AND MAT_KHAU = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username); // Tài khoản (username)
            ps.setString(2, password); // Mật khẩu (password)
            
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu có kết quả trả về, tài khoản và mật khẩu hợp lệ
                return rs.next(); 
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false; // Trả về false nếu không tìm thấy tài khoản admin hợp lệ
    }
}
