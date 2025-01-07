package Controller;

import DAO.KhachHangDAO;
import Model.KhachHang;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            // Lấy thông tin từ form
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String diaChi = request.getParameter("diaChi");
            String matKhau = request.getParameter("matKhau");

            // Lấy tài khoản hiện tại từ session
            String username = (String) request.getSession().getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            KhachHang khachHang = new KhachHangDAO().getCustomerByUsername(username);
            // Cập nhật thông tin
            khachHang.setHoTen(hoTen);
            khachHang.setSdt(sdt);
            khachHang.setDiaChi(diaChi);
            khachHang.setMatKhau(matKhau);

            KhachHangDAO khachHangDAO = new KhachHangDAO();
            try {
                khachHangDAO.updateKhachHang(khachHang);
                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
            }

            // Reload lại trang profile
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
        }
    }
}

