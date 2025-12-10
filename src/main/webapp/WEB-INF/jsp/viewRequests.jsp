<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Requests</title>
  <style>
    :root{
      --bg:#020617;
      --card:rgba(15,23,42,0.96);
      --card-soft:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),rgba(15,23,42,0.98));
      --text:#e5e7eb;
      --sub:#9ca3af;
      --accent:#38bdf8;
      --accent2:#a855f7;
      --accent3:#22c55e;
      --line:rgba(148,163,184,0.35);
      --shadow-soft:0 18px 50px rgba(15,23,42,.9);
      --radius:18px;
    }

    *{ box-sizing:border-box; }

    html,body{
      margin:0;
      padding:0;
      font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;
      color:var(--text);
      min-height:100vh;
    }

    body{
      background:radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
      position:relative;
      overflow-x:hidden;
    }

    body::before{
      content:"";
      position:fixed;
      inset:-40%;
      background:
        radial-gradient(circle at 10% 20%,rgba(56,189,248,0.18) 0,transparent 55%),
        radial-gradient(circle at 80% 0%,rgba(147,51,234,0.22) 0,transparent 60%),
        radial-gradient(circle at 70% 90%,rgba(34,197,94,0.18) 0,transparent 60%);
      opacity:0.95;
      z-index:-2;
      animation:glowShift 26s ease-in-out infinite alternate;
    }

    @keyframes glowShift{
      0%{transform:translate3d(0,0,0) scale(1);}
      50%{transform:translate3d(-40px,20px,0) scale(1.05);}
      100%{transform:translate3d(30px,-20px,0) scale(1.02);}
    }

    a{ color:inherit; text-decoration:none; }

    .wrap{
      max-width:1000px;
      margin:0 auto;
      padding:22px 18px 32px;
    }

    .page-header{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin-bottom:16px;
    }

    .title-block{
      display:flex;
      align-items:center;
      gap:10px;
    }

    .title-pill{
      width:34px;
      height:34px;
      border-radius:999px;
      background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
      padding:2px;
      display:flex;
      align-items:center;
      justify-content:center;
      box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 20px rgba(56,189,248,0.6);
    }

    .title-pill span{
      width:100%;
      height:100%;
      border-radius:inherit;
      display:flex;
      align-items:center;
      justify-content:center;
      background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
      font-size:18px;
    }

    .title-text{
      display:flex;
      flex-direction:column;
      gap:2px;
    }

    .title-main{
      font-size:18px;
      font-weight:600;
    }

    .title-sub{
      font-size:11px;
      color:var(--sub);
    }

    .page-header a.btn-back{
      border-radius:999px;
      padding:7px 13px;
      font-size:12px;
      border:1px solid rgba(148,163,184,0.6);
      background:linear-gradient(135deg,#0b1120,#020617);
      color:#e5e7eb;
      box-shadow:0 14px 30px rgba(15,23,42,0.9);
      transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
    }
    .page-header a.btn-back:hover{
      transform:translateY(-1px);
      filter:brightness(1.05);
      box-shadow:0 18px 40px rgba(15,23,42,1);
    }

    .card{
      background:var(--card-soft);
      border-radius:var(--radius);
      border:1px solid var(--line);
      box-shadow:var(--shadow-soft);
      backdrop-filter:blur(18px);
      padding:16px 16px 14px;
      overflow:hidden;
    }

    .card-header{
      display:flex;
      align-items:center;
      justify-content:space-between;
      margin-bottom:10px;
    }

    .card-header h2{
      margin:0;
      font-size:15px;
      font-weight:600;
    }

    .card-header .meta{
      font-size:11px;
      color:var(--sub);
    }

    .table-wrap{
      border-radius:12px;
      border:1px solid rgba(55,65,81,0.9);
      overflow:hidden;
      background:radial-gradient(circle at 0 0,rgba(15,23,42,0.92),rgba(15,23,42,0.99));
      max-height:520px;
      overflow-y:auto;
      margin-top:4px;
    }

    table{
      width:100%;
      border-collapse:collapse;
      font-size:12px;
    }

    thead{
      background:rgba(15,23,42,1);
    }

    th,td{
      padding:8px 10px;
      text-align:left;
      border-bottom:1px solid rgba(31,41,55,0.95);
      white-space:nowrap;
    }

    th{
      font-weight:600;
      color:#e5e7eb;
    }

    tbody tr:nth-child(even){
      background:rgba(15,23,42,0.88);
    }

    tbody tr:hover{
      background:rgba(30,64,175,0.6);
    }

    .status-badge{
      display:inline-block;
      padding:2px 8px;
      border-radius:999px;
      font-size:11px;
      border:1px solid rgba(148,163,184,0.7);
    }

    .status-pending{
      background:rgba(245,158,11,0.18);
      border-color:rgba(245,158,11,0.8);
      color:#fed7aa;
    }
    .status-approved{
      background:rgba(34,197,94,0.18);
      border-color:rgba(34,197,94,0.8);
      color:#bbf7d0;
    }
    .status-rejected{
      background:rgba(248,113,113,0.18);
      border-color:rgba(248,113,113,0.85);
      color:#fecaca;
    }
    .status-completed{
      background:rgba(59,130,246,0.18);
      border-color:rgba(59,130,246,0.85);
      color:#bfdbfe;
    }

    .empty-state{
      padding:10px;
      font-size:12px;
      color:var(--sub);
      text-align:center;
    }

    .footer{
      text-align:center;
      margin:20px 0 6px;
      font-size:11px;
      color:var(--sub);
    }
  </style>
</head>
<body>
<div class="wrap">

  <!-- Page header -->
  <div class="page-header">
    <div class="title-block">
      <div class="title-pill"><span>📄</span></div>
      <div class="title-text">
        <div class="title-main">Asset Requests</div>
        <div class="title-sub">
          Overview of
          <c:choose>
            <c:when test="${sessionScope.role == 'ADMIN'}">all requests</c:when>
            <c:otherwise>your requests</c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

  </div>

  <!-- Card with table -->
  <div class="card">
    <div class="card-header">
      <h2>Request List</h2>
      <div class="meta">
        Showing <strong>${requests.size()}</strong> requests
      </div>
    </div>

    <div class="table-wrap">
      <c:if test="${empty requests}">
        <div class="empty-state">
          There are no requests to display right now.
        </div>
      </c:if>

      <c:if test="${not empty requests}">
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>User</th>
            <th>Asset</th>
            <th>Status</th>
            <th>Date</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="req" items="${requests}">
            <tr>
              <td>${req.requestId}</td>
              <td>${req.user.fullName}</td>
              <td>${req.assetName}</td>
              <td>
                <c:choose>
                  <c:when test="${req.statusH == 'Pending'}">
                    <span class="status-badge status-pending">${req.statusH}</span>
                  </c:when>
                  <c:when test="${req.statusH == 'Approved'}">
                    <span class="status-badge status-approved">${req.statusH}</span>
                  </c:when>
                  <c:when test="${req.statusH == 'Rejected'}">
                    <span class="status-badge status-rejected">${req.statusH}</span>
                  </c:when>
                  <c:when test="${req.statusH == 'Completed'}">
                    <span class="status-badge status-completed">${req.statusH}</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status-badge">${req.statusH}</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>${req.requestDate}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>
  </div>

  <div class="footer">
    © 2025 Asset Tracking System • Requests View
  </div>
</div>
</body>
</html>
