<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Users</title>

<style>
  body {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    margin: 20px;
  }

  form {
    margin-bottom: 15px;
  }

  input {
    padding: 8px;
    width: 250px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  button {
    padding: 8px 14px;
    background: #007bff;
    border: none;
    border-radius: 4px;
    color: white;
    cursor: pointer;
  }

  button:hover {
    background: #0056b3;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
  }

  th {
    background: #007bff;
    color: white;
    padding: 10px;
    text-align: left;
  }

  td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
  }

  tr:hover {
    background: #f1f1f1;
  }

  a {
    text-decoration: none;
    color: #007bff;
    font-weight: bold;
  }

  a:hover {
    color: #0056b3;
  }
</style>

</head>
<body>

<form method="get" action="/adminLogin/viewUsers">
  <input name="q" placeholder="Search name/email" value="${q}">
  <button type="submit">Search</button>
</form>

<table border="1" cellpadding="6">
  <thead>
    <tr>
      <th>Name</th><th>Email</th><th>Dept</th><th>Status</th><th>Action</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="u" items="${users}">
      <tr>
        <td>${u.fullName}</td>
        <td>${u.email}</td>
        <td>${u.departmentId}</td>
        <td>${u.statusA}</td>
        <td><a href="/adminLogin/viewUserDetails/${u.userId}">View</a></td>
      </tr>
    </c:forEach>
  </tbody>
</table>

</body>
</html>
