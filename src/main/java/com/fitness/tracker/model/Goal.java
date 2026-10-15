package com.fitness.tracker.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "goals")
public class Goal {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "goal_id")
    private Long goalId;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Column(name = "goal_type", nullable = false, length = 50)
    @NotBlank(message = "Goal type is required")
    private String goalType; // weight, frequency, duration, distance, strength
    
    @Column(name = "goal_description", nullable = false, length = 200)
    @NotBlank(message = "Goal description is required")
    private String goalDescription;
    
    @Column(name = "target_value", nullable = false)
    @NotNull(message = "Target value is required")
    private Double targetValue;
    
    @Column(name = "current_value")
    private Double currentValue;
    
    @Column(name = "start_date", nullable = false)
    @NotNull(message = "Start date is required")
    private LocalDate startDate;
    
    @Column(name = "deadline", nullable = false)
    @NotNull(message = "Deadline is required")
    private LocalDate deadline;
    
    @Column(name = "status", length = 20)
    private String status; // active, completed, cancelled
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "completed_at")
    private LocalDateTime completedAt;
    
    // Constructors
    public Goal() {
        this.status = "active";
        this.currentValue = 0.0;
    }
    
    public Goal(User user, String goalType, String goalDescription, Double targetValue, LocalDate deadline) {
        this.user = user;
        this.goalType = goalType;
        this.goalDescription = goalDescription;
        this.targetValue = targetValue;
        this.deadline = deadline;
        this.startDate = LocalDate.now();
        this.status = "active";
        this.currentValue = 0.0;
    }
    
    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (startDate == null) {
            startDate = LocalDate.now();
        }
        if (status == null) {
            status = "active";
        }
        if (currentValue == null) {
            currentValue = 0.0;
        }
    }
    
    // Business method to calculate progress percentage
    public int getProgressPercentage() {
        if (targetValue == null || targetValue == 0) {
            return 0;
        }
        double progress = (currentValue / targetValue) * 100;
        return Math.min((int) progress, 100); // Cap at 100%
    }
    
    // Business method to check if goal is achieved
    public boolean isAchieved() {
        return currentValue != null && currentValue >= targetValue;
    }
    
    // Business method to get days remaining
    public long getDaysRemaining() {
        if (deadline == null) {
            return 0;
        }
        LocalDate today = LocalDate.now();
        return java.time.temporal.ChronoUnit.DAYS.between(today, deadline);
    }
    
    // Getters and Setters
    public Long getGoalId() {
        return goalId;
    }
    
    public void setGoalId(Long goalId) {
        this.goalId = goalId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public String getGoalType() {
        return goalType;
    }
    
    public void setGoalType(String goalType) {
        this.goalType = goalType;
    }
    
    public String getGoalDescription() {
        return goalDescription;
    }
    
    public void setGoalDescription(String goalDescription) {
        this.goalDescription = goalDescription;
    }
    
    public Double getTargetValue() {
        return targetValue;
    }
    
    public void setTargetValue(Double targetValue) {
        this.targetValue = targetValue;
    }
    
    public Double getCurrentValue() {
        return currentValue;
    }
    
    public void setCurrentValue(Double currentValue) {
        this.currentValue = currentValue;
    }
    
    public LocalDate getStartDate() {
        return startDate;
    }
    
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    
    public LocalDate getDeadline() {
        return deadline;
    }
    
    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getCompletedAt() {
        return completedAt;
    }
    
    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }
    
    @Override
    public String toString() {
        return "Goal{" +
                "goalId=" + goalId +
                ", goalType='" + goalType + '\'' +
                ", goalDescription='" + goalDescription + '\'' +
                ", targetValue=" + targetValue +
                ", currentValue=" + currentValue +
                ", status='" + status + '\'' +
                '}';
    }
}