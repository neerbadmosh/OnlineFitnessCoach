package com.fitness.tracker.controller;

import com.fitness.tracker.model.Goal;
import com.fitness.tracker.model.User;
import com.fitness.tracker.service.GoalService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/goal")
public class GoalController {
    
    @Autowired
    private GoalService goalService;
    
    // Show create goal form
    @GetMapping("/create")
    public String showCreateGoalForm(HttpSession session, Model model) {
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("goal", new Goal());
        return "create-goal";
    }
    
    // Handle goal creation
    @PostMapping("/create")
    public String createGoal(@Valid @ModelAttribute("goal") Goal goal,
                            BindingResult result,
                            HttpSession session,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Check for validation errors
        if (result.hasErrors()) {
            return "create-goal";
        }
        
        // Validate deadline is in the future
        if (goal.getDeadline().isBefore(java.time.LocalDate.now())) {
            model.addAttribute("errorMessage", "Deadline must be in the future!");
            return "create-goal";
        }
        
        try {
            // Set the user
            goal.setUser(loggedInUser);
            
            // Save goal
            goalService.saveGoal(goal);
            
            // Add success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Goal created successfully!");
            
            return "redirect:/goal/list";
            
        } catch (Exception e) {
            model.addAttribute("errorMessage",
                    "Failed to create goal. Please try again.");
            return "create-goal";
        }
    }
    
    // Show all goals
    @GetMapping("/list")
    public String showGoals(HttpSession session, Model model,
                           @RequestParam(value = "filter", required = false) String filter) {
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        List<Goal> goals;
        
        // Filter goals based on status
        if ("active".equals(filter)) {
            goals = goalService.getActiveGoals(loggedInUser);
        } else if ("completed".equals(filter)) {
            goals = goalService.getCompletedGoals(loggedInUser);
        } else {
            goals = goalService.getAllGoalsByUser(loggedInUser);
        }
        
        // Update goal progress
        goalService.updateGoalProgress(loggedInUser);
        
        model.addAttribute("goals", goals);
        model.addAttribute("activeCount", goalService.countActiveGoals(loggedInUser));
        model.addAttribute("completedCount", goalService.countCompletedGoals(loggedInUser));
        model.addAttribute("currentFilter", filter);
        
        return "goal-list";
    }
    
    // View single goal details
    @GetMapping("/view/{id}")
    public String viewGoal(@PathVariable("id") Long goalId,
                          HttpSession session,
                          Model model,
                          RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        Optional<Goal> goalOpt = goalService.getGoalById(goalId);
        
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            
            // Check if goal belongs to logged-in user
            if (!goal.getUser().getUserId().equals(loggedInUser.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You don't have permission to view this goal.");
                return "redirect:/goal/list";
            }
            
            model.addAttribute("goal", goal);
            return "goal-detail";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Goal not found.");
            return "redirect:/goal/list";
        }
    }
    
    // Show edit goal form
    @GetMapping("/edit/{id}")
    public String showEditGoalForm(@PathVariable("id") Long goalId,
                                  HttpSession session,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        Optional<Goal> goalOpt = goalService.getGoalById(goalId);
        
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            
            // Check if goal belongs to logged-in user
            if (!goal.getUser().getUserId().equals(loggedInUser.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You don't have permission to edit this goal.");
                return "redirect:/goal/list";
            }
            
            model.addAttribute("goal", goal);
            return "edit-goal";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Goal not found.");
            return "redirect:/goal/list";
        }
    }
    
    // Handle goal update
    @PostMapping("/update/{id}")
    public String updateGoal(@PathVariable("id") Long goalId,
                            @Valid @ModelAttribute("goal") Goal goal,
                            BindingResult result,
                            HttpSession session,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        // Check for validation errors
        if (result.hasErrors()) {
            goal.setGoalId(goalId);
            return "edit-goal";
        }
        
        try {
            // Set the ID and user
            goal.setGoalId(goalId);
            goal.setUser(loggedInUser);
            
            // Update goal
            goalService.updateGoal(goal);
            
            // Add success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Goal updated successfully!");
            
            return "redirect:/goal/view/" + goalId;
            
        } catch (Exception e) {
            model.addAttribute("errorMessage",
                    "Failed to update goal. Please try again.");
            goal.setGoalId(goalId);
            return "edit-goal";
        }
    }
    
    // Mark goal as completed
    @GetMapping("/complete/{id}")
    public String completeGoal(@PathVariable("id") Long goalId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        Optional<Goal> goalOpt = goalService.getGoalById(goalId);
        
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            
            // Check if goal belongs to logged-in user
            if (!goal.getUser().getUserId().equals(loggedInUser.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You don't have permission to modify this goal.");
                return "redirect:/goal/list";
            }
            
            // Mark as completed
            goalService.markGoalAsCompleted(goalId);
            
            redirectAttributes.addFlashAttribute("successMessage",
                    "Congratulations! Goal marked as completed! 🎉");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Goal not found.");
        }
        
        return "redirect:/goal/list";
    }
    
    // Delete goal
    @GetMapping("/delete/{id}")
    public String deleteGoal(@PathVariable("id") Long goalId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        
        Optional<Goal> goalOpt = goalService.getGoalById(goalId);
        
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            
            // Check if goal belongs to logged-in user
            if (!goal.getUser().getUserId().equals(loggedInUser.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You don't have permission to delete this goal.");
                return "redirect:/goal/list";
            }
            
            // Delete goal
            goalService.deleteGoal(goalId);
            
            redirectAttributes.addFlashAttribute("successMessage",
                    "Goal deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Goal not found.");
        }
        
        return "redirect:/goal/list";
    }
}