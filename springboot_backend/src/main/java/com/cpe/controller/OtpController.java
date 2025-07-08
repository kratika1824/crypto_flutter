package com.cpe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



import com.cpe.dto.OtpSendRequest;
import com.cpe.dto.OtpVerifyRequest;
import com.cpe.services.OtpService;

@RestController
@RequestMapping("/api/otp")
public class OtpController {
	
	@Autowired
	private OtpService otpService;

	
	@PostMapping("/send")
    public ResponseEntity<String> sendOtp(@RequestBody OtpSendRequest request) {
        otpService.generateOtp(request.getEmail());
        return ResponseEntity.ok("OTP sent successfully to email.");
    }
	
	@PostMapping("/verify")
    public ResponseEntity<String> verifyOtp(@RequestBody OtpVerifyRequest request) {
        boolean isValid = otpService.verifyOtp(request.getEmail(), request.getOtp());

        if (isValid) {
            return ResponseEntity.ok("OTP verified successfully!");
        } else {
            return ResponseEntity.badRequest().body("Invalid or expired OTP.");
        }
    }
}
