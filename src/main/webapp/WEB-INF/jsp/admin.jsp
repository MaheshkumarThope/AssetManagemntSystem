<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String ctx = request.getContextPath();                  // e.g., /asset-app
  String activeTab = (String) request.getAttribute("activeTab"); // optional: "home"|"users"|"assets"|"addUser"
  activeTab = (activeTab == null) ? "home" : activeTab;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Admin Dashboard • Asset Management</title>
  <style>
    :root{
      --bg:#f6f7fb; --card:#ffffff; --text:#1f2937; --sub:#6b7280; --brand:#0d6efd;
      --line:#e5e7eb; --btn:#0d6efd; --btn-text:#fff; --btn-alt:#f3f4f6; --shadow:0 6px 20px rgba(0,0,0,.06);
      --radius:14px;
    }
    *{box-sizing:border-box}
    html,body{margin:0;padding:0;background:var(--bg);color:var(--text);font:14px/1.5 system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif}
    a{color:inherit;text-decoration:none}
    .wrap{max-width:1100px;margin:0 auto;padding:18px}

    /* NAVBAR */
    .nav{
      position:sticky;top:0;background:#fff;border-bottom:1px solid var(--line);
      display:flex;align-items:center;justify-content:space-between;gap:16px;padding:12px 18px;z-index:10;
    }
    .brand{font-weight:700;letter-spacing:.2px}
    .nav ul{list-style:none;display:flex;gap:16px;margin:0;padding:0}
    .nav a.nav-link{padding:8px 12px;border-radius:10px;color:#374151}
    .nav a.nav-link.active{background:var(--btn-alt);font-weight:600}
    .nav .actions{display:flex;gap:10px}
    .btn{background:var(--btn);color:var(--btn-text);border:none;border-radius:10px;padding:9px 14px;cursor:pointer}
    .btn.alt{background:var(--btn-alt);color:#111827}

    /* HERO */
    .hero{
      background:linear-gradient(135deg,#0d6efd 0%,#4f8cff 100%);color:#fff;border-radius:var(--radius);
      padding:24px;margin:20px 0;
    }
    .hero .row{display:flex;flex-wrap:wrap;align-items:center;gap:16px}
    .hero .left{flex:1 1 480px}
    .hero .right{display:flex;gap:10px}

    /* GRID CARDS */
    .grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}
    .card{background:var(--card);border-radius:var(--radius);box-shadow:var(--shadow);padding:16px}
    .muted{color:var(--sub)}
    .kpi{font-size:1.25rem;font-weight:700}

    /* PANELS */
    .panels{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-top:14px}
    .panel .title{font-weight:600;margin-bottom:6px}

    /* RESPONSIVE */
    @media (max-width: 960px){
      .grid{grid-template-columns:repeat(2,1fr)}
      .panels{grid-template-columns:1fr}
      .hero .right{width:100%;justify-content:flex-start;flex-wrap:wrap}
    }
    @media (max-width: 560px){
      .grid{grid-template-columns:1fr}
    }

    .footer{color:var(--sub);text-align:center;margin:22px 0}
  </style>
</head>
<body>

  <!-- Top Nav -->
  <nav class="nav">
    <div class="brand"><a href="<%=ctx%>/admin/home">Asset Admin</a></div>
    <ul>
      <li><a class="nav-link <%= "users".equals(activeTab) ? "active" : "" %>"  href="/adminLogin/viewUsers">View Users</a></li>
      <li><a class="nav-link <%= "assets".equals(activeTab) ? "active" : "" %>" href="<%=ctx%>/admin/assets">Manage Assets</a></li>
      <li><a class="nav-link <%= "addUser".equals(activeTab) ? "active" : "" %>" href="<%=ctx%>/admin/users/new">Add User</a></li>
    </ul>
    <div class="actions">
      <a class="btn alt" href="<%=ctx%>/admin/requests">Requests</a>
      <a class="btn" href="<%=ctx%>/logout">Logout</a>
    </div>
  </nav>

  <div class="wrap">

    <!-- Welcome / Hero -->
    <section class="hero">
      <div class="row">
        <div class="left">
          <h1 style="margin:0 0 6px 0;">Welcome, Admin</h1>
          <div class="muted">Manage users, assets, allocations, and requests from a single place.</div>
        </div>
        <div class="right">
          <a class="btn alt" href="<%=ctx%>/admin/users">View Users</a>
          <a class="btn" href="<%=ctx%>/admin/assets">Manage Assets</a>
        </div>
      </div>
    </section>

    <!-- KPIs (bind real counts in controller; these fallbacks show if null) -->
    <section class="grid">
      <div class="card">
        <div class="muted">Total Users</div>
        <div class="kpi"><%= request.getAttribute("kpiUsers") != null ? request.getAttribute("kpiUsers") : 10 %></div>
      </div>
      <div class="card">
        <div class="muted">Assets</div>
        <div class="kpi"><%= request.getAttribute("kpiAssets") != null ? request.getAttribute("kpiAssets") : 10 %></div>
      </div>
      <div class="card">
        <div class="muted">Active Allocations</div>
        <div class="kpi"><%= request.getAttribute("kpiAllocations") != null ? request.getAttribute("kpiAllocations") : 2 %></div>
      </div>
      <div class="card">
        <div class="muted">Pending Requests</div>
        <div class="kpi"><%= request.getAttribute("kpiRequests") != null ? request.getAttribute("kpiRequests") : 8 %></div>
      </div>
    </section>

    <!-- Quick Panels -->
    <section class="panels">
      <div class="card panel">
        <div class="title">Users</div>
        <div class="muted">Search, view and manage employee records.</div>
        <div style="margin-top:10px; display:flex; gap:10px;">
          <a href="<%=ctx%>/admin/users" class="btn" style="flex:1;">View Users</a>
          <a href="<%=ctx%>/admin/users/new" class="btn alt" style="flex:1;">Add User</a>
        </div>
      </div>

      <div class="card panel">
        <div class="title">Assets</div>
        <div class="muted">Track inventory, status and allocations.</div>
        <div style="margin-top:10px; display:flex; gap:10px;">
          <a href="<%=ctx%>/admin/assets" class="btn" style="flex:1;">Manage Assets</a>
          <a href="<%=ctx%>/admin/allocations" class="btn alt" style="flex:1;">Allocations</a>
        </div>
      </div>

      <div class="card panel">
        <div class="title">Requests</div>
        <div class="muted">Review and approve user requests.</div>
        <div style="margin-top:10px; display:flex; gap:10px;">
          <a href="<%=ctx%>/admin/requests" class="btn" style="flex:1;">View Requests</a>
          <a href="<%=ctx%>/admin/reports" class="btn alt" style="flex:1;">Reports</a>
        </div>
      </div>
    </section>

    <div class="footer">© <script>document.write(new Date().getFullYear())</script> Asset Management • Admin Portal</div>
  </div>

  <script>
    // Optional: force open in a new tab for specific links
    // Toggle this to true if you want new tabs temporarily.
    const FORCE_NEW_TAB = false;

    if (FORCE_NEW_TAB) {
      document.querySelectorAll('.nav a.nav-link, .btn, a.btn').forEach(a=>{
        // Only make internal links new-tab; skip logout if you want
        const href = a.getAttribute('href') || '';
        if (href && href.startsWith('<%=ctx%>/') && !href.endsWith('/logout')) {
          a.setAttribute('target','_blank');
          a.setAttribute('rel','noopener');
        }
      });
    }
  </script>
</body>
</html>
