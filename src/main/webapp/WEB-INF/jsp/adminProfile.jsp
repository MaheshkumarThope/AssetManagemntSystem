<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #0f172a; /* dark slate */
            color: #e5e7eb;            /* light text */
        }

        .header {
            background-color: #111827; /* dark header */
            color: #f9fafb;
            padding: 12px 24px;
            border-bottom: 1px solid #1f2937;
        }

        .header h1 {
            margin: 0;
            font-size: 20px;
        }

        .nav-links a {
            color: #e5e7eb;
            text-decoration: none;
            margin-right: 18px;
            font-size: 14px;
            padding: 4px 8px;
            border-radius: 4px;
        }

        .nav-links a:hover {
            background-color: #1f2937;
        }

        .nav-links a[href="adminProfile"] {
            background-color: #2563eb;
            color: #f9fafb;
        }

        .container {
            max-width: 700px;
            margin: 30px auto;
            background: #020617;              /* card background */
            padding: 22px 26px;
            border-radius: 6px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
            border: 1px solid #1f2937;
        }

        h2 {
            margin-top: 0;
            font-size: 18px;
            margin-bottom: 8px;
        }

        p {
            margin-top: 0;
            color: #9ca3af;
            font-size: 13px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        td {
            padding: 10px 6px;
            border-bottom: 1px solid #1f2937;
            font-size: 14px;
        }

        td.label {
            width: 30%;
            font-weight: bold;
            color: #9ca3af;
        }

        .btn {
            display: inline-block;
            padding: 7px 14px;
            margin-top: 18px;
            background-color: #2563eb;
            color: #f9fafb;
            text-decoration: none;
            font-size: 14px;
            border-radius: 4px;
        }

        .btn:hover {
            background-color: #1d4ed8;
        }
    </style>
</head>
<body>



<div class="container">
    <h2>Admin Profile</h2>
    <p>Details of the logged-in admin.</p>

    <table>
        <tr>
            <td class="label">Admin ID</td>
            <td>${sessionScope.userId}</td>
        </tr>
        <tr>
            <td class="label">Full Name</td>
            <td>${sessionScope.userName}</td>
        </tr>
        <tr>
            <td class="label">Email</td>
            <td>${sessionScope.email}</td>
        </tr>
        <tr>
            <td class="label">Phone</td>
            <td>${sessionScope.phone}</td>
        </tr>
    </table>

    <a href="/admin" class="btn">Back to Dashboard</a>
</div>

</body>
</html>
