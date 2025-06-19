/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.*;

/**
 *
 * @author Haichann
 */
public class productDAO extends DBcontext {

    private Product mapRow(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("product_id"),
                rs.getInt("category_id"),
                rs.getString("product_name"),
                rs.getString("description"),
                rs.getBigDecimal("price"),
                rs.getInt("stock_quantity"),
                rs.getString("image_url"),
                rs.getDate("created_at"),
                rs.getDate("updated_at")
        );
    }

    public List<Product> getAll() {
        List<Product> proList = new ArrayList<>();
        String sql = "select * from Product";

        try {
            PreparedStatement getProFromDB = connection.prepareStatement(sql);
            ResultSet proSet = getProFromDB.executeQuery();

            while (proSet.next()) {
                
                proList.add(mapRow(proSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return proList;
    }

    public List<Product> getProductByCategoryID(int categoryID, Holder<String> catName) {
        List<Product> proList = new ArrayList<>();
        String sql = """
                     select p.*, c.category_name from Product p
                     join Category c
                     on p.category_id = c.category_id
                     where p.category_id = ?""";
        try {
            PreparedStatement getProByCatID = connection.prepareStatement(sql);
            getProByCatID.setInt(1, categoryID);
            ResultSet proSet = getProByCatID.executeQuery();
            while (proSet.next()) {
                if(catName == null){
                    catName.value = proSet.getString("category_name");
                }
                proList.add(mapRow(proSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return proList;
    }
}
