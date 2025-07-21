/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Haichann
 */
public class categoryDAO extends DBcontext {

    public List<Category> getAll() {
        List<Category> catList = new ArrayList<>();
        String sql = "select * from Category";

        try {
            PreparedStatement getCatFromDatabase = connection.prepareStatement(sql);
            ResultSet catSet = getCatFromDatabase.executeQuery();

            while (catSet.next()) {
                Category newCat = new Category(catSet.getInt("category_id"), catSet.getString("category_name"),
                        catSet.getString("category_description"), catSet.getDate("created_at"),
                        catSet.getDate("updated_at"), catSet.getString("category_image_url"));
                catList.add(newCat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return catList;
    }
    
    public Category getCategoryById(int id) {
        String sql = "select * from Category where category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(
                    rs.getInt("category_id"),
                    rs.getString("category_name"),
                    rs.getString("category_description"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at"),
                    rs.getString("category_image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm mới một category
    public void addCategory(String category_name, String category_description, String category_image_url) {
        String sql = "INSERT INTO Category (category_name, category_description, category_image_url, created_at, updated_at) VALUES (?, ?, ?, GETDATE(), GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category_name);
            ps.setString(2, category_description);
            ps.setString(3, category_image_url);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Sửa thông tin một category
    public void updateCategory(int category_id, String category_name, String category_description, String category_image_url) {
        String sql = "UPDATE Category SET category_name = ?, category_description = ?, category_image_url = ?, updated_at = GETDATE() WHERE category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category_name);
            ps.setString(2, category_description);
            ps.setString(3, category_image_url);
            ps.setInt(4, category_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa một category
    public void deleteCategory(int category_id) {
        String sql = "DELETE FROM Category WHERE category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, category_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        categoryDAO dao = new categoryDAO();
        List<Category> list = dao.getAll();
        for (Category category : list) {
            System.out.println(category.toString());
        }
    }
}
