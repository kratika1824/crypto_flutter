package com.cpe.services;

import com.cpe.model.Users;
import com.cpe.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Optional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String usernameOrPhone) throws UsernameNotFoundException {
        Optional<Users> userOptional = userRepository.findByEmail(usernameOrPhone);

        if (userOptional.isEmpty()) {
            userOptional = userRepository.findByPhone(usernameOrPhone); // ✅ phone fallback
        }

        Users user = userOptional.orElseThrow(() ->
                new UsernameNotFoundException("User not found with email or phone: " + usernameOrPhone));

        return new User(user.getEmail(), user.getPassword(), Collections.emptyList());
    }
}
