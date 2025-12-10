<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Asset</title>

    <style>
        body {
            background-color: #0f172a;
            margin: 0;
            font-family: Arial, sans-serif;
            color: #e5e7eb;
        }

        .header {
            background-color: #111827;
            padding: 12px 20px;
            border-bottom: 1px solid #1f2937;
        }

        .header h1 {
            margin: 0;
            font-size: 20px;
            color: #f9fafb;
        }

        .container {
            width: 420px;
            margin: 50px auto;
            background-color: #1e293b;
            padding: 25px 30px;
            border-radius: 6px;
            border: 1px solid #334155;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        h2 {
            margin-top: 0;
            font-size: 18px;
            text-align: center;
            margin-bottom: 18px;
            color: #f9fafb;
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 6px;
            color: #cbd5e1;
        }

        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #334155;
            background-color: #0f172a;
            color: #e5e7eb;
            margin-bottom: 15px;
        }

        select {
            width: 100%;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #334155;
            background-color: #0f172a;
            color: #e5e7eb;
            margin-bottom: 15px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #2563eb;
            color: #fff;
            border: none;
            font-size: 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #1d4ed8;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>Admin Panel</h1>
</div>

<div class="container">
    <h2>Add New Asset</h2>

    <form action="/admin/assets/save" method="post">

        <label for="assetName">Asset Name</label>
        <input type="text" id="assetName" name="assetName" required>

        <label for="category">Asset Type</label>
        <input type="text" id="assetType" name="assetType" required>

        <label for="serialNumber">Serial Number</label>
        <input type="text" id="serialNumber" name="serialNumber" required>


        <label for="conditionA">Condition</label>
        <select id="conditionA" name="conditionA">
            <option value="Good">Good</option>
            <option value="Moderate">Moderate</option>
            <option value="Repair Needed">Repair Needed</option>
        </select>

        <label for="statusA">Status</label>
        <select id="statusA" name="statusA">
            <option value="Available">Available</option>
            <option value="Allocated">Allocated</option>
            <option value="Under Maintenance">Under Maintenance</option>
        </select>

        <button type="submit" class="btn">Save Asset</button>
    </form>
</div>

</body>
</html>
