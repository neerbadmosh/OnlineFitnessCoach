package com.fitness.tracker.service;

import com.fitness.tracker.model.Goal;
import com.fitness.tracker.model.User;
import com.fitness.tracker.repository.GoalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class GoalService {
    
    @Autowired
    private GoalRepository goalRepository;
    
    @Autowired
    private WorkoutService workoutService;
    
    // Save a new goal
    public Goal saveGoal(Goal goal) {
        return goalRepository.save(goal);
    }
    
    // Get all goals for a user
    public List<Goal> getAllGoalsByUser(User user) {
        return goalRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    // Get active goals for a user
    public List<Goal> getActiveGoals(User user) {
        return goalRepository.findActiveGoals(user);
    }
    
    // Get completed goals
    public List<Goal> getCompletedGoals(User user) {
        return goalRepository.findByUserAndStatusOrderByDeadlineAsc(user, "completed");
    }
    
    // Get goal by ID
    public Optional<Goal> getGoalById(Long goalId) {
        return goalRepository.findById(goalId);
    }
    
    // Update goal
    public Goal updateGoal(Goal goal) {
        return goalRepository.save(goal);
    }
    
    // Delete goal
    public void deleteGoal(Long goalId) {
        goalRepository.deleteById(goalId);
    }
    
    // Mark goal as completed
    public void markGoalAsCompleted(Long goalId) {
        Optional<Goal> goalOpt = goalRepository.findById(goalId);
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            goal.setStatus("completed");
            goal.setCompletedAt(LocalDateTime.now());
            goalRepository.save(goal);
        }
    }
    
    // Cancel goal
    public void cancelGoal(Long goalId) {
        Optional<Goal> goalOpt = goalRepository.findById(goalId);
        if (goalOpt.isPresent()) {
            Goal goal = goalOpt.get();
            goal.setStatus("cancelled");
            goalRepository.save(goal);
        }
    }
    
    // Count active goals
    public long countActiveGoals(User user) {
        return goalRepository.countActiveGoals(user);
    }
    
    // Count completed goals
    public long countCompletedGoals(User user) {
        return goalRepository.countCompletedGoals(user);
    }
    
    // Update goal progress based on workout data
    public void updateGoalProgress(User user) {
        List<Goal> activeGoals = getActiveGoals(user);
        
        for (Goal goal : activeGoals) {
            double currentValue = 0.0;
            
            switch (goal.getGoalType().toLowerCase()) {
                case "frequency":
                    // Goal: Complete X workouts per week/month
                    currentValue = workoutService.getWeeklyWorkoutCount(user);
                    break;
                    
                case "duration":
                    // Goal: Exercise for X minutes per week
                    // This would need a custom query in WorkoutService
                    currentValue = goal.getCurrentValue(); // Keep existing for now
                    break;
                    
                case "distance":
                    // Goal: Run/cycle X km per week
                    // This would need a custom query in WorkoutService
                    currentValue = goal.getCurrentValue(); // Keep existing for now
                    break;
                    
                case "weight":
                    // Goal: Lose/gain X kg
                    // This uses user's current weight
                    if (user.getCurrentWeight() != null) {
                        currentValue = Math.abs(user.getCurrentWeight() - goal.getTargetValue());
                    }
                    break;
                    
                default:
                    currentValue = goal.getCurrentValue();
                    break;
            }
            
            goal.setCurrentValue(currentValue);
            
            // Auto-complete if target reached
            if (goal.isAchieved() && !"completed".equals(goal.getStatus())) {
                goal.setStatus("completed");
                goal.setCompletedAt(LocalDateTime.now());
            }
            
            goalRepository.save(goal);
        }
    }
}