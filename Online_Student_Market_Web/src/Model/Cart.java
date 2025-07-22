package models;

public class Cart {

    private int cart_id;
    private int user_id;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;

    public Cart() {
    }

    public Cart(int cart_id, int user_id, java.sql.Date created_at, java.sql.Date updated_at) {
        this.cart_id = cart_id;
        this.user_id = user_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
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