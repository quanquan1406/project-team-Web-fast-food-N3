package Model;

public class Cart {
    private String name;
    private double price;
    private String image;
    private String description;
    private int quantity;

    // Constructor không tham số
    public Cart() {
    }

    // Constructor đầy đủ tham số
    public Cart(String name, double price, String image, String description, int quantity) {
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.quantity = quantity;
    }

    // Getter và Setter cho từng trường
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Phương thức toString để hiển thị thông tin đối tượng
    @Override
    public String toString() {
        return "Product{" +
                "name='" + name + '\'' +
                ", price=" + price +
                ", image='" + image + '\'' +
                ", description='" + description + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}

