<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Assets</title>

<style>
:root{
  --bg:#020617;
  --card:rgba(15,23,42,0.96);
  --text:#e5e7eb;
  --sub:#9ca3af;
  --accent:#38bdf8;
  --accent2:#a855f7;
  --accent3:#22c55e;
  --line:rgba(148,163,184,0.35);
  --btn-grad:linear-gradient(135deg,#38bdf8,#6366f1);
  --btn-text:#f9fafb;
  --shadow-soft:0 18px 50px rgba(15,23,42,.9);
  --radius:18px;
}

*{box-sizing:border-box;}

html,body{
  margin:0;
  padding:0;
  font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;
  color:var(--text);
  min-height:100vh;
}

body{
  background:radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
  padding:20px 16px 40px;
  position:relative;
  overflow-x:auto;
}

body::before{
  content:"";
  position:fixed;
  inset:-35%;
  background:
    radial-gradient(circle at 10% 20%,rgba(56,189,248,0.22),transparent 55%),
    radial-gradient(circle at 80% 0%,rgba(147,51,234,0.24),transparent 60%),
    radial-gradient(circle at 70% 90%,rgba(34,197,94,0.2),transparent 60%);
  opacity:0.95;
  animation:glowShift 26s ease-in-out infinite alternate;
  z-index:-1;
}

@keyframes glowShift{
  0%{transform:translate3d(0,0,0) scale(1);}
  50%{transform:translate3d(-40px,20px,0) scale(1.05);}
  100%{transform:translate3d(30px,-20px,0) scale(1.02);}
}

.page-wrap{
  max-width:1100px;
  margin:auto;
}

.title-area{
  text-align:center;
  margin-bottom:20px;
}

h2{
  margin:0;
  font-size:24px;
}

.subtitle{
  font-size:12px;
  color:var(--sub);
  margin-top:6px;
}

.search-card{
  background:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),var(--card));
  padding:16px;
  border-radius:var(--radius);
  border:1px solid var(--line);
  box-shadow:var(--shadow-soft);
  backdrop-filter:blur(18px);
  margin-bottom:20px;
}

.search-row{
  display:flex;
  flex-wrap:wrap;
  gap:12px;
}

input{
  flex:1;
  min-width:240px;
  padding:9px 12px;
  border-radius:999px;
  border:1px solid rgba(148,163,184,0.6);
  background:#020617;
  color:#e5e7eb;
  font-size:13px;
  outline:none;
  transition:all .15s ease;
  box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
}

input::placeholder{
  color:rgba(148,163,184,0.85);
}

input:focus{
  border-color:rgba(56,189,248,0.9);
  box-shadow:0 0 0 1px rgba(56,189,248,0.8),
              0 0 22px rgba(37,99,235,0.5);
  transform:translateY(-1px);
}

button{
  padding:10px 16px;
  border:none;
  border-radius:999px;
  font-size:13px;
  font-weight:500;
  background:var(--btn-grad);
  color:var(--btn-text);
  cursor:pointer;
  box-shadow:0 18px 38px rgba(56,189,248,0.7);
  transition:all .18s ease;
  white-space:nowrap;
}

button:hover{
  transform:translateY(-1px) scale(1.02);
  filter:brightness(1.06);
  box-shadow:0 22px 48px rgba(56,189,248,0.9);
}

.table-card{
  background:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),var(--card));
  padding:14px;
  border-radius:var(--radius);
  border:1px solid var(--line);
  box-shadow:var(--shadow-soft);
  backdrop-filter:blur(18px);
}

.table-inner{
  max-height:540px;
  overflow:auto;
}

table{
  width:100%;
  border-collapse:collapse;
  font-size:13px;
}

thead{
  position:sticky;
  top:0;
}

