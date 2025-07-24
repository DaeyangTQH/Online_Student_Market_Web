package Model;

import java.math.BigDecimal;
import java.sql.Date;

public class Product {

    private int product_id;
    private int subCategory_id;
    private String product_name;
    private String description;
    private BigDecimal price;
    private int stock_quantity;
    private String image_url;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;

    public Product() {
    }

    public Product(int product_id, int subCategory_id, String product_name, String description, BigDecimal price, int stock_quantity, String image_url, Date created_at, Date updated_at) {
        this.product_id = product_id;
        this.subCategory_id = subCategory_id;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.image_url = image_url;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getSubCategory_id() {
        return subCategory_id;
    }

    public void setSubCategory_id(int subCategory_id) {
        this.subCategory_id = subCategory_id;
    }

    

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    
}
