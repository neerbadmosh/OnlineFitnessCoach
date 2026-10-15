<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
			    <li><a href="${pageContext.request.contextPath}/workout/history">My Workouts</a></li>
			    <li><a href="${pageContext.request.contextPath}/goal/list">Goals</a></li>
				<li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
			    <li><a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a></li>
			</ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="dashboard-container">
        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <c:if test="${not empty loginSuccess}">
                <div class="alert alert-success">
                    ${loginSuccess}
                </div>
            </c:if>
            
            <h1>Welcome, ${user.username}! 👋</h1>
            <p class="welcome-text">Here's your fitness overview</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">📝</div>
                <div class="stat-info">
                    <h3>${totalWorkouts}</h3>
                    <p>Total Workouts</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-info">
                    <h3>${weeklyWorkouts}</h3>
                    <p>This Week</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">🎯</div>
                <div class="stat-info">
                    <h3>${activeGoals}</h3>
                    <p>Active Goals</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">🔥</div>
                <div class="stat-info">
                    <h3>${caloriesBurned}</h3>
                    <p>Calories Burned</p>
                </div>
            </div>
        </div>

        <!-- User Info Section -->
        <div class="info-section">
            <div class="info-card">
                <h3>📋 Your Profile</h3>
                <div class="profile-details">
                    <div class="detail-row">
                        <span class="label">Full Name:</span>
                        <span class="value">${user.fullName != null ? user.fullName : 'Not set'}</span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Email:</span>
                        <span class="value">${user.email}</span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Age:</span>
                        <span class="value">${user.age != null ? user.age : 'Not set'}</span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Gender:</span>
                        <span class="value">${user.gender != null ? user.gender : 'Not set'}</span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Height:</span>
                        <span class="value">
                            <c:choose>
                                <c:when test="${user.height != null}">
                                    ${user.height} cm
                                </c:when>
                                <c:otherwise>
                                    Not set
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Weight:</span>
                        <span class="value">
                            <c:choose>
                                <c:when test="${user.currentWeight != null}">
                                    ${user.currentWeight} kg
                                </c:when>
                                <c:otherwise>
                                    Not set
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Fitness Level:</span>
                        <span class="value fitness-badge">${user.fitnessLevel != null ? user.fitnessLevel : 'Not set'}</span>
                    </div>
                </div>
            </div>

            <div class="info-card">
                <h3>🚀 Quick Actions</h3>
				<div class="action-buttons">
				    <a href="${pageContext.request.contextPath}/workout/log" class="action-btn" style="text-decoration: none;">
				        <span class="action-icon">📝</span>
				        Log Workout
				    </a>
				    <a href="${pageContext.request.contextPath}/goal/create" class="action-btn" style="text-decoration: none;">
				        <span class="action-icon">🎯</span>
				        Set New Goal
				    </a>
				    <a href="${pageContext.request.contextPath}/goal/list" class="action-btn" style="text-decoration: none;">
				        <span class="action-icon">📊</span>
				        View Goals
				    </a>
					
					<a href="${pageContext.request.contextPath}/profile" class="action-btn" style="text-decoration: none;">
									        <span class="action-icon">📊</span>
									        Edit Profile
					</a>
										
				    <!--
						<button class="action-btn" onclick="alert('Edit Profile feature coming soon!')">
										        <span class="action-icon">👤</span>
										        Edit Profile
										    </button>
					-->
				</div>
            </div>
        </div>

    </div>
</body>
</html>