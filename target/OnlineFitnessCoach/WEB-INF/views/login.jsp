<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <div class="header">
                <h1>🔐 Welcome Back!</h1>
                <p class="subtitle">Login to Continue Your Fitness Journey</p>
            </div>
            
            <div class="form-container">
                <!-- Success Message (from registration) -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <span class="alert-icon">✅</span>
                        ${successMessage}
                    </div>
                </c:if>
                
                <!-- Logout Message -->
                <c:if test="${not empty logoutMessage}">
                    <div class="alert alert-info">
                        <span class="alert-icon">ℹ️</span>
                        ${logoutMessage}
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <span class="alert-icon">❌</span>
                        ${errorMessage}
                    </div>
                </c:if>
                
                <form method="POST" action="${pageContext.request.contextPath}/login" class="login-form">
                    
                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">
                            <span class="icon">👤</span> Username
                        </label>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               value="${username}"
                               placeholder="Enter your username" 
                               class="form-control"
                               required
                               autofocus/>
                    </div>
                    
                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">
                            <span class="icon">🔒</span> Password
                        </label>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               placeholder="Enter your password" 
                               class="form-control"
                               required/>
                    </div>
                    
                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block">
                            Login
                        </button>
                    </div>
                    
                    <!-- Register Link -->
                    <div class="form-footer">
                        <p>Don't have an account? 
                            <a href="${pageContext.request.contextPath}/register">Register here</a>
                        </p>
                    </div>
                    
                </form>
            </div>
            
            <div class="quick-links">
                <a href="${pageContext.request.contextPath}/" class="back-link">
                    ← Back to Home
                </a>
            </div>
        </div>
    </div>
</body>
</html>