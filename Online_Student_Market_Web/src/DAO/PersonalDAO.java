package DAO;

import model.UserOrderItem;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PersonalDAO extends DBcontext {

    public List<UserOrderItem> getOrderItemsByUserId(int userId) {
        List<UserOrderItem> list = new ArrayList<>();

        String sql = "SELECT \n"
                + "    o.order_date,\n"
                + "    p.product_name,\n"
                + "    p.image_url AS product_image,\n"
                + "    oi.quantity,\n"
                + "    oi.unit_price,\n"
                + "    (oi.quantity * oi.unit_price) AS total_price\n"
                + "FROM [Order] o\n"
                + "JOIN [Order_Item] oi ON o.order_id = oi.order_id\n"
                + "JOIN Product p ON oi.product_id = p.product_id\n"
                + "WHERE o.user_id = ?\n"
                + "ORDER BY o.order_date DESC";

        try {

            PreparedStatement prepare = connection.prepareStatement(sql);

            prepare.setInt(1, userId);

            try (ResultSet result = prepare.executeQuery()) {
                while (result.next()) {
                    UserOrderItem item = new UserOrderItem();
                    item.setOrderDate(result.getDate("order_date"));
                    item.setProductName(result.getString("product_name"));
                    item.setProductImage(result.getString("product_image"));
                    item.setQuantity(result.getInt("quantity"));
                    item.setUnitPrice(result.getDouble("unit_price"));
                    item.setTotalPrice(result.getDouble("total_price"));
                    list.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        PersonalDAO person = new PersonalDAO();
        int userId = 1; // Test với user_id = 1

        List<UserOrderItem> items = person.getOrderItemsByUserId(userId);

        if (items.isEmpty()) {
            System.out.println("Không có đơn hàng nào.");
        } else {
            for (UserOrderItem item : items) {
                System.out.println("Ngày mua: " + item.getOrderDate());
                System.out.println("Tên sản phẩm: " + item.getProductName());
                System.out.println("Ảnh sản phẩm: " + item.getProductImage());
                System.out.println("Số lượng: " + item.getQuantity());
                System.out.println("Đơn giá: " + item.getUnitPrice());
                System.out.println("Thành tiền: " + item.getTotalPrice());
                System.out.println("--------------------------");
            }
        }
    }
}
