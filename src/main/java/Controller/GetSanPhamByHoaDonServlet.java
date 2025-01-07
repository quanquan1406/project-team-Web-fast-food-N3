package Controller;

import DAO.HoaDonDAO;
import Model.SanPham;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GetSanPhamByHoaDon")
public class GetSanPhamByHoaDonServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        String idHoaDon = request.getParameter("idHoaDon");
        HoaDonDAO hoaDonDAO = new HoaDonDAO();
        List<SanPham> sanPhams = new ArrayList<>();
        try {
            sanPhams = hoaDonDAO.getSanPhamByHoaDon(idHoaDon);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            Gson gson = new Gson();
            out.print(gson.toJson(sanPhams));
        }
    }
}

