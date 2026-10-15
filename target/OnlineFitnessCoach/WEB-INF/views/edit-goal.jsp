<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Goal - Fitness Tracker</title>
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
            <h1>✏️ Edit Goal</h1>
            <p>Update your goal details</p>
        </div>

        <div class="goal-form-container">
            <form:form method="POST" 
                      action="${pageContext.request.contextPath}/goal/update/${goal.goalId}" 
                      modelAttribute="goal" 
                      id="goalForm">
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <!-- Goal Type -->
                <div class="form-group">
                    <label for="goalType">
                        <span class="icon">🎯</span> Goal Type *
                    </label>
                    <form:select path="goalType" id="goalType" cssClass="form-control" 
                                required="true" onchange="updateGoalDescription()">
                        <form:option value="">Select Goal Type</form:option>
                        <form:option value="weight">Weight Goal (Lose/Gain Weight)</form:option>
                        <form:option value="frequency">Workout Frequency (Workouts per Week)</form:option>
                        <form:option value="duration">Duration Goal (Total Minutes per Week)</form:option>
                        <form:option value="distance">Distance Goal (Total KM per Week)</form:option>
                        <form:option value="strength">Strength Goal (Lift Weight Target)</form:option>
                    </form:select>
                    <form:errors path="goalType" cssClass="error-message"/>
                </div>
                
                <!-- Goal Description -->
                <div class="form-group">
                    <label for="goalDescription">
                        <span class="icon">📝</span> Goal Description *
                    </label>
                    <form:textarea path="goalDescription" id="goalDescription" rows="3"
                                  placeholder="Describe your goal" 
                                  cssClass="form-control" required="true"/>
                    <form:errors path="goalDescription" cssClass="error-message"/>
                </div>
                
                <!-- Target Value and Current Value -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="targetValue">
                            <span class="icon">🎲</span> Target Value *
                        </label>
                        <form:input path="targetValue" type="number" id="targetValue" 
                                   placeholder="Target" 
                                   cssClass="form-control" 
                                   step="0.1" min="0.1" required="true"/>
                        <form:errors path="targetValue" cssClass="error-message"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="currentValue">
                            <span class="icon">📊</span> Current Value
                        </label>
                        <form:input path="currentValue" type="number" id="currentValue" 
                                   placeholder="Current progress" 
                                   cssClass="form-control" 
                                   step="0.1" min="0"/>
                        <form:errors path="currentValue" cssClass="error-message"/>
                        <small class="hint">Update your current progress</small>
                    </div>
                </div>
                
                <!-- Start Date and Deadline -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="startDate">
                            <span class="icon">📅</span> Start Date *
                        </label>
                        <form:input path="startDate" type="date" id="startDate" 
                                   cssClass="form-control" required="true"/>
                        <form:errors path="startDate" cssClass="error-message"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="deadline">
                            <span class="icon">⏰</span> Deadline *
                        </label>
                        <form:input path="deadline" type="date" id="deadline" 
                                   cssClass="form-control" required="true"/>
                        <form:errors path="deadline" cssClass="error-message"/>
                    </div>
                </div>
                
                <!-- Status -->
                <div class="form-group">
                    <label for="status">
                        <span class="icon">📌</span> Status
                    </label>
                    <form:select path="status" id="status" cssClass="form-control">
                        <form:option value="active">Active</form:option>
                        <form:option value="completed">Completed</form:option>
                        <form:option value="cancelled">Cancelled</form:option>
                    </form:select>
                </div>
                
                <!-- Submit Buttons -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        Update Goal
                    </button>
                    <a href="${pageContext.request.contextPath}/goal/view/${goal.goalId}" 
                       class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
                
            </form:form>
        </div>
    </div>
    
    <script>
        // Update goal description hint based on type
        function updateGoalDescription() {
            var goalType = document.getElementById('goalType').value;
            // You can add dynamic hints here if needed
        }
    </script>
</body>
</html>