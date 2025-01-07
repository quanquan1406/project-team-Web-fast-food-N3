package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import Model.KhachHang;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class KhachHangDAO {

    public void updateKhachHang(KhachHang khachHang) throws SQLException {
        String sql = "UPDATE Khach_Hang SET HO_TEN = ?, SDT = ?, DIA_CHI = ?, MAT_KHAU = ? WHERE ID_KH = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, khachHang.getHoTen());
            stmt.setString(2, khachHang.getSdt());
            stmt.setString(3, khachHang.getDiaChi());
            stmt.setString(4, khachHang.getMatKhau());
            stmt.setString(5, khachHang.getIdKh());
            stmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    // Phương thức lấy tất cả thông tin khách hàng
    public List<KhachHang> getAllCustomers() {
        List<KhachHang> customers = new ArrayList<>();
        String query = "SELECT * FROM KHACH_HANG";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                KhachHang kh = new KhachHang();
                kh.setIdKh(rs.getString("ID_KH"));
                kh.setHoTen(rs.getString("HO_TEN"));
                kh.setSdt(rs.getString("SDT"));
                kh.setDiaChi(rs.getString("DIA_CHI"));
                kh.setTaiKhoan(rs.getString("TAI_KHOAN"));
                kh.setMatKhau(rs.getString("MAT_KHAU"));
                customers.add(kh); // Thêm khách hàng vào danh sách
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return customers;
    }

    // Phương thức thêm khách hàng vào cơ sở dữ liệu
    public boolean addKhachHang(KhachHang khachHang) {
        String sql = "INSERT INTO KHACH_HANG (ID_KH, HO_TEN, SDT, DIA_CHI, TAI_KHOAN, MAT_KHAU) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Thiết lập giá trị cho các tham số
            preparedStatement.setString(1, khachHang.getIdKh());
            preparedStatement.setString(2, khachHang.getHoTen());
            preparedStatement.setString(3, khachHang.getSdt());
            preparedStatement.setString(4, khachHang.getDiaChi());
            preparedStatement.setString(5, khachHang.getTaiKhoan());
            preparedStatement.setString(6, khachHang.getMatKhau());

            // Thực thi câu lệnh SQL
            int rowsInserted = preparedStatement.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu thêm thành công

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false; // Trả về false nếu xảy ra lỗi
        }
    }

    
    public boolean validateCustomer(String username, String password) {
        String query = "SELECT * FROM KHACH_HANG WHERE TAI_KHOAN = ? AND MAT_KHAU = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Trả về true nếu tìm thấy tài khoản
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Phương thức sinh mã khách hàng mới
    public String generateNewId() {
        String sql = "SELECT MAX(ID_KH) FROM KHACH_HANG";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                String lastId = resultSet.getString(1);
                if (lastId != null) {
                    // Lấy phần số trong mã khách hàng
                    int lastIdNumber = Integer.parseInt(lastId.substring(2));
                    int newIdNumber = lastIdNumber + 1;
                    return "KH" + String.format("%03d", newIdNumber); // Sinh mã mới theo định dạng KHxxx
                }
            }
            return "KH001"; // Nếu chưa có khách hàng nào, bắt đầu từ KH001
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return "KH001"; // Nếu có lỗi, trả về mã mặc định
        }
    }
    
     // Phương thức lấy thông tin đầy đủ của khách hàng dựa trên tài khoản và mật khẩu
    public KhachHang getCustomerByCredentials(String username, String password) {
        String query = "SELECT * FROM KHACH_HANG WHERE TAI_KHOAN = ? AND MAT_KHAU = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    KhachHang kh = new KhachHang();
                    kh.setIdKh(rs.getString("ID_KH"));
                    kh.setHoTen(rs.getString("HO_TEN"));
                    kh.setSdt(rs.getString("SDT"));
                    kh.setDiaChi(rs.getString("DIA_CHI"));
                    kh.setTaiKhoan(rs.getString("TAI_KHOAN"));
                    kh.setMatKhau(rs.getString("MAT_KHAU"));
                    return kh; // Trả về đối tượng KhachHang nếu tìm thấy
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy hoặc có lỗi
    }

    public KhachHang getCustomerByUsername(String username) {
        String query = "SELECT * FROM KHACH_HANG WHERE TAI_KHOAN = ? ";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    KhachHang kh = new KhachHang();
                    kh.setIdKh(rs.getString("ID_KH"));
                    kh.setHoTen(rs.getString("HO_TEN"));
                    kh.setSdt(rs.getString("SDT"));
                    kh.setDiaChi(rs.getString("DIA_CHI"));
                    kh.setTaiKhoan(rs.getString("TAI_KHOAN"));
                    kh.setMatKhau(rs.getString("MAT_KHAU"));
                    return kh; // Trả về đối tượng KhachHang nếu tìm thấy
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy hoặc có lỗi
    }

    public boolean deleteCustomer(String idKh) {
    String deleteOrders = "DELETE FROM DAT_HANG WHERE ID_KH = ?";
    String deleteAdmin = "DELETE FROM ADMIN WHERE ID_KH = ?";
    String deleteCustomer = "DELETE FROM KHACH_HANG WHERE ID_KH = ?";
    
    Connection conn = null; // Khai báo ngoài try
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false);  // Bắt đầu transaction

        // Kiểm tra nếu khách hàng tồn tại trong bảng KHACH_HANG
        String checkCustomerExistence = "SELECT COUNT(*) FROM KHACH_HANG WHERE ID_KH = ?";
        try (PreparedStatement psCheck = conn.prepareStatement(checkCustomerExistence)) {
            psCheck.setString(1, idKh);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next() && rs.getInt(1) == 0) {
                    System.out.println("Customer does not exist.");
                    return false;
                }
            }
        }

        // Xóa các đơn hàng liên quan
        try (PreparedStatement psOrders = conn.prepareStatement(deleteOrders)) {
            psOrders.setString(1, idKh);
            psOrders.executeUpdate();
        }

        // Xóa các admin liên quan
        try (PreparedStatement psAdmin = conn.prepareStatement(deleteAdmin)) {
            psAdmin.setString(1, idKh);
            psAdmin.executeUpdate();
        }

        // Xóa khách hàng
        try (PreparedStatement psCustomer = conn.prepareStatement(deleteCustomer)) {
            psCustomer.setString(1, idKh);
            int rowsDeleted = psCustomer.executeUpdate();

            if (rowsDeleted > 0) {
                conn.commit();  // Commit transaction nếu xóa thành công
                System.out.println("Customer deleted successfully.");
                return true;
            } else {
                conn.rollback();  // Rollback nếu không xóa được khách hàng
                System.out.println("Failed to delete customer.");
            }
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        if (conn != null) {
            try {
                conn.rollback();  // Rollback nếu có lỗi trong transaction
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    } finally {
        // Đảm bảo rằng kết nối được đóng sau khi hoàn thành
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    return false;  // Trả về false nếu có lỗi xảy ra
}


}

