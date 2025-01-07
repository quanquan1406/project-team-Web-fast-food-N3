package Model;

public class Admin {
    private String idAdmin; // ID_ADMIN trong cơ sở dữ liệu
    private String idTinTuc; // ID_TINTUC - liên kết với bảng TIN_TUC
    private String idKh; // ID_KH - liên kết với bảng KHACH_HANG
    private String hoTen; // HO_TEN
    private String diaChi; // DIA_CHI
    private String sdt; // SDT
    private String taiKhoan; // TAI_KHOAN
    private String matKhau; // MAT_KHAU

    // Constructor không tham số
    public Admin() {
    }

    // Constructor đầy đủ tham số
    public Admin(String idAdmin, String idTinTuc, String idKh, String hoTen, String diaChi, String sdt, String taiKhoan, String matKhau) {
        this.idAdmin = idAdmin;
        this.idTinTuc = idTinTuc;
        this.idKh = idKh;
        this.hoTen = hoTen;
        this.diaChi = diaChi;
        this.sdt = sdt;
        this.taiKhoan = taiKhoan;
        this.matKhau = matKhau;
    }

    // Getter và Setter cho từng trường
    public String getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(String idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getIdTinTuc() {
        return idTinTuc;
    }

    public void setIdTinTuc(String idTinTuc) {
        this.idTinTuc = idTinTuc;
    }

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

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
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
        return "Admin{" +
                "idAdmin='" + idAdmin + '\'' +
                ", idTinTuc='" + idTinTuc + '\'' +
                ", idKh='" + idKh + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", sdt='" + sdt + '\'' +
                ", taiKhoan='" + taiKhoan + '\'' +
                ", matKhau='" + matKhau + '\'' +
                '}';
    }
}
