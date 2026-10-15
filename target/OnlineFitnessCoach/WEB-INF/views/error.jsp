<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Fitness Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-box">
            <div class="header" style="background: #dc3545;">
                <h1>❌ Oops!</h1>
                <p class="subtitle">Something went wrong</p>
            </div>
            
            <div class="content">
                <h2>We encountered an error</h2>
                <p>Don't worry, we're working on it!</p>
                
                <div class="actions" style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/dashboard" 
                       class="btn btn-primary" style="text-decoration: none;">
                        Go to Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/" 
                       class="btn btn-secondary" style="text-decoration: none;">
                        Go to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>