/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.Product;
import model.Cart_Item;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Order;
import java.sql.ResultSet;
import java.sql.Statement;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author DELL
 */
public class CreateDAO extends DBcontext {
    
    public void insertProduct(Product product) {
        String sql = "INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, product.getSubCategory_id());
            ps.setString(2, product.getProduct_name());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setInt(5, product.getStock_quantity());
            ps.setString(6, product.getImage_url());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE Product SET category_id=?, product_name=?, description=?, price=?, stock_quantity=?, image_url=?, updated_at=GETDATE() WHERE product_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, product.getSubCategory_id());
            ps.setString(2, product.getProduct_name());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setInt(5, product.getStock_quantity());
            ps.setString(6, product.getImage_url());
            ps.setInt(7, product.getProduct_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        try {
            // Xóa khỏi Order_Item trước
            String sqlOrderItem = "DELETE FROM Order_Item WHERE product_id = ?";
            PreparedStatement psOrderItem = connection.prepareStatement(sqlOrderItem);
            psOrderItem.setInt(1, productId);
            psOrderItem.executeUpdate();

            // Xóa khỏi Cart_Item trước
            String sqlCartItem = "DELETE FROM Cart_Item WHERE product_id = ?";
            PreparedStatement psCartItem = connection.prepareStatement(sqlCartItem);
            psCartItem.setInt(1, productId);
            psCartItem.executeUpdate();

            // Sau đó mới xóa Product
            String sqlProduct = "DELETE FROM Product WHERE product_id = ?";
            PreparedStatement psProduct = connection.prepareStatement(sqlProduct);
            psProduct.setInt(1, productId);
            psProduct.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createOrderForBuyNow(int userId, Product product, int quantity) {
        try {
            // 1. Tính tổng tiền
            BigDecimal total = product.getPrice().multiply(new BigDecimal(quantity));
            // 2. Tạo đơn hàng mới
            String insertOrder = "INSERT INTO [Order] (user_id, total_amount, payment_method, order_date, status, shipping_address, created_at) VALUES (?, ?, N'COD', GETDATE(), N'PROCESSING', N'Chưa cập nhật', GETDATE())";
            PreparedStatement psOrder = connection.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setBigDecimal(2, total);
            psOrder.executeUpdate();
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);
            // 3. Thêm sản phẩm vào Order_Item
            String insertItem = "INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            PreparedStatement psItem = connection.prepareStatement(insertItem);
            psItem.setInt(1, orderId);
            psItem.setInt(2, product.getProduct_id());
            psItem.setInt(3, quantity);
            psItem.setBigDecimal(4, product.getPrice());
            psItem.executeUpdate();
            // 4. Trừ kho
            String updateStock = "UPDATE Product SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
            PreparedStatement psStock = connection.prepareStatement(updateStock);
            psStock.setInt(1, quantity);
            psStock.setInt(2, product.getProduct_id());
            psStock.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createOrderForBuyNow(int userId, Product product, int quantity, String paymentMethod, String shippingAddress) {
        try {
            // 1. Tính tổng tiền
            BigDecimal total = product.getPrice().multiply(new BigDecimal(quantity));
            // 2. Tạo đơn hàng mới
            String insertOrder = "INSERT INTO [Order] (user_id, total_amount, payment_method, order_date, status, shipping_address, created_at) VALUES (?, ?, ?, GETDATE(), N'PROCESSING', ?, GETDATE())";
            PreparedStatement psOrder = connection.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setBigDecimal(2, total);
            psOrder.setString(3, paymentMethod);
            psOrder.setString(4, shippingAddress);
            psOrder.executeUpdate();
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);
            // 3. Thêm sản phẩm vào Order_Item
            String insertItem = "INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            PreparedStatement psItem = connection.prepareStatement(insertItem);
            psItem.setInt(1, orderId);
            psItem.setInt(2, product.getProduct_id());
            psItem.setInt(3, quantity);
            psItem.setBigDecimal(4, product.getPrice());
            psItem.executeUpdate();
            // 4. Trừ kho
            String updateStock = "UPDATE Product SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
            PreparedStatement psStock = connection.prepareStatement(updateStock);
            psStock.setInt(1, quantity);
            psStock.setInt(2, product.getProduct_id());
            psStock.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createOrderFromCart(int userId, List<Cart_Item> cartItems, String paymentMethod, String shippingAddress, int cartId) {
        try {
            // 1. Tính tổng tiền
            BigDecimal total = BigDecimal.ZERO;
            for (Cart_Item item : cartItems) {
                BigDecimal itemTotal = item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()));
                total = total.add(itemTotal);
            }
            
            // 2. Tạo đơn hàng mới
            String insertOrder = "INSERT INTO [Order] (user_id, total_amount, payment_method, order_date, status, shipping_address, created_at) VALUES (?, ?, ?, GETDATE(), N'PROCESSING', ?, GETDATE())";
            PreparedStatement psOrder = connection.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setBigDecimal(2, total);
            psOrder.setString(3, paymentMethod);
            psOrder.setString(4, shippingAddress);
            psOrder.executeUpdate();
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);
            
            // 3. Thêm các sản phẩm vào Order_Item và trừ kho
            String insertItem = "INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            String updateStock = "UPDATE Product SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
            PreparedStatement psItem = connection.prepareStatement(insertItem);
            PreparedStatement psStock = connection.prepareStatement(updateStock);
            
            for (Cart_Item item : cartItems) {
                // Thêm vào Order_Item
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProduct().getProduct_id());
                psItem.setInt(3, item.getQuantity());
                psItem.setBigDecimal(4, item.getProduct().getPrice());
                psItem.executeUpdate();
                
                // Trừ kho
                psStock.setInt(1, item.getQuantity());
                psStock.setInt(2, item.getProduct().getProduct_id());
                psStock.executeUpdate();
            }
            
            // 4. Xóa cart items sau khi tạo đơn hàng thành công
            String deleteCartItems = "DELETE FROM Cart_Item WHERE cart_id = ?";
            PreparedStatement psDelete = connection.prepareStatement(deleteCartItems);
            psDelete.setInt(1, cartId);
            psDelete.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
