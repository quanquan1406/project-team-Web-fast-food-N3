package Controller;

import DAO.DatHangDAO;
import DAO.HoaDonDAO;
import DAO.KhachHangDAO;
import DAO.SanPhamDAO;
import Model.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/processCheckout")
public class CheckoutServlet extends HttpServlet {

    private DatHangDAO datHangService = new DatHangDAO();
    private HoaDonDAO hoaDonService = new HoaDonDAO();
    private KhachHangDAO khachHangDAO = new KhachHangDAO();
    private SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Bạn cần đăng nhập để thanh toán!");
            return;
        }
        KhachHang khachHang = khachHangDAO.getCustomerByUsername(session.getAttribute("username").toString());

        // 1. Đọc dữ liệu giỏ hàng từ request
        String cartData = request.getReader().lines().reduce("", String::concat);
        List<Cart> cartItems = parseCartData(cartData);

        // 2. Tính toán tổng số lượng và tổng tiền
        BigDecimal totalAmount = BigDecimal.ZERO;
        int totalQuantity = 0;

        // Chuyển từ Cart sang DatHang và tính toán tổng tiền và tổng số lượng
        List<DatHang> datHangList = new ArrayList<>();
        SanPham sanPham = null;
        for (Cart cartItem : cartItems) {
            try {
                sanPham = sanPhamDAO.getSanPhamByName(cartItem.getName());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            DatHang datHang = new DatHang();
            datHang.setIdDh(generateDatHangId());
            datHang.setIdKh(khachHang.getIdKh());
            datHang.setIdSp(sanPham.getId());
            datHang.setThanhToan(BigDecimal.valueOf(cartItem.getPrice()).multiply(BigDecimal.valueOf(cartItem.getQuantity())));
            datHang.setThoiGianDat(LocalDateTime.now());
            datHangList.add(datHang);

            totalAmount = totalAmount.add(datHang.getThanhToan());
            totalQuantity += cartItem.getQuantity();
        }

        // 3. Tạo hóa đơn mới
        String hoaDonId = generateHoaDonId();
        HoaDon hoaDon = new HoaDon(hoaDonId, "NVGH001", totalQuantity, totalAmount.doubleValue(), "Chờ Xác Nhận");

        // Lưu hóa đơn vào cơ sở dữ liệu
        boolean hoaDonSaved = false;
        try {
            hoaDonSaved = hoaDonService.addHoaDon(hoaDon);
        } catch (ClassNotFoundException | SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Đã xảy ra lỗi khi lưu hóa đơn. Vui lòng thử lại.");
            return;
        }

        // 4. Lưu các chi tiết giỏ hàng (DatHang) vào cơ sở dữ liệu
        if (hoaDonSaved) {
            for (DatHang item : datHangList) {
                item.setIdHoaDon(hoaDonId);  // Gán ID hóa đơn cho các item
                try {
                    datHangService.addDatHang(item);  // Lưu từng DatHang
                } catch (ClassNotFoundException | SQLException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Đã xảy ra lỗi khi lưu chi tiết đơn hàng. Vui lòng thử lại.");
                    return;
                }
            }
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Thanh toán thành công! Tổng tiền: " + totalAmount);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Đã xảy ra lỗi khi thanh toán. Vui lòng thử lại.");
        }
    }

    // Phương thức parse cartData để chuyển chuỗi JSON thành List<Cart>
    private List<Cart> parseCartData(String cartData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(cartData, new TypeReference<List<Cart>>() {
        });
    }

    // Phương thức tạo ID hóa đơn
    private String generateHoaDonId() {
        return "HD" + System.currentTimeMillis();  // Ví dụ, bạn có thể tạo ID theo cách khác
    }
    // Phương thức tạo ID hóa đơn
    private String generateDatHangId() {
        return "DH" + System.currentTimeMillis();  // Ví dụ, bạn có thể tạo ID theo cách khác
    }
}
