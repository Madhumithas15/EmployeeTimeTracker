<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
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
        a {
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 1em;
            margin: 10px 0;
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
    <h2><i class="fas fa-tachometer-alt"></i> Welcome, <%= session.getAttribute("username") %></h2>
    <%
        if ("Admin".equals(role)) {
    %>
    <a href="adminPage.jsp"><i class="fas fa-cogs"></i> Admin Page</a><br>
    <%
        } else {
    %>
    <a href="taskPage.jsp"><i class="fas fa-tasks"></i> Task Management</a><br>
    <a href="associaterPage.jsp"><i class="fas fa-users"></i> View Associater</a>
    <%
        }
    %>
    <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
</body>
</html>
<%
    }
%>
