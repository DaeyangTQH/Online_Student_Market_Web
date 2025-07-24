/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.SubCategory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Haichann
 */
public class SubCategoryDAO extends DBcontext{
    
    public List<SubCategory> getSubCategoriesByCategoryId(int categoryId) {
        List<SubCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM SubCategory WHERE category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubCategory sub = new SubCategory();
                sub.setSubCategory_id(rs.getInt("subCategory_id"));
                sub.setSubCategory_name(rs.getString("subCategory_name"));
                sub.setCreated_at(rs.getDate("created_at"));
                sub.setUpdated_at(rs.getDate("updated_at"));
                sub.setSubCategory_image_url(rs.getString("image_url"));
                sub.setCategory_id(rs.getInt("category_id"));
                list.add(sub);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public SubCategory getSubCategoryById(int subCategoryId) {
        String sql = "SELECT * FROM SubCategory WHERE subCategory_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, subCategoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                SubCategory sub = new SubCategory();
                sub.setSubCategory_id(rs.getInt("subCategory_id"));
                sub.setSubCategory_name(rs.getString("subCategory_name"));
                sub.setCreated_at(rs.getDate("created_at"));
                sub.setUpdated_at(rs.getDate("updated_at"));
                sub.setSubCategory_image_url(rs.getString("image_url"));
                sub.setCategory_id(rs.getInt("category_id"));
                return sub;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<SubCategory> getAllSubCategories() {
        List<SubCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM SubCategory";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubCategory sub = new SubCategory();
                sub.setSubCategory_id(rs.getInt("subCategory_id"));
                sub.setSubCategory_name(rs.getString("subCategory_name"));
                sub.setCreated_at(rs.getDate("created_at"));
                sub.setUpdated_at(rs.getDate("updated_at"));
                sub.setSubCategory_image_url(rs.getString("image_url"));
                sub.setCategory_id(rs.getInt("category_id"));
                list.add(sub);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        SubCategoryDAO dao = new SubCategoryDAO();
        List<SubCategory> list = dao.getSubCategoriesByCategoryId(1);
        for (SubCategory subCategory : list) {
            System.out.println(subCategory.getSubCategory_name() + " " + subCategory.getSubCategory_id() + " " + subCategory.getCategory_id());            
        }
    }
}
