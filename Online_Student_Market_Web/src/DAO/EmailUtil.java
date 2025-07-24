package DAO;


import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    // Thay đổi thông tin Gmail tại đây
    private static final String FROM_EMAIL = "hhcc782005@gmail.com";
    private static final String APP_PASSWORD = "odpq ghqj ekve ztwz";

    public static void sendOtpEmail(String toEmail, String otpCode) {
        // Cấu hình SMTP Gmail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Xác thực phiên gửi mail
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            // Tạo email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "System Administrator"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Password Recovery OTP Code");
            message.setText("Hello,\n\nYour OTP code is: " + otpCode
                    + "\nThis code will expire in 3 minutes.\n\nBest regards.");

            // Gửi email
            Transport.send(message);
            System.out.println("OTP sent successfully to: " + toEmail);
        } catch (UnsupportedEncodingException | MessagingException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        EmailUtil.sendOtpEmail("fhgkuyrf@gmail.com", "999999");
    }
}
