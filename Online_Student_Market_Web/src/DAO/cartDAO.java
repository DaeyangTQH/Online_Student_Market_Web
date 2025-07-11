/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Cart_Item;

/**
 *
 * @author ThuyAnh
 */
public class cartDAO extends DBcontext{
        public ArrayList<Cart_Item> getCartItemsByCartId(int cartId) {
        ArrayList<Cart_Item> list = new ArrayList<>();
        String sql = "SELECT * FROM Cart_Item WHERE cart_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart_Item item = new Cart_Item(
                    rs.getInt("cart_item_id"),
                    rs.getInt("cart_id"),
                    rs.getInt("product_id"),
                    rs.getInt("quantity")
                );
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
        public static void main(String[] args) {
        cartDAO check = new cartDAO();
        
        System.out.println(check.getCartItemsByCartId(1));
    }
}
