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

    public List<Product> findProduct(Integer categoryID, Double minPrice, Double maxPrice, String sortDir, int limit, int offset, Holder<String> catName) {
        List<Product> productList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, c.category_name FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (categoryID != null) {
            sql.append("AND p.category_id = ? ");
            params.add(categoryID);
        }

        if (minPrice != null) {
            sql.append("AND p.price >= ? ");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append("AND p.price <= ? ");
            params.add(maxPrice);
        }

        if (sortDir != null && (sortDir.equalsIgnoreCase("desc") || sortDir.equalsIgnoreCase("asc"))) {
            sql.append("ORDER BY p.price ").append(sortDir).append(" ");
        } else {
            sql.append("ORDER BY p.product_id "); 
        }

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (catName.value == null) {
                    catName.value = rs.getString("category_name");
                }
                productList.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public int countProduct(Integer categoryID, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Product p WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (categoryID != null) {
            sql.append("AND p.category_id = ? ");
            params.add(categoryID);
        }

        if (minPrice != null) {
            sql.append("AND p.price >= ? ");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append("AND p.price <= ? ");
            params.add(maxPrice);
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public Double getMinPrice(Integer categoryID) {
        String sql = "SELECT MIN(price) FROM Product" + (categoryID != null ? " WHERE category_id = ?" : "");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (categoryID != null) ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
    }

    public Double getMaxPrice(Integer categoryID) {
        String sql = "SELECT MAX(price) FROM Product" + (categoryID != null ? " WHERE category_id = ?" : "");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (categoryID != null) ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
    }

    public static void main(String[] args) {
        productDAO dao = new productDAO();
        List<Product> list = new ArrayList<>();
        Holder<String> catName = new Holder<>();
        list = dao.findProduct(1, null, null, null, 15, 0, catName);
        
        double min = dao.getMinPrice(1);
        System.out.println(min);
    }
}
