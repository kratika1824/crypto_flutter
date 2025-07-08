package com.cpe.repository;

import java.util.Optional;
import org.springframework.data.mongodb.repository.MongoRepository;
import com.cpe.model.Otp;

public interface OtpRepository extends MongoRepository<Otp, String> {
	
	Optional<Otp> findByEmail(String email);
	
   // Optional<Otp> findByPhoneNumber(String phoneNumber);
	
    void deleteByEmail(String email);
    
   // void deleteByPhoneNumber(String phoneNumber);
} 
