package Model;

public class HoaDon {
    private String idHoaDon;
    private String idNhanVienGiaoHang;
    private int soLuongSanPham;
    private double soTienPhaiTra;
    private String trangThai;

    public HoaDon(String idHoaDon, String idNhanVienGiaoHang, int soLuongSanPham, double soTienPhaiTra, String trangThai) {
        this.idHoaDon = idHoaDon;
        this.idNhanVienGiaoHang = idNhanVienGiaoHang;
        this.soLuongSanPham = soLuongSanPham;
        this.soTienPhaiTra = soTienPhaiTra;
        this.trangThai = trangThai;
    }

    public String getIdHoaDon() {
        return idHoaDon;
    }

    public String getIdNhanVienGiaoHang() {
        return idNhanVienGiaoHang;
    }

    public int getSoLuongSanPham() {
        return soLuongSanPham;
    }

    public double getSoTienPhaiTra() {
        return soTienPhaiTra;
    }

    public String getTrangThai() {
        return trangThai;
    }
}
