package com.fitness.tracker.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "workouts")
public class Workout {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "workout_id")
    private Long workoutId;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Column(name = "workout_date", nullable = false)
    @NotNull(message = "Workout date is required")
    private LocalDate workoutDate;
    
    @Column(name = "workout_time")
    private LocalTime workoutTime;
    
    @Column(name = "category", nullable = false, length = 50)
    @NotBlank(message = "Category is required")
    private String category; // Cardio, Strength, Flexibility, Sports, Other
    
    @Column(name = "exercise_name", nullable = false, length = 100)
    @NotBlank(message = "Exercise name is required")
    private String exerciseName;
    
    @Column(name = "duration_minutes")
    @Min(value = 1, message = "Duration must be at least 1 minute")
    private Integer durationMinutes;
    
    @Column(name = "calories_burned")
    @Min(value = 0, message = "Calories cannot be negative")
    private Integer caloriesBurned;
    
    @Column(name = "distance")
    private Double distance; // For cardio exercises (in km)
    
    @Column(name = "sets")
    private Integer sets; // For strength training
    
    @Column(name = "reps")
    private Integer reps; // For strength training
    
    @Column(name = "weight_lifted")
    private Double weightLifted; // For strength training (in kg)
    
    @Column(name = "notes", length = 500)
    private String notes;
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    // Constructors
    public Workout() {
    }
    
    public Workout(User user, LocalDate workoutDate, String category, String exerciseName) {
        this.user = user;
        this.workoutDate = workoutDate;
        this.category = category;
        this.exerciseName = exerciseName;
    }
    
    // Lifecycle callback
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getWorkoutId() {
        return workoutId;
    }
    
    public void setWorkoutId(Long workoutId) {
        this.workoutId = workoutId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public LocalDate getWorkoutDate() {
        return workoutDate;
    }
    
    public void setWorkoutDate(LocalDate workoutDate) {
        this.workoutDate = workoutDate;
    }
    
    public LocalTime getWorkoutTime() {
        return workoutTime;
    }
    
    public void setWorkoutTime(LocalTime workoutTime) {
        this.workoutTime = workoutTime;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getExerciseName() {
        return exerciseName;
    }
    
    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }
    
    public Integer getDurationMinutes() {
        return durationMinutes;
    }
    
    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }
    
    public Integer getCaloriesBurned() {
        return caloriesBurned;
    }
    
    public void setCaloriesBurned(Integer caloriesBurned) {
        this.caloriesBurned = caloriesBurned;
    }
    
    public Double getDistance() {
        return distance;
    }
    
    public void setDistance(Double distance) {
        this.distance = distance;
    }
    
    public Integer getSets() {
        return sets;
    }
    
    public void setSets(Integer sets) {
        this.sets = sets;
    }
    
    public Integer getReps() {
        return reps;
    }
    
    public void setReps(Integer reps) {
        this.reps = reps;
    }
    
    public Double getWeightLifted() {
        return weightLifted;
    }
    
    public void setWeightLifted(Double weightLifted) {
        this.weightLifted = weightLifted;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Workout{" +
                "workoutId=" + workoutId +
                ", workoutDate=" + workoutDate +
                ", category='" + category + '\'' +
                ", exerciseName='" + exerciseName + '\'' +
                ", durationMinutes=" + durationMinutes +
                ", caloriesBurned=" + caloriesBurned +
                '}';
    }
}