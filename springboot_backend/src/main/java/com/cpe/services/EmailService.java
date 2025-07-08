package com.cpe.services;

import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private Environment env;

    public void sendOtpEmail(String to, String otpCode) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(env.getProperty("spring.mail.username"));
            helper.setTo(to);
            helper.setSubject("Your OTP Code");

            String htmlContent = "<div style='font-family: Arial, sans-serif; font-size: 16px; color: #333;'>"
                    + "<div style='max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>"
                    + "<h2 style='color: #2d9cdb; text-align: center;'>OTP Verification</h2>"
                    + "<p>Dear User,</p>"
                    + "<p>Thank you for choosing <strong>ConnectPlus</strong>.</p>"
                    + "<p>Your One-Time Password (OTP) is:</p>"
                    + "<div style='text-align: center; margin: 20px 0;'>"
                    + "<span style='font-size: 30px; font-weight: bold; color: #e74c3c; letter-spacing: 3px;'>"
                    + otpCode + "</span>"
                    + "</div>"
                    + "<p>This OTP is valid for <strong>2 minutes</strong>. Please do not share this code with anyone.</p>"
                    + "<p>If you did not request this OTP, please ignore this email.</p>"
                    + "<br><p>Thank you!<br><strong>ConnectPlus Team</strong></p>"
                    + "<hr style='margin-top: 30px;'>"
                    + "<p style='font-size: 12px; color: #888;'>This is an auto-generated email. Please do not reply.</p>"
                    + "</div>"
                    + "</div>";

            helper.setText(htmlContent, true); // true means send as HTML
            mailSender.send(message);

        } catch (Exception e) {
            System.out.println("Failed to send OTP email: " + e.getMessage());
        }
    }
}
