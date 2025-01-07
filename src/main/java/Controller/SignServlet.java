package Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.KhachHang;
import DAO.KhachHangDAO;
import java.io.IOException;

@WebServlet("/sign")
public class SignServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set UTF-8 encoding for both request and response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy thông tin từ form
        String hoTen = request.getParameter("hoTen");
        String sdt = request.getParameter("sdt");
        String diaChi = request.getParameter("diaChi");
        String taiKhoan = request.getParameter("taiKhoan");
        String matKhau = request.getParameter("matKhau");

        // Kiểm tra thông tin đầu vào
        if (hoTen == null || hoTen.trim().isEmpty() ||
            sdt == null || sdt.trim().isEmpty() ||
            diaChi == null || diaChi.trim().isEmpty() ||
            taiKhoan == null || taiKhoan.trim().isEmpty() ||
            matKhau == null || matKhau.trim().isEmpty()) {
            response.getWriter().write("Vui lòng nhập đầy đủ thông tin!");
            return;
        }

        // Lấy mã khách hàng mới tự động
        KhachHangDAO khachHangDAO = new KhachHangDAO();
        String newId = khachHangDAO.generateNewId();

        // Tạo đối tượng KhachHang với mã khách hàng tự động sinh
        KhachHang khachHang = new KhachHang(newId, hoTen, sdt, diaChi, taiKhoan, matKhau);

        // Gọi DAO để thêm khách hàng
        boolean isAdded = khachHangDAO.addKhachHang(khachHang);

        // Xử lý kết quả
        if (isAdded) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().write("Đăng ký thất bại! Vui lòng thử lại.");
        }
    }
}
