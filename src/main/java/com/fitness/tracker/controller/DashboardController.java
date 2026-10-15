package com.fitness.tracker.controller;

import com.fitness.tracker.model.User;
import com.fitness.tracker.model.Workout;
import com.fitness.tracker.model.Goal;
import com.fitness.tracker.service.WorkoutService;
import com.fitness.tracker.service.GoalService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class DashboardController {
    
    @Autowired
    private WorkoutService workoutService;
    
    @Autowired
    private GoalService goalService;
    
    // Dashboard - Main page after login
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            // User not logged in, redirect to login page
            return "redirect:/login";
        }
        
        // User is logged in, show dashboard
        model.addAttribute("user", loggedInUser);
        
        // Get real statistics
        long totalWorkouts = workoutService.getTotalWorkoutCount(loggedInUser);
        long weeklyWorkouts = workoutService.getWeeklyWorkoutCount(loggedInUser);
        int caloriesBurned = workoutService.getTotalCaloriesBurned(loggedInUser);
        long activeGoals = goalService.countActiveGoals(loggedInUser);
        
        // Get recent workouts (last 5)
        List<Workout> allWorkouts = workoutService.getAllWorkoutsByUser(loggedInUser);
        List<Workout> recentWorkouts = allWorkouts.size() > 5 
            ? allWorkouts.subList(0, 5) 
            : allWorkouts;
        
        // Get active goals (top 3)
        List<Goal> allActiveGoals = goalService.getActiveGoals(loggedInUser);
        List<Goal> topGoals = allActiveGoals.size() > 3 
            ? allActiveGoals.subList(0, 3) 
            : allActiveGoals;
        
        // Update goal progress
        goalService.updateGoalProgress(loggedInUser);
        
        model.addAttribute("totalWorkouts", totalWorkouts);
        model.addAttribute("weeklyWorkouts", weeklyWorkouts);
        model.addAttribute("activeGoals", activeGoals);
        model.addAttribute("caloriesBurned", caloriesBurned);
        model.addAttribute("recentWorkouts", recentWorkouts);
        model.addAttribute("topGoals", topGoals);
        
        return "dashboard";
    }
}