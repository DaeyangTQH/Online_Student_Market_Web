/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
            if (categoryID != null) {
                ps.setInt(1, categoryID);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public Double getMaxPrice(Integer categoryID) {
        String sql = "SELECT MAX(price) FROM Product" + (categoryID != null ? " WHERE category_id = ?" : "");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (categoryID != null) {
                ps.setInt(1, categoryID);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Lấy sản phẩm cùng category (trừ sản phẩm hiện tại)
    public List<Product> getRelatedProductsByCategory(int categoryID, int currentProductID, int limit) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE p.category_id = ? AND p.product_id != ? "
                + "ORDER BY p.created_at DESC "
                + "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryID);
            ps.setInt(2, currentProductID);
            ps.setInt(3, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm đã xem gần đây (dựa trên danh sách product IDs)
    public List<Product> getRecentlyViewedProducts(List<Integer> productIDs, int limit) {
        List<Product> productList = new ArrayList<>();
        if (productIDs == null || productIDs.isEmpty()) {
            return productList;
        }

        StringBuilder sql = new StringBuilder("SELECT p.*, c.category_name FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE p.product_id IN (");

        for (int i = 0; i < productIDs.size(); i++) {
            if (i > 0) {
                sql.append(",");
            }
            sql.append("?");
        }
        sql.append(") ORDER BY CASE ");

        for (int i = 0; i < productIDs.size(); i++) {
            sql.append("WHEN p.product_id = ? THEN ").append(i);
            if (i < productIDs.size() - 1) {
                sql.append(" ");
            }
        }
        sql.append(" END ");
        sql.append("OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Set product IDs for IN clause
            for (Integer productID : productIDs) {
                ps.setInt(paramIndex++, productID);
            }

            // Set product IDs for ORDER BY CASE
            for (Integer productID : productIDs) {
                ps.setInt(paramIndex++, productID);
            }

            // Set limit
            ps.setInt(paramIndex, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm ngẫu nhiên (để hiển thị khi không có sản phẩm đã xem)
    public List<Product> getRandomProducts(int limit) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "ORDER BY NEWID() "
                + "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm theo category với limit
    public List<Product> getProductsByCategory(int categoryID, int limit) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM Product p "
                + "JOIN Category c ON p.category_id = c.category_id "
                + "WHERE p.category_id = ? "
                + "ORDER BY p.created_at DESC "
                + "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryID);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY created_at DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
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
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> searchByTitle(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE product_name LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm mới một sản phẩm
    public void addProduct(int category_id, String product_name, String description, java.math.BigDecimal price, int stock_quantity, String image_url) {
        String sql = "INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, category_id);
            ps.setString(2, product_name);
            ps.setString(3, description);
            ps.setBigDecimal(4, price);
            ps.setInt(5, stock_quantity);
            ps.setString(6, image_url);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Sửa thông tin một sản phẩm
    public void updateProduct(int product_id, int category_id, String product_name, String description, java.math.BigDecimal price, int stock_quantity, String image_url) {
        String sql = "UPDATE Product SET category_id = ?, product_name = ?, description = ?, price = ?, stock_quantity = ?, image_url = ?, updated_at = GETDATE() WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, category_id);
            ps.setString(2, product_name);
            ps.setString(3, description);
            ps.setBigDecimal(4, price);
            ps.setInt(5, stock_quantity);
            ps.setString(6, image_url);
            ps.setInt(7, product_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa một sản phẩm
    public void deleteProduct(int product_id) {
        String sql = "DELETE FROM Product WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, product_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        productDAO dao = new productDAO();

        // Test related products
        List<Product> relatedProducts = dao.getRelatedProductsByCategory(1, 1, 4);
        System.out.println("Related products count: " + relatedProducts.size());

        // Test recently viewed products
        List<Integer> recentlyViewed = new ArrayList<>();
        recentlyViewed.add(2);
        recentlyViewed.add(3);
        recentlyViewed.add(4);
        List<Product> recentlyViewedProducts = dao.getRecentlyViewedProducts(recentlyViewed, 4);
        System.out.println("Recently viewed products count: " + recentlyViewedProducts.size());

        // Test random products
        List<Product> randomProducts = dao.getRandomProducts(4);
        System.out.println("Random products count: " + randomProducts.size());
    }
}
