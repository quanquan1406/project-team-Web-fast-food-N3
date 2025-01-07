package Model;

public class KhachHang {
    private String idKh; // ID_KH
    private String hoTen; // HO_TEN
    private String sdt; // SDT
    private String diaChi; // DIA_CHI
    private String taiKhoan; // TAI_KHOAN
    private String matKhau; // MAT_KHAU

    // Constructor không tham số
    public KhachHang() {
    }

    // Constructor đầy đủ tham số
    public KhachHang(String idKh, String hoTen, String sdt, String diaChi, String taiKhoan, String matKhau) {
        this.idKh = idKh;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.diaChi = diaChi;
        this.taiKhoan = taiKhoan;
        this.matKhau = matKhau;
    }

    // Getter và Setter cho từng trường
    public String getIdKh() {
        return idKh;
    }

    public void setIdKh(String idKh) {
        this.idKh = idKh;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getTaiKhoan() {
        return taiKhoan;
    }

    public void setTaiKhoan(String taiKhoan) {
        this.taiKhoan = taiKhoan;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    // Phương thức toString để hiển thị thông tin đối tượng
    @Override
    public String toString() {
        return "KhachHang{" +
                "idKh=" + idKh +
                ", hoTen='" + hoTen + '\'' +
                ", sdt='" + sdt + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", taiKhoan='" + taiKhoan + '\'' +
                ", matKhau='" + matKhau + '\'' +
                '}';
    }
}
