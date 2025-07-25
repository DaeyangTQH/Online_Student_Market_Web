package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO extends DBcontext {

    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE username = ? AND password_hash = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu user bị ban thì không cho đăng nhập
                if ("banned".equalsIgnoreCase(rs.getString("role"))) {
                    return null;
                }
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at"));
                user.setUpdated_at(rs.getDate("updated_at"));
                user.setStatus("banned".equalsIgnoreCase(rs.getString("role")) ? "BANNED" : "ACTIVE");
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM [User] WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at"));
                user.setUpdated_at(rs.getDate("updated_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkUserExists(String username, String email) {
        String sql = "SELECT 1 FROM [User] WHERE username = ? OR email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // có bản ghi nào trùng thì true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int insertUser(User user) {
        String sql = "INSERT INTO [User] (username, email, password_hash, full_name, phone_number, role, created_at, updated_at) "
                + "VALUES (?, ?, ?, NULL, NULL, ?, GETDATE(), GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword_hash());
            ps.setString(4, user.getRole());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            java.sql.ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy danh sách tất cả user (bao gồm cả trạng thái banned)
    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE role = 'user' OR role = 'banned'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at"));
                user.setUpdated_at(rs.getDate("updated_at"));
                user.setStatus("banned".equalsIgnoreCase(rs.getString("role")) ? "BANNED" : "ACTIVE");
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Ban user bằng cách set role = 'banned'
    public void banUser(int userId) {
        String sql = "UPDATE [User] SET role = 'banned', updated_at = GETDATE() WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Unban user bằng cách set role = 'user'
    public void unbanUser(int userId) {
        String sql = "UPDATE [User] SET role = 'user', updated_at = GETDATE() WHERE user_id = ? AND role = 'banned'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at"));
                user.setUpdated_at(rs.getDate("updated_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE [User] SET password_hash = ?, updated_at = GETDATE() WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword); // nên mã hóa nếu dùng thật
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at")); // dùng getTimestamp để phù hợp với datetime2
                user.setUpdated_at(rs.getDate("updated_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy user theo username (ưu tiên) hoặc user_id nếu là số
    public User getUserByIdOrUsername(String usernameOrId) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, usernameOrId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword_hash(rs.getString("password_hash"));
                user.setFull_name(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone_number(rs.getString("phone_number"));
                user.setRole(rs.getString("role"));
                user.setCreated_at(rs.getDate("created_at"));
                user.setUpdated_at(rs.getDate("updated_at"));
                user.setStatus("banned".equalsIgnoreCase(rs.getString("role")) ? "BANNED" : "ACTIVE");
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không tìm thấy theo username, thử tìm theo user_id nếu là số
        try {
            int id = Integer.parseInt(usernameOrId);
            return getUserById(id);
        } catch (NumberFormatException e) {
            // Không phải số, bỏ qua
        }
        return null;
    }

    public static void main(String[] args) {
        UserDAO check = new UserDAO();

        System.out.println(check.getUserById(1));
        System.out.println(check.getUserByEmail("hhcc782005@gmail.com"));
    }
}
