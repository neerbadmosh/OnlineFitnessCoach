package com.fitness.tracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fitness.tracker.model.User;
import com.fitness.tracker.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	// ==================== REGISTRATION ====================

	// Show registration page
	@GetMapping("/register")
	public String showRegistrationForm(Model model) {
		model.addAttribute("user", new User());
		return "register";
	}

	// Handle registration form submission
	@PostMapping("/register")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, Model model,
			RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "register";
		}

		// If username already exists
		if (userService.isUsernameExists(user.getUsername())) {
			model.addAttribute("usernameError", "Username already exists!");
			return "register";
		}

		// If email already exists
		if (userService.isEmailExists(user.getEmail())) {
			model.addAttribute("emailError", "Email already exists!");
			return "register";
		}

		try {
			userService.registerUser(user);
			redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login.");
			return "redirect:/login";

		} catch (Exception e) {
			model.addAttribute("errorMessage", "Registration failed. Please try again.");
			return "register";
		}
	}

	// ==================== LOGIN ====================

	// Show login page
	@GetMapping("/login")
	public String showLoginForm(Model model, HttpSession session) {
		// If user is already logged in, redirect to dashboard
		if (session.getAttribute("loggedInUser") != null) {
			return "redirect:/dashboard";
		}
		return "login";
	}

	// Handle login form submission
	@PostMapping("/login")
	public String loginUser(@RequestParam("username") String username, @RequestParam("password") String password,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		User user = userService.authenticate(username, password);

		if (user != null) {
			session.setAttribute("loggedInUser", user);
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("username", user.getUsername());

			redirectAttributes.addFlashAttribute("loginSuccess", "Welcome back, " + user.getUsername() + "!");

			return "redirect:/dashboard";
		} else {
			model.addAttribute("errorMessage", "Invalid username or password. Please try again.");
			model.addAttribute("username", username);
			return "login";
		}
	}

	// ==================== LOGOUT ====================

	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
		// Invalidate session
		session.invalidate();

		// Add logout message
		redirectAttributes.addFlashAttribute("logoutMessage", "You have been successfully logged out.");

		return "redirect:/login";
	}
}