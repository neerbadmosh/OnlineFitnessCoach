<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
    <div class="container">
        <div class="register-box">
            <div class="header">
                <h1>💪 Join Fitness Tracker</h1>
                <p class="subtitle">Start Your Fitness Journey Today!</p>
            </div>
            
            <div class="form-container">
                <form:form method="POST" action="${pageContext.request.contextPath}/register" 
                          modelAttribute="user" id="registrationForm">
                    
                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">
                            <span class="icon">👤</span> Username *
                        </label>
                        <form:input path="username" id="username" 
                                   placeholder="Choose a username" 
                                   cssClass="form-control" 
                                   required="true"/>
                        <form:errors path="username" cssClass="error-message"/>
                        <c:if test="${not empty usernameError}">
                            <span class="error-message">${usernameError}</span>
                        </c:if>
                    </div>
                    
                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">
                            <span class="icon">📧</span> Email *
                        </label>
                        <form:input path="email" type="email" id="email" 
                                   placeholder="your.email@example.com" 
                                   cssClass="form-control"
                                   required="true"/>
                        <form:errors path="email" cssClass="error-message"/>
                        <c:if test="${not empty emailError}">
                            <span class="error-message">${emailError}</span>
                        </c:if>
                    </div>
                    
                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">
                            <span class="icon">🔒</span> Password *
                        </label>
                        <form:password path="password" id="password" 
                                      placeholder="Create a strong password" 
                                      cssClass="form-control"
                                      required="true"/>
                        <form:errors path="password" cssClass="error-message"/>
                        <small class="hint">Minimum 6 characters</small>
                    </div>
                    
                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="confirmPassword">
                            <span class="icon">🔒</span> Confirm Password *
                        </label>
                        <input type="password" id="confirmPassword" name="confirmPassword"
                               placeholder="Re-enter your password" 
                               class="form-control"
                               required/>
                        <span id="passwordMatchError" class="error-message" style="display:none;">
                            Passwords do not match!
                        </span>
                    </div>
                    
                    <!-- Full Name -->
                    <div class="form-group">
                        <label for="fullName">
                            <span class="icon">📝</span> Full Name
                        </label>
                        <form:input path="fullName" id="fullName" 
                                   placeholder="Your full name" 
                                   cssClass="form-control"/>
                    </div>
                    
                    <!-- Two Column Layout -->
                    <div class="form-row">
                        <!-- Age -->
                        <div class="form-group half-width">
                            <label for="age">
                                <span class="icon">🎂</span> Age
                            </label>
                            <form:input path="age" type="number" id="age" 
                                       placeholder="Your age" 
                                       cssClass="form-control"
                                       min="10" max="120"/>
                        </div>
                        
                        <!-- Gender -->
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
                    
                    <!-- Two Column Layout -->
                    <div class="form-row">
                        <!-- Height -->
                        <div class="form-group half-width">
                            <label for="height">
                                <span class="icon">📏</span> Height (cm)
                            </label>
                            <form:input path="height" type="number" id="height" 
                                       placeholder="Height in cm" 
                                       cssClass="form-control"
                                       step="0.1" min="50" max="300"/>
                        </div>
                        
                        <!-- Weight -->
                        <div class="form-group half-width">
                            <label for="currentWeight">
                                <span class="icon">⚖️</span> Weight (kg)
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
                    
                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-error">
                            ${errorMessage}
                        </div>
                    </c:if>
                    
                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block">
                            Create Account
                        </button>
                    </div>
                    
                    <!-- Login Link -->
                    <div class="form-footer">
                        <p>Already have an account? 
                            <a href="${pageContext.request.contextPath}/login">Login here</a>
                        </p>
                    </div>
                    
                </form:form>
            </div>
        </div>
    </div>
    
    <script>
        // Password confirmation validation
        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            var errorSpan = document.getElementById('passwordMatchError');
            
            if (password !== confirmPassword) {
                e.preventDefault();
                errorSpan.style.display = 'block';
                document.getElementById('confirmPassword').classList.add('error-input');
                return false;
            } else {
                errorSpan.style.display = 'none';
                document.getElementById('confirmPassword').classList.remove('error-input');
            }
        });
        
        // Real-time password match checking
        document.getElementById('confirmPassword').addEventListener('input', function() {
            var password = document.getElementById('password').value;
            var confirmPassword = this.value;
            var errorSpan = document.getElementById('passwordMatchError');
            
            if (confirmPassword.length > 0) {
                if (password !== confirmPassword) {
                    errorSpan.style.display = 'block';
                    this.classList.add('error-input');
                } else {
                    errorSpan.style.display = 'none';
                    this.classList.remove('error-input');
                }
            }
        });
    </script>
</body>
</html>