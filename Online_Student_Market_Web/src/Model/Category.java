package models;

public class Category {

    private int category_id;
    private String category_name;
    private String category_description;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;
    private String category_image_url;

    public Category() {
    }

    public Category(int category_id, String category_name, String category_description, java.sql.Date created_at, java.sql.Date updated_at, String category_image_url) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.category_description = category_description;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.category_image_url = category_image_url;
    }

    public String getCategory_image_url() {
        return category_image_url;
    }

    public void setCategory_image_url(String category_image_url) {
        this.category_image_url = category_image_url;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getCategory_description() {
        return category_description;
    }

    public void setCategory_description(String category_description) {
        this.category_description = category_description;
    }

    public java.sql.Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(java.sql.Date created_at) {
        this.created_at = created_at;
    }

    public java.sql.Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(java.sql.Date updated_at) {
        this.updated_at = updated_at;
    }
}
