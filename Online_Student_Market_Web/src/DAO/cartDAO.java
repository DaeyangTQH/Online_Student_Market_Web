package DAO;

import Model.Cart_Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class cartDAO extends DBcontext {

    public int getCartIdByUser(int userId) throws SQLException {
        String sql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
        }
        // Nếu chưa có cart, tạo mới
        sql = "INSERT INTO Cart(user_id, created_at, updated_at) OUTPUT INSERTED.cart_id VALUES (?, GETDATE(), GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
        }
        throw new SQLException("Không thể lấy Cart ID");
    }

    public void addToCart(int cartId, int productId, int quantity) throws SQLException {
        String checkSql = "SELECT quantity FROM Cart_Item WHERE cart_id = ? AND product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(checkSql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int newQty = rs.getInt("quantity") + quantity;
                String updateSql = "UPDATE Cart_Item SET quantity = ? WHERE cart_id = ? AND product_id = ?";
                try (PreparedStatement ups = connection.prepareStatement(updateSql)) {
                    ups.setInt(1, newQty);
                    ups.setInt(2, cartId);
                    ups.setInt(3, productId);
                    ups.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO Cart_Item(cart_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement ips = connection.prepareStatement(insertSql)) {
                    ips.setInt(1, cartId);
                    ips.setInt(2, productId);
                    ips.setInt(3, quantity);
                    ips.executeUpdate();
                }
            }
        }
    }

    public List<Cart_Item> getCartItemsByUser(int userId) throws SQLException {
        List<Cart_Item> list = new ArrayList<>();
        String sql = """
            SELECT ci.*, p.product_name, p.price, p.image_url
            FROM Cart_Item ci
            JOIN Cart c ON ci.cart_id = c.cart_id
            JOIN Product p ON ci.product_id = p.product_id
            WHERE c.user_id = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart_Item item = new Cart_Item();
                item.setCart_item_id(rs.getInt("cart_item_id"));
                item.setCart_id(rs.getInt("cart_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProduct_name(rs.getString("product_name"));
                item.setPrice(rs.getDouble("price"));
                item.setImage_url(rs.getString("image_url"));
                list.add(item);
            }
        }
        return list;
    }
}

