package model;

import java.math.BigDecimal;

public class Order {

    private int order_id;
    private int user_id;
    private BigDecimal totalAmount;
    private String payment_method;
    private java.sql.Date order_date;
    private String status;
    private String shipping_address;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;

    public Order() {
    }

    public Order(int order_id, int user_id, java.math.BigDecimal totalAmount, String payment_method, java.sql.Date order_date, String status, String shipping_address, java.sql.Date created_at, java.sql.Date updated_at) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.totalAmount = totalAmount;
        this.payment_method = payment_method;
        this.order_date = order_date;
        this.status = status;
        this.shipping_address = shipping_address;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPayment_method() {
        return payment_method;
    }

    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    public java.sql.Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(java.sql.Date order_date) {
        this.order_date = order_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
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
