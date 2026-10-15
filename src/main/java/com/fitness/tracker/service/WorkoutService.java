package com.fitness.tracker.service;

import com.fitness.tracker.model.Workout;
import com.fitness.tracker.model.User;
import com.fitness.tracker.repository.WorkoutRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class WorkoutService {
    
    @Autowired
    private WorkoutRepository workoutRepository;
    
    // Save a new workout
    public Workout saveWorkout(Workout workout) {
        return workoutRepository.save(workout);
    }
    
    // Get all workouts for a user
    public List<Workout> getAllWorkoutsByUser(User user) {
        return workoutRepository.findByUserOrderByWorkoutDateDesc(user);
    }
    
    // Get workout by ID
    public Optional<Workout> getWorkoutById(Long workoutId) {
        return workoutRepository.findById(workoutId);
    }
    
    // Get workouts by category
    public List<Workout> getWorkoutsByCategory(User user, String category) {
        return workoutRepository.findByUserAndCategoryOrderByWorkoutDateDesc(user, category);
    }
    
    // Get workouts within date range
    public List<Workout> getWorkoutsByDateRange(User user, LocalDate startDate, LocalDate endDate) {
        return workoutRepository.findByUserAndWorkoutDateBetweenOrderByWorkoutDateDesc(
                user, startDate, endDate);
    }
    
    // Update workout
    public Workout updateWorkout(Workout workout) {
        return workoutRepository.save(workout);
    }
    
    // Delete workout
    public void deleteWorkout(Long workoutId) {
        workoutRepository.deleteById(workoutId);
    }
    
    // Get total workout count for user
    public long getTotalWorkoutCount(User user) {
        return workoutRepository.countByUser(user);
    }
    
    // Get total calories burned by user
    public Integer getTotalCaloriesBurned(User user) {
        Integer total = workoutRepository.getTotalCaloriesBurnedByUser(user);
        return total != null ? total : 0;
    }
    
    // Get workouts for current week
    public List<Workout> getCurrentWeekWorkouts(User user) {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
        return workoutRepository.findCurrentWeekWorkouts(user, startOfWeek);
    }
    
    // Get count of workouts for current week
    public long getWeeklyWorkoutCount(User user) {
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
        return workoutRepository.countWeeklyWorkouts(user, startOfWeek);
    }
}