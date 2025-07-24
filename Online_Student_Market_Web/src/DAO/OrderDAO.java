package DAO;

import model.Order;
import model.OrderItem;
import model.Cart_Item;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class OrderDAO extends DBcontext {

    // Tạo order mới và trả về order_id
    public int createOrder(Order order) {
        String sql = "INSERT INTO [Order] (user_id, total_amount, payment_method, order_date, status, shipping_address, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUser_id());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, order.getPayment_method());
            ps.setDate(4, order.getOrder_date());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getShipping_address());

            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Thêm order items
    public boolean addOrderItems(int orderId, List<Cart_Item> cartItems) {
        String sql = "INSERT INTO Order_Item (order_id, product_id, unit_price, quantity) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            for (Cart_Item item : cartItems) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProduct().getProduct_id());
                ps.setBigDecimal(3, item.getProduct().getPrice());
                ps.setInt(4, item.getQuantity());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy orders của user
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE user_id = ? ORDER BY order_date DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrder_id(rs.getInt("order_id"));
                order.setUser_id(rs.getInt("user_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setPayment_method(rs.getString("payment_method"));
                order.setOrder_date(rs.getDate("order_date"));
                order.setStatus(rs.getString("status"));
                order.setShipping_address(rs.getString("shipping_address"));
                order.setCreated_at(rs.getDate("created_at"));
                order.setUpdated_at(rs.getDate("updated_at"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Lấy order items của một order
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM Order_Item WHERE order_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrder_item_id(rs.getInt("order_item_id"));
                item.setOrder_id(rs.getInt("order_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setUnit_price(rs.getBigDecimal("unit_price"));
                item.setQuantity(rs.getInt("quantity"));
                orderItems.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    // Tính tổng tiền từ cart items
    public BigDecimal calculateTotalAmount(List<Cart_Item> cartItems) {
        BigDecimal total = BigDecimal.ZERO;
        for (Cart_Item item : cartItems) {
            BigDecimal itemTotal = item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()));
            total = total.add(itemTotal);
        }
        return total;
    }

    // Xóa cart sau khi tạo order thành công
    public boolean clearCart(int cartId) {
        try {
            String deleteItemsSql = "DELETE FROM Cart_Item WHERE cart_id = ?";
            PreparedStatement ps = connection.prepareStatement(deleteItemsSql);
            ps.setInt(1, cartId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tạo class để chứa thông tin order item + product
    public static class OrderItemWithProduct {
        private OrderItem orderItem;
        private Product product;

        public OrderItemWithProduct(OrderItem orderItem, Product product) {
            this.orderItem = orderItem;
            this.product = product;
        }

        public OrderItem getOrderItem() {
            return orderItem;
        }

        public Product getProduct() {
            return product;
        }

        public void setOrderItem(OrderItem orderItem) {
            this.orderItem = orderItem;
        }

        public void setProduct(Product product) {
            this.product = product;
        }
    }

    // Lấy order items kèm thông tin sản phẩm
    public List<OrderItemWithProduct> getOrderItemsWithProductInfo(int orderId) {
        List<OrderItemWithProduct> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.product_name, p.image_url, p.price " +
                "FROM Order_Item oi " +
                "INNER JOIN Product p ON oi.product_id = p.product_id " +
                "WHERE oi.order_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrder_item_id(rs.getInt("order_item_id"));
                orderItem.setOrder_id(rs.getInt("order_id"));
                orderItem.setProduct_id(rs.getInt("product_id"));
                orderItem.setUnit_price(rs.getBigDecimal("unit_price"));
                orderItem.setQuantity(rs.getInt("quantity"));

                Product product = new Product();
                product.setProduct_id(rs.getInt("product_id"));
                product.setProduct_name(rs.getString("product_name"));
                product.setImage_url(rs.getString("image_url"));
                product.setPrice(rs.getBigDecimal("price"));

                items.add(new OrderItemWithProduct(orderItem, product));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    // ...existing code...


// ...existing code...

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();

        System.out.println(dao.getOrdersByUserId(1));
    }
}