package DAO;

import Model.Cart_Item;
import Model.Product;
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
}
