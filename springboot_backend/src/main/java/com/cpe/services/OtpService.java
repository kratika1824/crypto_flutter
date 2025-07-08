package com.cpe.services;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cpe.model.Otp;
import com.cpe.repository.OtpRepository;

@Service
public class OtpService {
	@Autowired
	private EmailService emailService;
	@Autowired
	private OtpRepository otpRepository;

	private String generateOtp() {
		return String.format("%06d", new Random().nextInt(1000000));

	}

	public void generateOtp(String email) {
		String otpCode = generateOtp();
		LocalDateTime now = LocalDateTime.now();

		otpRepository.deleteByEmail(email);
		Otp otp = new Otp();
		otp.setEmail(email);
		otp.setOtp(otpCode);
		otp.setCreatedAt(now);
		otp.setExpiresAt(now.plusMinutes(2));

		otpRepository.save(otp);
		emailService.sendOtpEmail(email, otpCode);

	}

	public boolean verifyOtp(String email, String enteredOtp) {

		Otp otp = otpRepository.findByEmail(email).orElse(null);
		if (otp == null)
			return false;

		if (!otp.getOtp().equals(enteredOtp))
			return false;

		if (otp.getExpiresAt().isBefore(LocalDateTime.now(ZoneOffset.UTC)))
			return false;

		otpRepository.delete(otp);

		return true;

	}

}
