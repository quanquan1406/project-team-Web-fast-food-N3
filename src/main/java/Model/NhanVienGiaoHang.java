package Model;

public class NhanVienGiaoHang {
    private String idNvgh; // ID_NVGH
    private String hoTen; // HO_TEN
    private String sdtNv; // SDT_NV

    // Constructor không tham số
    public NhanVienGiaoHang() {
    }

    // Constructor đầy đủ tham số
    public NhanVienGiaoHang(String idNvgh, String hoTen, String sdtNv) {
        this.idNvgh = idNvgh;
        this.hoTen = hoTen;
        this.sdtNv = sdtNv;
    }

    // Getter và Setter cho từng trường
    public String getIdNvgh() {
        return idNvgh;
    }

    public void setIdNvgh(String idNvgh) {
        this.idNvgh = idNvgh;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSdtNv() {
        return sdtNv;
    }

    public void setSdtNv(String sdtNv) {
        this.sdtNv = sdtNv;
    }

    // Phương thức toString để hiển thị thông tin đối tượng
    @Override
    public String toString() {
        return "NhanVienGiaoHang{" +
                "idNvgh=" + idNvgh +
                ", hoTen='" + hoTen + '\'' +
                ", sdtNv='" + sdtNv + '\'' +
                '}';
    }
}

