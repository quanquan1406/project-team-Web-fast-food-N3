package Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.HoaDonDAO;
import Model.HoaDon;

@WebServlet("/hoadon")
public class HoaDonServlet extends HttpServlet {

    private final HoaDonDAO hoaDonDAO = new HoaDonDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<HoaDon> hoaDonList = hoaDonDAO.getAllHoaDon();
            request.setAttribute("hoaDonList", hoaDonList);
            request.getRequestDispatcher("Quan_ly_don_hang.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Không thể tải danh sách hóa đơn", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đảm bảo hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String idHoaDon = request.getParameter("idHoaDon");

        if ("updateStatus".equals(action)) {
            String newStatus = request.getParameter("status");
            try {
                hoaDonDAO.updateStatus(idHoaDon, newStatus);
                response.sendRedirect("hoadon");
            } catch (ClassNotFoundException | SQLException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cập nhật trạng thái thất bại");
            }
        }
    }

}
