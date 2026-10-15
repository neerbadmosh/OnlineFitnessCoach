<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Workout - Fitness Tracker</title>
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
            <h1>✏️ Edit Workout</h1>
            <p>Update your workout details</p>
        </div>

        <div class="workout-form-container">
            <form:form method="POST" 
                      action="${pageContext.request.contextPath}/workout/update/${workout.workoutId}" 
                      modelAttribute="workout" 
                      id="workoutForm">
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <!-- Date and Time -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="workoutDate">
                            <span class="icon">📅</span> Workout Date *
                        </label>
                        <form:input path="workoutDate" type="date" id="workoutDate" 
                                   cssClass="form-control" required="true"/>
                        <form:errors path="workoutDate" cssClass="error-message"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="workoutTime">
                            <span class="icon">⏰</span> Time
                        </label>
                        <form:input path="workoutTime" type="time" id="workoutTime" 
                                   cssClass="form-control"/>
                    </div>
                </div>
                
                <!-- Category -->
                <div class="form-group">
                    <label for="category">
                        <span class="icon">🏋️</span> Category *
                    </label>
                    <form:select path="category" id="category" cssClass="form-control" 
                                required="true" onchange="updateFields()">
                        <form:option value="">Select Category</form:option>
                        <form:option value="Cardio">Cardio</form:option>
                        <form:option value="Strength">Strength Training</form:option>
                        <form:option value="Flexibility">Flexibility</form:option>
                        <form:option value="Sports">Sports</form:option>
                        <form:option value="Other">Other</form:option>
                    </form:select>
                    <form:errors path="category" cssClass="error-message"/>
                </div>
                
                <!-- Exercise Name -->
                <div class="form-group">
                    <label for="exerciseName">
                        <span class="icon">💪</span> Exercise Name *
                    </label>
                    <form:input path="exerciseName" id="exerciseName" 
                               placeholder="e.g., Running, Bench Press, Yoga" 
                               cssClass="form-control" required="true"/>
                    <form:errors path="exerciseName" cssClass="error-message"/>
                </div>
                
                <!-- Duration and Calories -->
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="durationMinutes">
                            <span class="icon">⏱️</span> Duration (minutes) *
                        </label>
                        <form:input path="durationMinutes" type="number" id="durationMinutes" 
                                   placeholder="30" cssClass="form-control" 
                                   min="1" required="true"/>
                        <form:errors path="durationMinutes" cssClass="error-message"/>
                    </div>
                    
                    <div class="form-group half-width">
                        <label for="caloriesBurned">
                            <span class="icon">🔥</span> Calories Burned
                        </label>
                        <form:input path="caloriesBurned" type="number" id="caloriesBurned" 
                                   placeholder="200" cssClass="form-control" min="0"/>
                        <form:errors path="caloriesBurned" cssClass="error-message"/>
                    </div>
                </div>
                
                <!-- Cardio Specific Fields -->
                <div id="cardioFields">
                    <div class="form-group">
                        <label for="distance">
                            <span class="icon">📏</span> Distance (km)
                        </label>
                        <form:input path="distance" type="number" id="distance" 
                                   placeholder="5.0" cssClass="form-control" 
                                   step="0.1" min="0"/>
                    </div>
                </div>
                
                <!-- Strength Training Specific Fields -->
                <div id="strengthFields">
                    <div class="form-row">
                        <div class="form-group third-width">
                            <label for="sets">
                                <span class="icon">📊</span> Sets
                            </label>
                            <form:input path="sets" type="number" id="sets" 
                                       placeholder="3" cssClass="form-control" min="1"/>
                        </div>
                        
                        <div class="form-group third-width">
                            <label for="reps">
                                <span class="icon">🔢</span> Reps
                            </label>
                            <form:input path="reps" type="number" id="reps" 
                                       placeholder="10" cssClass="form-control" min="1"/>
                        </div>
                        
                        <div class="form-group third-width">
                            <label for="weightLifted">
                                <span class="icon">⚖️</span> Weight (kg)
                            </label>
                            <form:input path="weightLifted" type="number" id="weightLifted" 
                                       placeholder="50" cssClass="form-control" 
                                       step="0.5" min="0"/>
                        </div>
                    </div>
                </div>
                
                <!-- Notes -->
                <div class="form-group">
                    <label for="notes">
                        <span class="icon">📝</span> Notes
                    </label>
                    <form:textarea path="notes" id="notes" rows="4"
                                  placeholder="How did you feel? Any observations?" 
                                  cssClass="form-control"/>
                </div>
                
                <!-- Submit Buttons -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        Update Workout
                    </button>
                    <a href="${pageContext.request.contextPath}/workout/view/${workout.workoutId}" 
                       class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
                
            </form:form>
        </div>
    </div>
    
    <script>
        // Show/hide fields based on category on page load
        window.onload = function() {
            updateFields();
        };
        
        // Show/hide fields based on category
        function updateFields() {
            var category = document.getElementById('category').value;
            var cardioFields = document.getElementById('cardioFields');
            var strengthFields = document.getElementById('strengthFields');
            
            // Hide all conditional fields
            cardioFields.style.display = 'none';
            strengthFields.style.display = 'none';
            
            // Show relevant fields
            if (category === 'Cardio') {
                cardioFields.style.display = 'block';
            } else if (category === 'Strength') {
                strengthFields.style.display = 'block';
            }
        }
    </script>
</body>
</html>