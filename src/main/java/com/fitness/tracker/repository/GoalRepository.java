package com.fitness.tracker.repository;

import com.fitness.tracker.model.Goal;
import com.fitness.tracker.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoalRepository extends JpaRepository<Goal, Long> {
    
    // Find all goals by user
    List<Goal> findByUserOrderByCreatedAtDesc(User user);
    
    // Find active goals by user
    List<Goal> findByUserAndStatusOrderByDeadlineAsc(User user, String status);
    
    // Find goals by user and type
    List<Goal> findByUserAndGoalTypeOrderByCreatedAtDesc(User user, String goalType);
    
    // Count active goals for user
    @Query("SELECT COUNT(g) FROM Goal g WHERE g.user = :user AND g.status = 'active'")
    long countActiveGoals(@Param("user") User user);
    
    // Count completed goals for user
    @Query("SELECT COUNT(g) FROM Goal g WHERE g.user = :user AND g.status = 'completed'")
    long countCompletedGoals(@Param("user") User user);
    
    // Get all active goals
    @Query("SELECT g FROM Goal g WHERE g.user = :user AND g.status = 'active' ORDER BY g.deadline ASC")
    List<Goal> findActiveGoals(@Param("user") User user);
}