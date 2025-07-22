/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Cart;

/**
 *
 * @author ThuyAnh
 */
import java.sql.*;

public class CartDAO extends DBcontext {

    public Cart getCartByUserId(int userId) {
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Cart(rs.getInt("cart_id"), userId,
                        rs.getDate("created_at"), rs.getDate("updated_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Cart createCartForUser(int userId) {
        String sql = "INSERT INTO cart (user_id, created_at, updated_at) VALUES (?, CURRENT_DATE, CURRENT_DATE)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int cartId = rs.getInt(1);
                return new Cart(cartId, userId, new java.sql.Date(System.currentTimeMillis()), new java.sql.Date(System.currentTimeMillis()));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCartIdByUserId(int userId) {
    String sql = "SELECT cart_id FROM cart WHERE user_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("cart_id");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1;
}


}
