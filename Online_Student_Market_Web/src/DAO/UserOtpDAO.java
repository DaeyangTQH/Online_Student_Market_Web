/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.UserOtp;
import java.util.Date;
import java.sql.*;
import java.util.Random;

/**
 *
 * @author Admin
 */
public class UserOtpDAO extends DBcontext {

    public String createOtpByUser(int userId) {
        String sql = "INSERT INTO user_otp (user_id, otp_code, created_at, expires_at, is_used) "
                + "VALUES (?, ?, GETDATE(), DATEADD(MINUTE, 5, GETDATE()), 0)";

        int otpCode = 100000 + new Random().nextInt(900000);
        String otp = String.valueOf(otpCode);

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, otp);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                return otp;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean verifyOtp(int userId, String otpCode) {
        String sql = "SELECT * FROM user_otp WHERE user_id = ? AND otp_code = ? AND is_used = 0 AND expires_at > GETDATE()";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, otpCode);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // OTP hợp lệ, đánh dấu đã sử dụng
                String updateSql = "UPDATE user_otp SET is_used = 1 WHERE id = ?";
                PreparedStatement updatePs = connection.prepareStatement(updateSql);
                updatePs.setInt(1, rs.getInt("id"));
                updatePs.executeUpdate();

                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static void main(String[] args) {
        UserOtpDAO dao = new UserOtpDAO();
        System.out.println(dao.createOtpByUser(1));
        System.out.println(dao.verifyOtp(1, "111111"));
    }
}
