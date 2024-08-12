<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Tasks/Hours Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @keyframes formalBackgroundAnimation {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(45deg, #4a90e2, #d0d0d0, #4a90e2, #d0d0d0);
            background-size: 400% 400%;
            animation: formalBackgroundAnimation 20s ease infinite;
            color: #333;
            padding: 20px;
            margin: 0;
            overflow-x: hidden;
            overflow-y: auto;
            text-align: center;
        }

        h2 {
            color: #fff;
            margin-bottom: 20px; /* Adjusted margin */
            font-size: 2em; /* Adjusted font size */
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px; /* Space between icon and text */
        }

        h2 i {
            font-size: 1.2em; /* Adjusted icon size */
            color: #007bff; /* Icon color */
        }

        canvas {
            width: 400px; /* Set width for medium size */
            height: 400px; /* Set height for medium size */
        }

        a.button {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            border-radius: 12px;
            background: linear-gradient(45deg, #ff6b6b, #f7d794); /* Vibrant gradient */
            color: #fff;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        a.button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(255,255,255,0.5);
            transition: all 0.4s ease;
            transform: translate(-50%, -50%) scale(0);
            border-radius: 50%;
            z-index: 0;
        }

        a.button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        a.button:hover {
            background: linear-gradient(45deg, #f7d794, #ff6b6b);
            box-shadow: 0 8px 24px rgba(0,0,0,0.4);
            transform: scale(1.05);
        }

        a.button i {
            margin-right: 12px;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <h2><i class="fas fa-chart-bar"></i> Monthly Tasks/Hours Bar Chart for <%= username %></h2>
    <canvas id="monthlyChart"></canvas>
    <script>
        fetch('MonthlyChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('monthlyChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Tasks/Hours',
                        data: data.data,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
    </script>
    <a href="dashboard.jsp" class="button"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
</body>
</html>
