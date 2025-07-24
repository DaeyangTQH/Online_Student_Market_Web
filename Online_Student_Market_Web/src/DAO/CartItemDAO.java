package DAO;

import model.Cart_Item;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO extends DBcontext {

    public List<Cart_Item> getCart_ItemsByCartId(int cartId) {
        List<Cart_Item> list = new ArrayList<>();
        String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.quantity, " +
                "p.product_name, p.image_url, p.price " +
                "FROM cart_item ci JOIN product p ON ci.product_id = p.product_id " +
                "WHERE ci.cart_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo Product object
                    Product p = new Product();
                    p.setProduct_id(rs.getInt("product_id"));
                    p.setProduct_name(rs.getString("product_name"));
                    p.setImage_url(rs.getString("image_url"));
                    p.setPrice(rs.getBigDecimal("price"));

                    // Tạo Cart_Item object
                    Cart_Item item = new Cart_Item();
                    item.setCart_item_id(rs.getInt("cart_item_id"));
                    item.setCart_id(rs.getInt("cart_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProduct(p); // gán product

                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void deleteCartItemById(int cartItemId) {
        String sql = "DELETE FROM cart_item WHERE cart_item_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addOrUpdateCartItem(int cartId, int productId, int quantity) {
        String selectSql = "SELECT cart_item_id, quantity FROM cart_item WHERE cart_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart_item SET quantity = ? WHERE cart_item_id = ?";
        String insertSql = "INSERT INTO cart_item (cart_id, product_id, quantity) VALUES (?, ?, ?)";

        try (PreparedStatement ps1 = connection.prepareStatement(selectSql)) {
            ps1.setInt(1, cartId);
            ps1.setInt(2, productId);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                // đã tồn tại -> cập nhật
                int cartItemId = rs.getInt("cart_item_id");
                int currentQty = rs.getInt("quantity");
                try (PreparedStatement ps2 = connection.prepareStatement(updateSql)) {
                    ps2.setInt(1, currentQty + quantity);
                    ps2.setInt(2, cartItemId);
                    ps2.executeUpdate();
                }
            } else {
                // chưa có -> thêm mới
                try (PreparedStatement ps3 = connection.prepareStatement(insertSql)) {
                    ps3.setInt(1, cartId);
                    ps3.setInt(2, productId);
                    ps3.setInt(3, quantity);
                    ps3.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCartItem(int cartId, int productId) {
        String sql = "DELETE FROM cart_item WHERE cart_id = ? AND product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
