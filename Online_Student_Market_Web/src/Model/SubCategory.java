/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Haichann
 */
public class SubCategory {
    private int subCategory_id;
    private String subCategory_name;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;
    private String subCategory_image_url;
    private int category_id;

    public SubCategory() {
    }

    public SubCategory(int subCategory_id, String subCategory_name, Date created_at, Date updated_at, String subCategory_image_url, int category_id) {
        this.subCategory_id = subCategory_id;
        this.subCategory_name = subCategory_name;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.subCategory_image_url = subCategory_image_url;
        this.category_id = category_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    

    public int getSubCategory_id() {
        return subCategory_id;
    }

    public void setSubCategory_id(int subCategory_id) {
        this.subCategory_id = subCategory_id;
    }

    public String getSubCategory_name() {
        return subCategory_name;
    }

    public void setSubCategory_name(String subCategory_name) {
        this.subCategory_name = subCategory_name;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public String getSubCategory_image_url() {
        return subCategory_image_url;
    }

    public void setSubCategory_image_url(String subCategory_image_url) {
        this.subCategory_image_url = subCategory_image_url;
    }
    
    
}
