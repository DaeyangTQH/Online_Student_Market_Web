package model;

public class Cart_Item {

    private int cart_item_id;
    private int cart_id;
    private int product_id;
    private int quantity;

    public Cart_Item() {
    }

    public Cart_Item(int cart_item_id, int cart_id, int product_id, int quantity) {
        this.cart_item_id = cart_item_id;
        this.cart_id = cart_id;
        this.product_id = product_id;
        this.quantity = quantity;
    }

    public int getCart_item_id() {
        return cart_item_id;
    }

    public void setCart_item_id(int cart_item_id) {
        this.cart_item_id = cart_item_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "CartItem{"
                + "cart_item_id=" + cart_item_id
                + ", cart_id=" + cart_id
                + ", product_id=" + product_id
                + ", quantity=" + quantity
                + '}';
    }
}
