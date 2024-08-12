<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WELCOME</title>
<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f0f8ff;
        text-align: center;
        padding: 50px;
        margin: 0;
    }
    h2 {
        color: #333;
        font-size: 2.5em;
        margin-bottom: 20px;
        font-weight: bold;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px; /* Space between icon and text */
    }
    h2 i {
        font-size: 1.2em; /* Icon size */
        color: #007bff; /* Icon color */
    }
    div {
        background-color: #fff;
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        display: inline-block;
        padding: 20px;
        margin-top: 30px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    div:hover {
        transform: scale(1.05);
        box-shadow: 0 12px 24px rgba(0,0,0,0.3);
    }
    a {
        display: inline-flex;
        align-items: center;
        text-decoration: none;
        color: white;
        background-color: #007bff;
        padding: 15px 30px;
        border-radius: 8px;
        margin: 10px 0;
        transition: all 0.3s ease;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        position: relative;
        overflow: hidden;
    }  
    a i {
        margin-right: 8px; /* Space between icon and text */
    }
    a::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 300%;
        height: 300%;
        background-color: rgba(255, 255, 255, 0.1);
        transition: width 0.4s ease, height 0.4s ease, top 0.4s ease, left 0.4s ease;
        border-radius: 50%;
        transform: translate(-50%, -50%);
    }
    a:hover::before {
        width: 0;
        height: 0;
        top: 50%;
        left: 50%;
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
<h2><i class="fas fa-tachometer-alt"></i> Welcome to EmployeeTimeTracker</h2>
<div>
    <a href="login.jsp" target="_blank" style="background-color: #28a745;"><i class="fas fa-sign-in-alt"></i> Admin Page</a><br>
    <a href="register.jsp" target="_blank" style="background-color: #dc3545;"><i class="fas fa-user-plus"></i> Register Page</a>
</div>
</body>
</html>
