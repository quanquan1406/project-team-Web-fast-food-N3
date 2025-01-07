package Controller;

import DAO.TinTucDAO;
import Model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/QuanLyTinTuc.jsp")
public class QuanLyTinTucServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String id = request.getParameter("id");
            String content = request.getParameter("content");
            String image = request.getParameter("image");
            String title = request.getParameter("title");
            Date datePosted = Date.valueOf(request.getParameter("datePosted"));

            TinTuc tinTuc = new TinTuc(id, content, image, title, datePosted);

            TinTucDAO tinTucDAO = new TinTucDAO();
            try {
                tinTucDAO.addTinTuc(tinTuc);
                response.sendRedirect("Quan_ly_tin_tuc.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            TinTucDAO tinTucDAO = new TinTucDAO();
            try {
                tinTucDAO.deleteTinTuc(id);
                response.sendRedirect("Quan_ly_tin_tuc.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else if ("update".equals(action)) {
            String id = request.getParameter("id");
            String content = request.getParameter("content");
            String image = request.getParameter("image");
            String title = request.getParameter("title");
            Date datePosted = Date.valueOf(request.getParameter("datePosted"));

            TinTuc tinTuc = new TinTuc(id, content, image, title, datePosted);

            TinTucDAO tinTucDAO = new TinTucDAO();
            try {
                tinTucDAO.updateTinTuc(tinTuc);
                response.sendRedirect("Quan_ly_tin_tuc.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}


