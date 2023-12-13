package pe.edu.vallegrande.app.models;

public class Product {
    private int id;
    private String code;
    private String name;
    private String price;
    private String description;
    private String status;
    private String storeType;

    public Product(int id, String code, String name, String price, String description, String status, String storeType) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.price = price;
        this.description = description;
        this.status = status;
        this.storeType = storeType;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    @Override
    public String toString() {
        return "Product [" + id + ", " + code + ", " + name + ", " + price +
                ", " + description + ", " + status + ", " + storeType + "]";
    }
}
