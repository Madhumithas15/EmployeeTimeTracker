<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    ResultSet task = (ResultSet) request.getAttribute("task");
    if (task != null) {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(45deg, #4a90e2, #d0d0d0, #4a90e2, #d0d0d0);
            background-size: 400% 400%;
            animation: formalBackgroundAnimation 20s ease infinite;
            color: #333;
            padding: 20px;
            margin: 0;
            overflow-x: hidden;
            overflow-y: auto; /* Enable vertical scrolling */
            text-align: center;
        }

        h2 {
            color: #fff;
            margin-bottom: 30px;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        h2 i {
            margin-right: 12px; /* Spacing between icon and text */
        }

        a, a:visited {
            color: #4a90e2;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Form Styles */
        form {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.4); /* Glass effect */
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
            backdrop-filter: blur(15px); /* Enhanced glass effect */
            border: 1px solid rgba(255, 255, 255, 0.2); /* Subtle border */
            text-align: left;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            background-color: rgba(255, 255, 255, 0.8);
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        input[type="submit"] {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            border-radius: 12px;
            background: linear-gradient(45deg, #ff6b6b, #f7d794); /* Vibrant gradient */
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1.2em;
            font-weight: bold;
            transition: all 0.3s ease;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            outline: none;
            justify-content: center;
            text-align: center;
        }

        input[type="submit"]:hover {
            background: linear-gradient(45deg, #f7d794, #ff6b6b);
            box-shadow: 0 8px 24px rgba(0,0,0,0.4);
            transform: scale(1.05);
        }

        input[type="submit"] i {
            margin-right: 8px; /* Spacing between icon and text */
        }

        /* Back Button Styles */
        .back-button {
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
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            justify-content: center;
            text-align: center;
        }

        .back-button i {
            margin-right: 12px;
            font-size: 1.5em;
        }

        .back-button::before {
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

        .back-button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        .back-button:hover {
            background: linear-gradient(45deg, #f7d794, #ff6b6b);
        }
    </style>
</head>
<body>
    <h2><i class="fas fa-edit"></i>Edit Task</h2>
    <form action="EditTaskServlet" method="post">
        <input type="hidden" name="taskId" value="<%= task.getInt("task_id") %>">
        <label for="project">Project:</label>
        <input type="text" id="project" name="project" value="<%= task.getString("project") %>"><br><br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="<%= task.getDate("date") %>"><br><br>
        <label for="startTime">Start Time:</label>
        <input type="time" id="startTime" name="startTime" value="<%= task.getTime("start_time") %>"><br><br>
        <label for="endTime">End Time:</label>
        <input type="time" id="endTime" name="endTime" value="<%= task.getTime("end_time") %>"><br><br>
        <label for="category">Category:</label>
        <input type="text" id="category" name="category" value="<%= task.getString("category") %>"><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description"><%= task.getString("description") %></textarea><br><br>
        <input type="submit" value="Update Task"><i class="fas fa-check"></i>
    </form>
    <a href="taskPage.jsp" class="back-button"><i class="fas fa-arrow-left"></i>Back to Task Management</a>
</body>
</html>
<%
    }
%>
