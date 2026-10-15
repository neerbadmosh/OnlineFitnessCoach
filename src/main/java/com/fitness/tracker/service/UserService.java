package com.fitness.tracker.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fitness.tracker.model.User;
import com.fitness.tracker.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepository;

	public User registerUser(User user) {
		return userRepository.save(user);
	}

	public boolean isUsernameExists(String username) {
		return userRepository.existsByUsername(username);
	}

	public boolean isEmailExists(String email) {
		return userRepository.existsByEmail(email);
	}

	public Optional<User> findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	public Optional<User> findByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	public Optional<User> findById(Long userId) {
		return userRepository.findById(userId);
	}

	public User updateUser(User user) {
		return userRepository.save(user);
	}

	public User authenticate(String username, String password) {
		Optional<User> userOpt = userRepository.findByUsername(username);

		if (userOpt.isPresent()) {
			User user = userOpt.get();
			if (user.getPassword().equals(password)) {
				return user;
			}
		}
		return null;
	}
}