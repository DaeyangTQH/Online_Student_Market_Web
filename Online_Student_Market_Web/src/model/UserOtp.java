/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class UserOtp {

    private int id;
    private int userId;
    private String otpCode;
    private Date createdAt;
    private Date expiresAt;
    private boolean isUsed;

    public UserOtp() {
    }

    public UserOtp(int id, int userId, String otpCode, Date createdAt, Date expiresAt, boolean isUsed) {
        this.id = id;
        this.userId = userId;
        this.otpCode = otpCode;
        this.createdAt = createdAt;
        this.expiresAt = expiresAt;
        this.isUsed = isUsed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOtpCode() {
        return otpCode;
    }

    public void setOtpCode(String otpCode) {
        this.otpCode = otpCode;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt) {
        this.expiresAt = expiresAt;
    }

    public boolean isIsUsed() {
        return isUsed;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    @Override
    public String toString() {
        return "UserOtp{" + "id=" + id + ", userId=" + userId + ", otpCode=" + otpCode + ", createdAt=" + createdAt + ", expiresAt=" + expiresAt + ", isUsed=" + isUsed + '}';
    }
    
    

}
