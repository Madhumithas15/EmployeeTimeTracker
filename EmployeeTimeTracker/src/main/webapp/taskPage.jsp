<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get the session
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    // Retrieve username from the session
    String username = (String) session.getAttribute("username");
    int userId = 0;
    String dbUrl = "jdbc:mysql://localhost:3306/EmployeeTaskTracker";
    String dbUser = "root";
    String dbPass = "mani12";

    // Query to get user_id from username
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT user_id FROM Users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            userId = rs.getInt("user_id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Task Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styles */
        @keyframes formalBackgroundAnimation {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

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

        h2, h3 {
            color: #fff;
            margin-bottom: 30px;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        h2 {
            font-size: 2.5em;
        }

        h3 {
            font-size: 2em;
            margin-top: 40px;
        }

        h2 i, h3 i {
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

        /* Table Styles */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.8); /* Glass effect */
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        th, td {
            padding: 12px 20px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            color: #333;
        }

        th {
            background-color: #4a90e2;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        /* Action Button Styles */
        .action-buttons a {
            color: #4a90e2;
            padding: 8px 12px;
            border-radius: 6px;
            background-color: rgba(255, 255, 255, 0.8);
            transition: all 0.2s ease;
            font-weight: bold;
            margin: 0 5px;
            display: inline-flex;
            align-items: center;
        }

        .action-buttons a:hover {
            background-color: #4a90e2;
            color: #fff;
        }

        .action-buttons i {
            margin-right: 5px; /* Icon spacing */
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
    <h2><i class="fas fa-tachometer-alt"></i>Task Management for <%= username %></h2>
    <form action="TaskServlet" method="get">
        <input type="hidden" name="userId" value="<%= userId %>">
        <label for="project">Project:</label>
        <input type="text" id="project" name="project"><br><br>
        <label for="date">Date:</label>
        <input type="date" id="date" name="date"><br><br>
        <label for="startTime">Start Time:</label>
        <input type="time" id="startTime" name="startTime"><br><br>
        <label for="endTime">End Time:</label>
        <input type="time" id="endTime" name="endTime"><br><br>
        <label for="category">Category:</label>
        <input type="text" id="category" name="category"><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description"></textarea><br><br>
        <input type="submit" value="Add Task">
    </form>
    <h3><i class="fas fa-list-alt"></i>Your Tasks</h3>
    <table border="1">
        <tr>
            <th>Project</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Category</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks WHERE employee_id=?");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("project") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getTime("start_time") %></td>
            <td><%= rs.getTime("end_time") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("description") %></td>
            <td class="action-buttons">
                <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>"><i class="fas fa-edit"></i>Edit</a>
                <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>"><i class="fas fa-trash"></i>Delete</a>
            </td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
    <a href="dashboard.jsp" class="back-button"><i class="fas fa-arrow-left"></i>Back to Dashboard</a>
</body>
</html>
