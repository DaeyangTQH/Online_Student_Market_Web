/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.*;

/**
 *
 * @author Haichann
 */
public class productDAO extends DBcontext {

    public List<Product> getAll() {
        List<Product> proList = new ArrayList<>();
        String sql = "select * from Product";

        try {
            PreparedStatement getProFromDB = connection.prepareStatement(sql);
            ResultSet proSet = getProFromDB.executeQuery();

            while (proSet.next()) {
                Product p = new Product(
                        proSet.getInt("product_id"),
                        proSet.getInt("category_id"),
                        proSet.getString("product_name"),
                        proSet.getString("description"),
                        proSet.getBigDecimal("price"),
                        proSet.getInt("stock_quantity"),
                        proSet.getString("image_url"),
                        proSet.getDate("created_at"),
                        proSet.getDate("updated_at")
                );
                proList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return proList;
    }
}
