package com.cpe.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;


@Document(collection = "otps")
public class Otp {
    @Id	
	private  String id;
    private String email;
    private String phoneNumber;
    private String otp;
    private LocalDateTime createdAt;
    private LocalDateTime expiresAt;
	public Otp() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Otp(String id, String email, String phoneNumber, String otp, LocalDateTime createdAt,
			LocalDateTime expiresAt) {
		super();
		this.id = id;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.otp = otp;
		this.createdAt = createdAt;
		this.expiresAt = expiresAt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getExpiresAt() {
		return expiresAt;
	}
	public void setExpiresAt(LocalDateTime expiresAt) {
		this.expiresAt = expiresAt;
	}
	@Override
	public String toString() {
		return "Otp [id=" + id + ", email=" + email + ", phoneNumber=" + phoneNumber + ", otp=" + otp + ", createdAt="
				+ createdAt + ", expiresAt=" + expiresAt + "]";
	}
    

	

}
