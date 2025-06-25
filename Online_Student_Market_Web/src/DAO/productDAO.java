/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

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
                if (catName.value == null) {
                    catName.value = proSet.getString("category_name");
                }
                proList.add(mapRow(proSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return proList;
    }

    public Product getProductByID(int productID, Holder<String> catName) {
        String sql = "select p.*, c.category_name from Product p "
                + "join Category c on p.category_id = c.category_id "
                + "where product_id = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && catName.value == null) {
                catName.value = rs.getString("category_name");
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductBySort(String typeSort, double minPrice, double maxPrice) {
        List<Product> list = new ArrayList<>();
        String sql = """
                     select * from Product
                     where price between ? and ?
                     order by price ?;""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(0, minPrice);
            ps.setDouble(1, maxPrice);
            ps.setString(2, typeSort);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    public List<Product> findProduct(Integer categoryID, Double minPrice, Double maxPrice, String sortDir, int limit, int offset){
        List<Product> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("Select * from Product p where ");
        List<Object> params = new ArrayList<>();
        
        if(categoryID != null){
            sql.append("p.category_id = ? ");
            params.add(categoryID);
        }
        
        if(minPrice != null){
            sql.append("and p.price >= ? ");
            params.add(minPrice);
        }
        
        if(maxPrice != null){
            sql.append("and p.price <= ? ");
            params.add(maxPrice);
        }
        
        
        
        return productList;
    }

}
