<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Fitness Tracker</title>
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
            <h1>👤 My Profile</h1>
            <p>View and manage your account information</p>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>

        <!-- Profile Card -->
        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <span class="avatar-icon">👤</span>
                    </div>
                    <div class="profile-info">
                        <h2>${user.username}</h2>
                        <p>${user.email}</p>
                        <span class="member-since">
                            Member since: ${user.createdAt.toLocalDate()}
                        </span>
                    </div>
                </div>

                <div class="profile-details">
                    <h3>📋 Personal Information</h3>
                    
                    <div class="detail-row">
                        <span class="label">Full Name:</span>
                        <span class="value">${user.fullName != null ? user.fullName : 'Not set'}</span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="label">Username:</span>
                        <span class="value">${user.username}</span>
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
                </div>

                <div class="profile-details">
                    <h3>💪 Fitness Information</h3>
                    
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
                        <span class="label">Current Weight:</span>
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
                        <span class="value fitness-badge ${user.fitnessLevel != null ? user.fitnessLevel.toLowerCase() : ''}">
                            ${user.fitnessLevel != null ? user.fitnessLevel : 'Not set'}
                        </span>
                    </div>
                    
                    <!-- BMI Calculation -->
                    <c:if test="${user.height != null && user.currentWeight != null}">
                        <c:set var="heightInMeters" value="${user.height / 100}" />
                        <c:set var="bmi" value="${user.currentWeight / (heightInMeters * heightInMeters)}" />
                        
                        <div class="detail-row bmi-row">
                            <span class="label">BMI:</span>
                            <span class="value">
                                <fmt:formatNumber value="${bmi}" maxFractionDigits="1" /> 
                                <span class="bmi-category">
                                    <c:choose>
                                        <c:when test="${bmi < 18.5}">
                                            (Underweight)
                                        </c:when>
                                        <c:when test="${bmi >= 18.5 && bmi < 25}">
                                            (Normal)
                                        </c:when>
                                        <c:when test="${bmi >= 25 && bmi < 30}">
                                            (Overweight)
                                        </c:when>
                                        <c:otherwise>
                                            (Obese)
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </span>
                        </div>
                    </c:if>
                </div>

                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary">
                        Edit Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                        Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>