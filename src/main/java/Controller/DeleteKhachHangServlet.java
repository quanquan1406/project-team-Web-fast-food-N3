package Controller;

import Model.KhachHang;
import DAO.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/delete")
public class DeleteKhachHangServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String makh = request.getParameter("makh");

        // Xóa các đơn đặt hàng liên quan trước
        String sqldat_hang = "DELETE FROM dat_hang WHERE ID_KH = ?";
        String sqlkhach_hang = "DELETE FROM khach_hang WHERE ID_KH = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // Xóa đơn hàng
            try (PreparedStatement pstmtDH = conn.prepareStatement(sqldat_hang)) {
                pstmtDH.setString(1, makh);
                pstmtDH.executeUpdate();
            }

            // Xóa khách hàng
            try (PreparedStatement pstmtKH = conn.prepareStatement(sqlkhach_hang)) {
                pstmtKH.setString(1, makh);
                pstmtKH.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteKhachHangServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect("list");
    }
}