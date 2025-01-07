package Controller;
import DAO.TinTucDAO;
import Model.TinTuc;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/newsDetail")
public class NewsDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");  // Lấy ID của tin tức từ URL

        if (id != null) {
            try {
                TinTucDAO tinTucDAO = new TinTucDAO();
                TinTuc tinTuc = tinTucDAO.getTinTucById(id);  // Lấy tin tức từ database theo ID

                if (tinTuc != null) {
                    request.setAttribute("tinTuc", tinTuc);  // Chuyển tin tức vào request attribute
                    RequestDispatcher dispatcher = request.getRequestDispatcher("newsDetail.jsp");
                    dispatcher.forward(request, response);  // Chuyển hướng đến JSP để hiển thị chi tiết tin tức
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tin tức không tồn tại");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy dữ liệu tin tức");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số ID");
        }
    }
}

