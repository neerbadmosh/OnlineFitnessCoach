<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Goal - Fitness Tracker</title>
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
            <h1>🎯 Create New Goal</h1>
            <p>Set a fitness goal and track your progress</p>
        </div>

        <div class="goal-form-container">
            <form:form method="POST" 
                      action="${pageContext.request.contextPath}/goal/create" 
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
                                  placeholder="Describe your goal (e.g., Lose 5kg by summer)" 
                                  cssClass="form-control" required="true"/>
                    <form:errors path="goalDescription" cssClass="error-message"/>
                    <small class="hint">Be specific about what you want to achieve</small>
                </div>
                
                <!-- Target Value -->
                <div class="form-group">
                    <label for="targetValue">
                        <span class="icon">🎲</span> Target Value *
                    </label>
                    <form:input path="targetValue" type="number" id="targetValue" 
                               placeholder="Enter target value" 
                               cssClass="form-control" 
                               step="0.1" min="0.1" required="true"/>
                    <form:errors path="targetValue" cssClass="error-message"/>
                    <small class="hint" id="targetHint">
                        Enter the target value for your goal
                    </small>
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
                
                <!-- Goal Preview Card -->
                <div class="goal-preview">
                    <h3>📋 Goal Preview</h3>
                    <div class="preview-content">
                        <p><strong>Type:</strong> <span id="previewType">Not selected</span></p>
                        <p><strong>Target:</strong> <span id="previewTarget">Not set</span></p>
                        <p><strong>Deadline:</strong> <span id="previewDeadline">Not set</span></p>
                    </div>
                </div>
                
                <!-- Submit Buttons -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        Create Goal
                    </button>
                    <a href="${pageContext.request.contextPath}/goal/list" 
                       class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
                
            </form:form>
        </div>
    </div>
    
    <script>
        // Set today's date as default start date
        document.getElementById('startDate').valueAsDate = new Date();
        
        // Set default deadline (30 days from now)
        var defaultDeadline = new Date();
        defaultDeadline.setDate(defaultDeadline.getDate() + 30);
        document.getElementById('deadline').valueAsDate = defaultDeadline;
        
        // Update goal description hint based on type
        function updateGoalDescription() {
            var goalType = document.getElementById('goalType').value;
            var targetHint = document.getElementById('targetHint');
            var previewType = document.getElementById('previewType');
            
            switch(goalType) {
                case 'weight':
                    targetHint.textContent = 'Enter target weight in kg (e.g., 65 for 65kg)';
                    previewType.textContent = 'Weight Goal';
                    break;
                case 'frequency':
                    targetHint.textContent = 'Enter number of workouts per week (e.g., 5 for 5 workouts/week)';
                    previewType.textContent = 'Workout Frequency';
                    break;
                case 'duration':
                    targetHint.textContent = 'Enter total minutes per week (e.g., 300 for 5 hours/week)';
                    previewType.textContent = 'Duration Goal';
                    break;
                case 'distance':
                    targetHint.textContent = 'Enter total distance in km per week (e.g., 20 for 20km/week)';
                    previewType.textContent = 'Distance Goal';
                    break;
                case 'strength':
                    targetHint.textContent = 'Enter target weight in kg (e.g., 100 for 100kg bench press)';
                    previewType.textContent = 'Strength Goal';
                    break;
                default:
                    targetHint.textContent = 'Enter the target value for your goal';
                    previewType.textContent = 'Not selected';
            }
        }
        
        // Update preview when target value changes
        document.getElementById('targetValue').addEventListener('input', function() {
            var targetValue = this.value;
            var goalType = document.getElementById('goalType').value;
            var previewTarget = document.getElementById('previewTarget');
            
            if (targetValue && goalType) {
                switch(goalType) {
                    case 'weight':
                        previewTarget.textContent = targetValue + ' kg';
                        break;
                    case 'frequency':
                        previewTarget.textContent = targetValue + ' workouts/week';
                        break;
                    case 'duration':
                        previewTarget.textContent = targetValue + ' minutes/week';
                        break;
                    case 'distance':
                        previewTarget.textContent = targetValue + ' km/week';
                        break;
                    case 'strength':
                        previewTarget.textContent = targetValue + ' kg';
                        break;
                    default:
                        previewTarget.textContent = targetValue;
                }
            } else {
                previewTarget.textContent = 'Not set';
            }
        });
        
        // Update preview when deadline changes
        document.getElementById('deadline').addEventListener('change', function() {
            var deadline = this.value;
            var previewDeadline = document.getElementById('previewDeadline');
            
            if (deadline) {
                previewDeadline.textContent = deadline;
            } else {
                previewDeadline.textContent = 'Not set';
            }
        });
    </script>
</body>
</html>