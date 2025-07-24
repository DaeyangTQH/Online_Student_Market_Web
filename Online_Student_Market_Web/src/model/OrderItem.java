package model;

import java.math.BigDecimal;

public class OrderItem {

    private int order_item_id;
    private int order_id;
    private int product_id;
    private BigDecimal unit_price;
    private int quantity;

    public OrderItem() {
    }

    public OrderItem(int order_item_id, int order_id, int product_id, java.math.BigDecimal unit_price, int quantity) {
        this.order_item_id = order_item_id;
        this.order_id = order_id;
        this.product_id = product_id;
        this.unit_price = unit_price;
        this.quantity = quantity;
    }

    public int getOrder_item_id() {
        return order_item_id;
    }

    public void setOrder_item_id(int order_item_id) {
        this.order_item_id = order_item_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public BigDecimal getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(BigDecimal unit_price) {
        this.unit_price = unit_price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
