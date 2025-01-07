package Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import DAO.KhachHangDAO;
import DAO.AdminDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập UTF-8 để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy thông tin từ form login
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isValid = false;

        // Kiểm tra đăng nhập theo vai trò
        if ("customer".equals(role)) {
            KhachHangDAO khachHangDAO = new KhachHangDAO();
            isValid = khachHangDAO.validateCustomer(username, password);
        } else if ("admin".equals(role)) {
            AdminDAO adminDAO = new AdminDAO();
            isValid = adminDAO.validateAdmin(username, password);
        }

        if (isValid) {
            // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("username", username); // Lưu tên đăng nhập vào session
            session.setAttribute("role", role); // Lưu vai trò (customer/admin)
            session.setAttribute("isLoggedIn", true); // Thêm trạng thái đăng nhập

            // Nếu là admin, chuyển hướng đến trang admin.jsp
            if ("admin".equals(role)) {
                response.sendRedirect("Quan_ly_khach_hang.jsp");
            } else {
                // Nếu là customer, chuyển hướng đến trang chủ
                response.sendRedirect("index.jsp");
            }
        } else {
            // Nếu đăng nhập thất bại, quay lại trang login và hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu!"); 
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