th{
  background:linear-gradient(135deg,#0f172a,#1e293b);
  color:#e2e8f0;
  padding:10px;
  font-weight:600;
}

tbody tr{
  background:rgba(15,23,42,0.92);
  transition:background .15s ease, transform .15s ease;
}

tbody tr:nth-child(even){
  background:rgba(15,23,42,0.97);
}

tbody tr:hover{
  background:radial-gradient(circle at 0 0,rgba(56,189,248,0.12),rgba(15,23,42,0.98));
  transform:translateY(-1px);
}

td{
  padding:10px;
  border-bottom:1px solid rgba(31,41,55,0.8);
}

/* status + condition pills */
.pill{
  display:inline-block;
  padding:4px 10px;
  border-radius:999px;
  font-size:11px;
  font-weight:600;
  border:1px solid rgba(148,163,184,0.4);
}

.pill.available{ background:rgba(34,197,94,0.18); color:#bbf7d0; border-color:rgba(34,197,94,0.45); }
.pill.allocated{ background:rgba(56,189,248,0.18); color:#bae6fd; border-color:rgba(56,189,248,0.45); }
.pill.repair{ background:rgba(244,114,182,0.18); color:#fbcfe8; border-color:rgba(236,72,153,0.45); }

.pill.good{ background:rgba(34,197,94,0.15); color:#86efac; }
.pill.fair{ background:rgba(245,158,11,0.15); color:#fcd34d; }
.pill.poor{ background:rgba(239,68,68,0.15); color:#fecaca; }

.back{
  display:block;
  text-align:center;
  font-size:13px;
  margin-top:18px;
  color:var(--sub);
  text-decoration:none;
  transition:color .15s ease;
}

.back:hover{
  color:#e5e7eb;
}

/* responsive */
@media(max-width:720px){
  .search-row{flex-direction:column;}
  button{width:100%;}
}
</style>

</head>
<body>

<div class="page-wrap">

  <div class="title-area">
    <h2>Asset Inventory</h2>
    <div class="subtitle">Search, track and view all assets in your system</div>
  </div>

  <!-- Search Section -->
  <div class="search-card">
    <form method="get" action="/admin/assets/view">
      <div class="search-row">
        <input name="q" placeholder="Search by name or serial number" value="${q}">
        <button type="submit">Search</button>
      </div>
    </form>
  </div>

  <!-- Table -->
  <div class="table-card">
    <div class="table-inner">
      <table>
        <thead>
          <tr>
            <th>Asset Name</th>
            <th>Type</th>
            <th>Serial Number</th>
            <th>Condition</th>
            <th>Status</th>
            <th>Assigned To</th>
            <th>Return Asset</th>
          </tr>
        </thead>

        <tbody id="asset-body">
          <c:forEach var="a" items="${assets}">
            <tr>
              <td>${a.assetName}</td>
              <td>${a.assetType}</td>
              <td>${a.serialNumber}</td>
              
              <td>
                <span class="pill 
                  ${a.conditionA == 'Good' ? 'good' : ''}
                  ${a.conditionA == 'Fair' ? 'fair' : ''}
                  ${a.conditionA == 'Poor' ? 'poor' : ''}">
                  ${a.conditionA}
                </span>
              </td>

              <td>
                <span class="pill 
                  ${a.statusA == 'Available' ? 'available' : ''}
                  ${a.statusA == 'Allocated' ? 'allocated' : ''}
                  ${a.statusA == 'Under Repair' ? 'repair' : ''}">
                  ${a.statusA}
                </span>
              </td>

              <td>${a.allocatedUserName}</td>
              
               <td>
                    <form action="/admin/assets/return/${a.assetId}" method="post">
                        <button type="submit"
                                style="background-color:red; 
                                       color:white; 
                                       border:none; 
                                       padding:6px 12px; 
                                       border-radius:4px; 
                                       cursor:pointer;">
                            Return
                        </button>
                    </form>
                </td>
              
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <a href="/admin/home" class="back">← Back to Dashboard</a>

</div>

</body>
</html>
