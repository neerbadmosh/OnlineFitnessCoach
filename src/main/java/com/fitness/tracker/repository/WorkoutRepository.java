package com.fitness.tracker.repository;

import com.fitness.tracker.model.Workout;
import com.fitness.tracker.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface WorkoutRepository extends JpaRepository<Workout, Long> {
    
    // Find all workouts by user, ordered by date descending
    List<Workout> findByUserOrderByWorkoutDateDesc(User user);
    
    // Find workouts by user and category
    List<Workout> findByUserAndCategoryOrderByWorkoutDateDesc(User user, String category);
    
    // Find workouts by user within date range
    List<Workout> findByUserAndWorkoutDateBetweenOrderByWorkoutDateDesc(
            User user, LocalDate startDate, LocalDate endDate);
    
    // Count total workouts for a user
    long countByUser(User user);
    
    // Get total calories burned by user
    @Query("SELECT COALESCE(SUM(w.caloriesBurned), 0) FROM Workout w WHERE w.user = :user")
    Integer getTotalCaloriesBurnedByUser(@Param("user") User user);
    
    // Get workouts for current week
    @Query("SELECT w FROM Workout w WHERE w.user = :user AND w.workoutDate >= :startOfWeek ORDER BY w.workoutDate DESC")
    List<Workout> findCurrentWeekWorkouts(@Param("user") User user, @Param("startOfWeek") LocalDate startOfWeek);
    
    // Count workouts for current week
    @Query("SELECT COUNT(w) FROM Workout w WHERE w.user = :user AND w.workoutDate >= :startOfWeek")
    long countWeeklyWorkouts(@Param("user") User user, @Param("startOfWeek") LocalDate startOfWeek);
}