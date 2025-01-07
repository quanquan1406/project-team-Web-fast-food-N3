package Model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class DatHang {
    private String idDh;  // ID đơn hàng
    private String idKh;  // ID khách hàng
    private String idHoaDon;  // ID hóa đơn
    private String idSp;  // ID sản phẩm
    private BigDecimal thanhToan;  // Thanh toán (BigDecimal hoặc String, tuỳ vào cách bạn xử lý)
    private LocalDateTime thoiGianDat;  // Thời gian đặt hàng

    // Constructor không tham số
    public DatHang() {
    }

    // Constructor đầy đủ tham số
    public DatHang(String idDh, String idKh, String idHoaDon, String idSp, BigDecimal thanhToan, LocalDateTime thoiGianDat) {
        this.idDh = idDh;
        this.idKh = idKh;
        this.idHoaDon = idHoaDon;
        this.idSp = idSp;
        this.thanhToan = thanhToan;
        this.thoiGianDat = thoiGianDat;
    }

    // Getter và Setter cho từng trường
    public String getIdDh() {
        return idDh;
    }

    public void setIdDh(String idDh) {
        this.idDh = idDh;
    }

    public String getIdKh() {
        return idKh;
    }

    public void setIdKh(String idKh) {
        this.idKh = idKh;
    }

    public String getIdHoaDon() {
        return idHoaDon;
    }

    public void setIdHoaDon(String idHoaDon) {
        this.idHoaDon = idHoaDon;
    }

    public String getIdSp() {
        return idSp;
    }

    public void setIdSp(String idSp) {
        this.idSp = idSp;
    }

    public BigDecimal getThanhToan() {
        return thanhToan;
    }

    public void setThanhToan(BigDecimal thanhToan) {
        this.thanhToan = thanhToan;
    }

    public LocalDateTime getThoiGianDat() {
        return thoiGianDat;
    }

    public void setThoiGianDat(LocalDateTime thoiGianDat) {
        this.thoiGianDat = thoiGianDat;
    }

    // Phương thức toString để hiển thị thông tin đối tượng
    @Override
    public String toString() {
        return "DatHang{" +
                "idDh='" + idDh + '\'' +
                ", idKh='" + idKh + '\'' +
                ", idHoaDon='" + idHoaDon + '\'' +
                ", idSp='" + idSp + '\'' +
                ", thanhToan=" + thanhToan +
                ", thoiGianDat=" + thoiGianDat +
                '}';
    }
}
