package Model;

import java.sql.Date;

public class User {

    private int user_id;
    private String username;
    private String password_hash;
    private String full_name;
    private String email;
    private String phone_number;
    private String status;
    private String role;
    private java.sql.Date created_at;
    private java.sql.Date updated_at;

    public User() {
    }

    public User(int user_id, String username, String password_hash, String full_name, String email, String phone_number, String status, String role, Date created_at, Date updated_at) {
        this.user_id = user_id;
        this.username = username;
        this.password_hash = password_hash;
        this.full_name = full_name;
        this.email = email;
        this.phone_number = phone_number;
        this.status = status;
        this.role = role;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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

    
}
