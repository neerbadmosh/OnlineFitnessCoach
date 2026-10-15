<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
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
            <h1>✏️ Edit Profile</h1>
            <p>Update your personal information</p>
        </div>

        <div class="profile-form-container">
            <form:form method="POST" 
                      action="${pageContext.request.contextPath}/profile/update" 
                      modelAttribute="user">
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <!-- Note about non-editable fields -->
                <div class="info-box">
                    <p>ℹ️ Username and email cannot be changed. Contact support if you need to update these.</p>
                </div>
                
                <!-- Full Name -->
                <div class="form-group">
                    <label for="fullName">
                        <span class="icon">📝</span> Full Name
                    </label>
                    <form:input path="fullName" id="fullName" 
                               placeholder="Your full name" 
                               cssClass="form-control"/>
                    <form:errors path="fullName" cssClass="error-message"/>
                </div>
                
                <!-- Age and Gender -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="age">
                            <span class="icon">🎂</span> Age
                        </label>
                        <form:input path="age" type="number" id="age" 
                                   placeholder="Your age" 
                                   cssClass="form-control"
                                   min="10" max="120"/>
                        <form:errors path="age" cssClass="error-message"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="gender">
                            <span class="icon">⚧</span> Gender
                        </label>
                        <form:select path="gender" id="gender" cssClass="form-control">
                            <form:option value="">Select Gender</form:option>
                            <form:option value="Male">Male</form:option>
                            <form:option value="Female">Female</form:option>
                            <form:option value="Other">Other</form:option>
                        </form:select>
                    </div>
                </div>
                
                <!-- Height and Weight -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="height">
                            <span class="icon">📏</span> Height (cm)
                        </label>
                        <form:input path="height" type="number" id="height" 
                                   placeholder="Height in cm" 
                                   cssClass="form-control"
                                   step="0.1" min="50" max="300"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="currentWeight">
                            <span class="icon">⚖️</span> Current Weight (kg)
                        </label>
                        <form:input path="currentWeight" type="number" id="currentWeight" 
                                   placeholder="Weight in kg" 
                                   cssClass="form-control"
                                   step="0.1" min="20" max="500"/>
                    </div>
                </div>
                
                <!-- Fitness Level -->
                <div class="form-group">
                    <label for="fitnessLevel">
                        <span class="icon">💪</span> Fitness Level
                    </label>
                    <form:select path="fitnessLevel" id="fitnessLevel" cssClass="form-control">
                        <form:option value="">Select Fitness Level</form:option>
                        <form:option value="Beginner">Beginner - Just starting out</form:option>
                        <form:option value="Intermediate">Intermediate - Regular exercise</form:option>
                        <form:option value="Advanced">Advanced - Very active</form:option>
                    </form:select>
                </div>
                
                <!-- Submit Buttons -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/profile" 
                       class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
                
            </form:form>
        </div>
    </div>
</body>
</html>