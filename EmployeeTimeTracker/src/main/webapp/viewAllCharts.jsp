<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Charts</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px;
            margin: 0;
        }
        h2 {
            color: #333;
            font-size: 2em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px; /* Space between icon and text */
        }
        h2 i {
            font-size: 1.5em; /* Icon size */
            color: #007bff; /* Icon color */
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        ul li {
            margin-bottom: 10px;
        }
        a {
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 1em;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }
        a i {
            margin-right: 8px; /* Space between icon and text */
        }
        a:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }
        a:active {
            transform: translateY(1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
    </style>
    
</head>
<body>
    <h2><i class="fas fa-chart-line"></i> Charts Overview</h2>
    <ul>
        <li><a href="AllDailyChart.jsp"><i class="fas fa-calendar-day"></i> View Daily Chart</a></li>
        <li><a href="AllWeeklyChart.jsp"><i class="fas fa-calendar-week"></i> View Weekly Chart</a></li>
        <li><a href="AllMonthlyChart.jsp"><i class="fas fa-calendar-month"></i> View Monthly Chart</a></li>
    </ul>
    <a href="dashboard.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
</body>
</html>