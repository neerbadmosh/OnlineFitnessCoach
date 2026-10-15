<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workout Details - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/workout.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-brand">
                <h2>💪 Fitness Tracker</h2>
            </div>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/workout/log">Log Workout</a></li>
                <li><a href="${pageContext.request.contextPath}/workout/history" class="active">My Workouts</a></li>
                <li><a href="${pageContext.request.contextPath}/goal/list">Goals</a></li>
                <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="dashboard-container">
        <div class="page-header">
            <h1>🔍 Workout Details</h1>
            <a href="${pageContext.request.contextPath}/workout/history" class="back-link">
                ← Back to History
            </a>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>

        <!-- Workout Detail Card -->
        <div class="workout-detail-card">
            <div class="detail-header">
                <div>
                    <span class="category-badge ${workout.category.toLowerCase()}">${workout.category}</span>
                    <h2>${workout.exerciseName}</h2>
                </div>
                <div class="detail-date">
                    📅 ${workout.workoutDate}
                    <c:if test="${workout.workoutTime != null}">
                        <br/>
                        ⏰ ${workout.workoutTime}
                    </c:if>
                </div>
            </div>

            <div class="detail-grid">
                <!-- Always show duration -->
                <div class="detail-box">
                    <span class="detail-icon-large">⏱️</span>
                    <h3>Duration</h3>
                    <p>${workout.durationMinutes} minutes</p>
                </div>

                <!-- Show calories if present -->
                <c:if test="${workout.caloriesBurned != null && workout.caloriesBurned > 0}">
                    <div class="detail-box">
                        <span class="detail-icon-large">🔥</span>
                        <h3>Calories</h3>
                        <p>${workout.caloriesBurned} cal</p>
                    </div>
                </c:if>

                <!-- Show distance for cardio workouts -->
                <c:if test="${workout.distance != null && workout.distance > 0}">
                    <div class="detail-box">
                        <span class="detail-icon-large">📏</span>
                        <h3>Distance</h3>
                        <p>${workout.distance} km</p>
                    </div>
                </c:if>

                <!-- Show sets and reps for strength training -->
                <c:if test="${workout.sets != null && workout.sets > 0}">
                    <div class="detail-box">
                        <span class="detail-icon-large">📊</span>
                        <h3>Sets × Reps</h3>
                        <p>${workout.sets} × ${workout.reps}</p>
                    </div>
                </c:if>

                <!-- Show weight lifted for strength training -->
                <c:if test="${workout.weightLifted != null && workout.weightLifted > 0}">
                    <div class="detail-box">
                        <span class="detail-icon-large">⚖️</span>
                        <h3>Weight Lifted</h3>
                        <p>${workout.weightLifted} kg</p>
                    </div>
                </c:if>
            </div>

            <!-- Show notes if present -->
            <c:if test="${not empty workout.notes}">
                <div class="detail-notes">
                    <h3>📝 Notes</h3>
                    <p>${workout.notes}</p>
                </div>
            </c:if>

            <!-- Action Buttons -->
            <div class="detail-actions">
                <a href="${pageContext.request.contextPath}/workout/edit/${workout.workoutId}" 
                   class="btn btn-primary">
                    ✏️ Edit Workout
                </a>
                <a href="${pageContext.request.contextPath}/workout/delete/${workout.workoutId}" 
                   class="btn btn-danger"
                   onclick="return confirm('⚠️ Are you sure you want to delete this workout? This action cannot be undone.');">
                    🗑️ Delete Workout
                </a>
                <a href="${pageContext.request.contextPath}/workout/history" 
                   class="btn btn-secondary">
                    ← Back to History
                </a>
            </div>
        </div>
    </div>
</body>
</html>