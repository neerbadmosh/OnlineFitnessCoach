<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Goal Details - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/goal.css">
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
        <div class="page-header">
            <h1>🔍 Goal Details</h1>
            <a href="${pageContext.request.contextPath}/goal/list" class="back-link">
                ← Back to Goals
            </a>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>

        <!-- Goal Detail Card -->
        <div class="goal-detail-card">
            <div class="detail-header">
                <div>
                    <span class="goal-type-badge ${goal.goalType}">
                        <c:choose>
                            <c:when test="${goal.goalType == 'weight'}">⚖️ Weight Goal</c:when>
                            <c:when test="${goal.goalType == 'frequency'}">📅 Frequency Goal</c:when>
                            <c:when test="${goal.goalType == 'duration'}">⏱️ Duration Goal</c:when>
                            <c:when test="${goal.goalType == 'distance'}">📏 Distance Goal</c:when>
                            <c:when test="${goal.goalType == 'strength'}">💪 Strength Goal</c:when>
                        </c:choose>
                    </span>
                    <h2>${goal.goalDescription}</h2>
                </div>
                <div class="goal-status-badge ${goal.status}">
                    <c:choose>
                        <c:when test="${goal.status == 'completed'}">✅ Completed</c:when>
                        <c:when test="${goal.status == 'cancelled'}">❌ Cancelled</c:when>
                        <c:otherwise>🏃 Active</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Large Progress Circle -->
            <div class="progress-circle-container">
                <div class="progress-circle">
                    <svg width="200" height="200">
                        <circle cx="100" cy="100" r="90" 
                                stroke="#e0e0e0" 
                                stroke-width="15" 
                                fill="none"/>
                        <circle cx="100" cy="100" r="90" 
                                stroke="url(#gradient)" 
                                stroke-width="15" 
                                fill="none"
                                stroke-dasharray="${goal.progressPercentage * 5.65}, 565"
                                stroke-linecap="round"
                                transform="rotate(-90 100 100)"/>
                        <defs>
                            <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                <stop offset="0%" style="stop-color:#667eea;stop-opacity:1" />
                                <stop offset="100%" style="stop-color:#764ba2;stop-opacity:1" />
                            </linearGradient>
                        </defs>
                    </svg>
                    <div class="progress-text">
                        <span class="progress-percentage">${goal.progressPercentage}%</span>
                        <span class="progress-label">Complete</span>
                    </div>
                </div>
            </div>

            <!-- Goal Stats -->
            <div class="detail-grid">
                <div class="detail-box">
                    <span class="detail-icon-large">🎲</span>
                    <h3>Target</h3>
                    <p>${goal.targetValue}</p>
                </div>

                <div class="detail-box">
                    <span class="detail-icon-large">📊</span>
                    <h3>Current</h3>
                    <p>${goal.currentValue}</p>
                </div>

                <div class="detail-box">
                    <span class="detail-icon-large">📅</span>
                    <h3>Start Date</h3>
                    <p>${goal.startDate}</p>
                </div>

                <div class="detail-box">
                    <span class="detail-icon-large">⏰</span>
                    <h3>Deadline</h3>
                    <p>${goal.deadline}</p>
                </div>

                <div class="detail-box">
                    <span class="detail-icon-large">⏳</span>
                    <h3>Days Remaining</h3>
                    <p>
                        <c:choose>
                            <c:when test="${goal.daysRemaining > 0}">
                                ${goal.daysRemaining} days
                            </c:when>
                            <c:when test="${goal.daysRemaining == 0}">
                                Due today!
                            </c:when>
                            <c:otherwise>
                                Overdue
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="detail-box">
                    <span class="detail-icon-large">
                        <c:choose>
                            <c:when test="${goal.achieved}">✅</c:when>
                            <c:otherwise>🎯</c:otherwise>
                        </c:choose>
                    </span>
                    <h3>Status</h3>
                    <p>
                        <c:choose>
                            <c:when test="${goal.achieved}">Achieved!</c:when>
                            <c:otherwise>In Progress</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="detail-actions">
                <c:if test="${goal.status == 'active'}">
                    <a href="${pageContext.request.contextPath}/goal/edit/${goal.goalId}" 
                       class="btn btn-primary">
                        Edit Goal
                    </a>
                    <a href="${pageContext.request.contextPath}/goal/complete/${goal.goalId}" 
                       class="btn btn-success"
                       onclick="return confirm('Mark this goal as completed?');">
                        Mark as Completed
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/goal/delete/${goal.goalId}" 
                   class="btn btn-danger"
                   onclick="return confirm('Are you sure you want to delete this goal?');">
                    Delete Goal
                </a>
            </div>
        </div>
    </div>
</body>
</html>