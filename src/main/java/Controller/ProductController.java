package Controller;

import DAO.DBConnection;
import DAO.SanPhamDAO;
import Model.SanPham;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/product")
public class ProductController extends HttpServlet {
    SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("list".equals(action)) {
                listProducts(request, response);
            } else if ("delete".equals(action)) {
                deleteProduct(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException | ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addProduct(request, response);
            } else if ("update".equals(action)) {
                updateProduct(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException | ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred");
            e.printStackTrace();
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        List<SanPham> productList = sanPhamDAO.getAllSanPham();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("Quan_ly_san_pham.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ClassNotFoundException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        String category = request.getParameter("category");
        // Kiểm tra các trường đầu vào không được bỏ trống
        if ( name == null || priceStr == null || description == null || image == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product information");
            return;
        }
        double price;
        // Kiểm tra tính hợp lệ của giá
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid price format");
            return;
        }
        sanPhamDAO.addSanPham(new SanPham(generateId(), name, price, description, image,category));
        // Redirect người dùng về trang danh sách sản phẩm
        response.sendRedirect("product?action=list");
    }


    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ClassNotFoundException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        String category = request.getParameter("category");

        if (idStr == null || name == null || priceStr == null || description == null || image == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product information");
            return;
        }

        double price;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID or price format");
            return;
        }
        sanPhamDAO.updateSanPham(new SanPham(idStr, name, price, description, image,category));
        response.sendRedirect("product?action=list");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ClassNotFoundException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
            return;
        }
        sanPhamDAO.deleteSanPham(idStr);
        response.sendRedirect("product?action=list");
    }

    // Phương thức tạo ID hóa đơn
    private String generateId() {
        return "SP" + System.currentTimeMillis();  // Ví dụ, bạn có thể tạo ID theo cách khác
    }
}
