<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fitness Tracker - Welcome</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-box">
            <div class="header">
                <h1>💪 Fitness Tracker</h1>
                <p class="subtitle">Track. Achieve. Succeed.</p>
            </div>
            
            <div class="content">
                <h2>${message}</h2>
                <p class="description">${description}</p>
                
                <div class="status-badge">
                    <span class="badge-icon">✅</span>
                    <span>${appStatus}</span>
                </div>
                
                <div class="features">
                    <h3>🎯 Key Features</h3>
                    <ul>
                        <li>
                            <span class="feature-icon">📝</span>
                            <strong>Workout Logging:</strong> Track all your exercises with detailed metrics
                        </li>
                        <li>
                            <span class="feature-icon">🎯</span>
                            <strong>Goal Setting:</strong> Set personalized fitness goals and monitor progress
                        </li>
                        <li>
                            <span class="feature-icon">📊</span>
                            <strong>Progress Analytics:</strong> Visualize your fitness journey with charts
                        </li>
                        <li>
                            <span class="feature-icon">📅</span>
                            <strong>Workout Calendar:</strong> View your training schedule at a glance
                        </li>
                        <li>
                            <span class="feature-icon">🏆</span>
                            <strong>Achievement Tracking:</strong> Celebrate milestones and personal records
                        </li>
                    </ul>
                </div>
                
                <div class="tech-info">
                    <h3>🛠️ Technology Stack</h3>
                    <p>${techStack}</p>
                    <div class="tech-badges">
                        <span class="tech-badge">Spring Boot</span>
                        <span class="tech-badge">Hibernate/JPA</span>
                        <span class="tech-badge">JSP/JSTL</span>
                        <span class="tech-badge">MySQL</span>
                    </div>
                </div>
                
				<div class="actions">
				    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="text-decoration: none;">
				        Get Started - Register Now
				    </a>
				    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary" style="text-decoration: none;">
				        Login
				    </a>
				</div>
            </div>
            
            <div class="footer">
                <p>&copy; 2024 Fitness Tracker Application</p>
                <p>Built with ❤️ using Spring Boot</p>
            </div>
        </div>
    </div>
</body>
</html>