/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.util.ArrayList;
import java.util.List;
import model.Category;
import java.sql.*;

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
    
    public static void main(String[] args) {
        categoryDAO dao = new categoryDAO();
        List<Category> list = dao.getAll();
        for (Category category : list) {
            System.out.println(category.toString());
        }
    }
}
