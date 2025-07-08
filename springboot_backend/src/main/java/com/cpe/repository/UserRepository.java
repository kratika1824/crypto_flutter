package com.cpe.repository;

import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import com.cpe.model.Users;

public interface UserRepository extends MongoRepository<Users, String> {

	    Optional<Users> findByEmail(String email);
	    Optional<Users> findByPhone(String phone);

    @Query(value = "{ 'email': ?0 }", fields = "{ 'firstName': 1 }")
    String findFirstNameByUsername(String email);
}
