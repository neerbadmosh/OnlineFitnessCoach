<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workout History - Fitness Tracker</title>
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
            <h1>📋 My Workout History</h1>
            <p>View and manage all your workouts</p>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Summary Stats -->
        <div class="workout-summary">
            <div class="summary-card">
                <span class="summary-icon">📝</span>
                <div>
                    <h3>${totalWorkouts}</h3>
                    <p>Total Workouts</p>
                </div>
            </div>
        </div>

        <!-- Action Button -->
        <div class="history-actions">
            <a href="${pageContext.request.contextPath}/workout/log" class="btn btn-primary">
                <span class="btn-icon">➕</span> Log New Workout
            </a>
        </div>

        <!-- Workouts List -->
        <div class="workouts-container">
            <c:choose>
                <c:when test="${empty workouts}">
                    <div class="empty-state">
                        <p class="empty-icon">📭</p>
                        <h3>No Workouts Yet</h3>
                        <p>Start logging your workouts to track your progress!</p>
                        <a href="${pageContext.request.contextPath}/workout/log" class="btn btn-primary">
                            Log Your First Workout
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="workout-list">
                        <c:forEach items="${workouts}" var="workout">
                            <div class="workout-card">
                                <div class="workout-header">
                                    <div class="workout-title">
                                        <span class="category-badge ${workout.category.toLowerCase()}">
                                            ${workout.category}
                                        </span>
                                        <h3>${workout.exerciseName}</h3>
                                    </div>
                                    <div class="workout-date">
                                        ${workout.workoutDate}
                                        <c:if test="${workout.workoutTime != null}">
                                            <br/>
                                            <small>${workout.workoutTime}</small>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="workout-details">
                                    <div class="detail-item">
                                        <span class="detail-icon">⏱️</span>
                                        <span>${workout.durationMinutes} min</span>
                                    </div>
                                    
                                    <c:if test="${workout.caloriesBurned != null}">
                                        <div class="detail-item">
                                            <span class="detail-icon">🔥</span>
                                            <span>${workout.caloriesBurned} cal</span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${workout.distance != null}">
                                        <div class="detail-item">
                                            <span class="detail-icon">📏</span>
                                            <span>${workout.distance} km</span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${workout.sets != null}">
                                        <div class="detail-item">
                                            <span class="detail-icon">📊</span>
                                            <span>${workout.sets} × ${workout.reps}</span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${workout.weightLifted != null}">
                                        <div class="detail-item">
                                            <span class="detail-icon">⚖️</span>
                                            <span>${workout.weightLifted} kg</span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <c:if test="${not empty workout.notes}">
                                    <div class="workout-notes">
                                        <p>"${workout.notes}"</p>
                                    </div>
                                </c:if>
                                
                                <div class="workout-actions">
                                    <a href="${pageContext.request.contextPath}/workout/view/${workout.workoutId}" 
                                       class="btn-action btn-view">
                                        <span class="action-icon">👁️</span> View
                                    </a>
                                    <a href="${pageContext.request.contextPath}/workout/edit/${workout.workoutId}" 
                                       class="btn-action btn-edit">
                                        <span class="action-icon">✏️</span> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/workout/delete/${workout.workoutId}" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Are you sure you want to delete this workout?');">
                                        <span class="action-icon">🗑️</span> Delete
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>