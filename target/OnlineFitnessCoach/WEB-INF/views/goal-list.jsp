<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Goals - Fitness Tracker</title>
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
            <h1>🎯 My Fitness Goals</h1>
            <p>Track your progress and achieve your targets</p>
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
        <div class="goal-summary">
            <div class="summary-card">
                <span class="summary-icon">🎯</span>
                <div>
                    <h3>${activeCount}</h3>
                    <p>Active Goals</p>
                </div>
            </div>
            <div class="summary-card">
                <span class="summary-icon">✅</span>
                <div>
                    <h3>${completedCount}</h3>
                    <p>Completed Goals</p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="goal-actions">
            <a href="${pageContext.request.contextPath}/goal/create" class="btn btn-primary">
                <span class="btn-icon">➕</span> Create New Goal
            </a>
            
            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <a href="${pageContext.request.contextPath}/goal/list" 
                   class="filter-btn ${empty currentFilter ? 'active' : ''}">
                    All
                </a>
                <a href="${pageContext.request.contextPath}/goal/list?filter=active" 
                   class="filter-btn ${'active' eq currentFilter ? 'active' : ''}">
                    Active
                </a>
                <a href="${pageContext.request.contextPath}/goal/list?filter=completed" 
                   class="filter-btn ${'completed' eq currentFilter ? 'active' : ''}">
                    Completed
                </a>
            </div>
        </div>

        <!-- Goals List -->
        <div class="goals-container">
            <c:choose>
                <c:when test="${empty goals}">
                    <div class="empty-state">
                        <p class="empty-icon">🎯</p>
                        <h3>No Goals Yet</h3>
                        <p>Set your first fitness goal and start tracking your progress!</p>
                        <a href="${pageContext.request.contextPath}/goal/create" class="btn btn-primary">
                            Create Your First Goal
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="goal-list">
                        <c:forEach items="${goals}" var="goal">
                            <div class="goal-card ${goal.status}">
                                <div class="goal-header">
                                    <div class="goal-title">
                                        <span class="goal-type-badge ${goal.goalType}">
                                            <c:choose>
                                                <c:when test="${goal.goalType == 'weight'}">⚖️ Weight</c:when>
                                                <c:when test="${goal.goalType == 'frequency'}">📅 Frequency</c:when>
                                                <c:when test="${goal.goalType == 'duration'}">⏱️ Duration</c:when>
                                                <c:when test="${goal.goalType == 'distance'}">📏 Distance</c:when>
                                                <c:when test="${goal.goalType == 'strength'}">💪 Strength</c:when>
                                                <c:otherwise>🎯 Goal</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <h3>${goal.goalDescription}</h3>
                                    </div>
                                    <div class="goal-status-badge ${goal.status}">
                                        <c:choose>
                                            <c:when test="${goal.status == 'completed'}">✅ Completed</c:when>
                                            <c:when test="${goal.status == 'cancelled'}">❌ Cancelled</c:when>
                                            <c:otherwise>🏃 Active</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <!-- Progress Bar -->
                                <div class="progress-section">
                                    <div class="progress-info">
                                        <span>Progress: ${goal.progressPercentage}%</span>
                                        <span>${goal.currentValue} / ${goal.targetValue}</span>
                                    </div>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: ${goal.progressPercentage}%"></div>
                                    </div>
                                </div>
                                
                                <!-- Goal Details -->
                                <div class="goal-details">
                                    <div class="detail-item">
                                        <span class="detail-icon">🎲</span>
                                        <span>Target: ${goal.targetValue}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-icon">📅</span>
                                        <span>Start: ${goal.startDate}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-icon">⏰</span>
                                        <span>Deadline: ${goal.deadline}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-icon">⏳</span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${goal.daysRemaining > 0}">
                                                    ${goal.daysRemaining} days left
                                                </c:when>
                                                <c:when test="${goal.daysRemaining == 0}">
                                                    Due today!
                                                </c:when>
                                                <c:otherwise>
                                                    Overdue
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                
                                <!-- Goal Actions -->
                                <div class="goal-actions-buttons">
                                    <a href="${pageContext.request.contextPath}/goal/view/${goal.goalId}" 
                                       class="btn-action btn-view">
                                        View
                                    </a>
                                    
                                    <c:if test="${goal.status == 'active'}">
                                        <a href="${pageContext.request.contextPath}/goal/edit/${goal.goalId}" 
                                           class="btn-action btn-edit">
                                            Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/goal/complete/${goal.goalId}" 
                                           class="btn-action btn-complete"
                                           onclick="return confirm('Mark this goal as completed?');">
                                            Complete
                                        </a>
                                    </c:if>
                                    
                                    <a href="${pageContext.request.contextPath}/goal/delete/${goal.goalId}" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Are you sure you want to delete this goal?');">
                                        Delete
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