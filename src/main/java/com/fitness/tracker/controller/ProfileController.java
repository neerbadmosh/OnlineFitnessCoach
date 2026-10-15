package com.fitness.tracker.controller;

import com.fitness.tracker.model.User;
import com.fitness.tracker.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    
    @Autowired
    private UserService userService;
    
    // Show user profile
    @GetMapping
    public String showProfile(HttpSession session, Model model) {
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Get fresh user data from database
        User user = userService.findById(loggedInUser.getUserId()).orElse(loggedInUser);
        
        model.addAttribute("user", user);
        return "profile";
    }
    
    // Show edit profile form
    @GetMapping("/edit")
    public String showEditProfile(HttpSession session, Model model) {
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Get fresh user data from database
        User user = userService.findById(loggedInUser.getUserId()).orElse(loggedInUser);
        
        model.addAttribute("user", user);
        return "edit-profile";
    }
    
    // Handle profile update
    @PostMapping("/update")
    public String updateProfile(@Valid @ModelAttribute("user") User user,
                               BindingResult result,
                               HttpSession session,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Get existing user from database
        User existingUser = userService.findById(loggedInUser.getUserId()).orElse(null);
        
        if (existingUser == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "User not found.");
            return "redirect:/profile";
        }
        
        // Check for validation errors (excluding username, email, password)
        if (result.hasFieldErrors("fullName") || result.hasFieldErrors("age")) {
            return "edit-profile";
        }
        
        try {
            // Update only editable fields
            existingUser.setFullName(user.getFullName());
            existingUser.setAge(user.getAge());
            existingUser.setGender(user.getGender());
            existingUser.setHeight(user.getHeight());
            existingUser.setCurrentWeight(user.getCurrentWeight());
            existingUser.setFitnessLevel(user.getFitnessLevel());
            
            // Save updated user
            User updatedUser = userService.updateUser(existingUser);
            
            // Update session
            session.setAttribute("loggedInUser", updatedUser);
            
            // Add success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Profile updated successfully!");
            
            return "redirect:/profile";
            
        } catch (Exception e) {
            model.addAttribute("errorMessage",
                    "Failed to update profile. Please try again.");
            return "edit-profile";
        }
    }
}