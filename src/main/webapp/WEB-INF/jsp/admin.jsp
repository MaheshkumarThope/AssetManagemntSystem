<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String ctx = request.getContextPath();                  // e.g., /asset-app
  String activeTab = (String) request.getAttribute("activeTab"); // optional: "home"|"users"|"assets"|"requests"
  activeTab = (activeTab == null) ? "home" : activeTab;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Admin Dashboard • Asset Management</title>
  <style>
    :root{
      --bg:#020617;
      --bg-soft:#020617;
      --card:rgba(15,23,42,0.92);
      --text:#e5e7eb;
      --sub:#9ca3af;
      --accent:#38bdf8;
      --accent2:#a855f7;
      --accent3:#22c55e;
      --line:rgba(148,163,184,0.25);
      --btn-grad:linear-gradient(135deg,#38bdf8,#6366f1);
      --btn-grad-alt:linear-gradient(135deg,#0f172a,#1f2937);
      --btn-text:#f9fafb;
      --shadow-soft:0 18px 50px rgba(15,23,42,.85);
      --radius:16px;
    }

    *{box-sizing:border-box}
    html,body{
      margin:0;
      padding:0;
      font:14px/1.5 system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;
      color:var(--text);
      background:radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
      min-height:100vh;
      position:relative;
      overflow-x:hidden;
    }

    body::before{
      content:"";
      position:fixed;
      inset:-40%;
      background:
        radial-gradient(circle at 10% 20%,rgba(56,189,248,0.13) 0,transparent 50%),
        radial-gradient(circle at 80% 0%,rgba(147,51,234,0.18) 0,transparent 55%),
        radial-gradient(circle at 70% 90%,rgba(34,197,94,0.14) 0,transparent 55%);
      opacity:0.95;
      z-index:-2;
      animation:glowShift 25s ease-in-out infinite alternate;
    }

    @keyframes glowShift{
      0%{transform:translate3d(0,0,0) scale(1);}
      50%{transform:translate3d(-40px,20px,0) scale(1.05);}
      100%{transform:translate3d(30px,-20px,0) scale(1.02);}
    }

    a{color:inherit;text-decoration:none}

    .wrap{
      max-width:1100px;
      margin:0 auto;
      padding:18px 18px 32px;
    }

    /* NAVBAR */
    .nav{
      position:sticky;
      top:0;
      z-index:20;
      backdrop-filter:blur(18px);
      background:linear-gradient(120deg,rgba(15,23,42,0.94),rgba(15,23,42,0.86));
      border-bottom:1px solid rgba(148,163,184,0.35);
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:16px;
      padding:10px 20px;
      box-shadow:0 18px 40px rgba(0,0,0,.6);
    }

    .brand{
      display:flex;
      align-items:center;
      gap:10px;
      font-weight:600;
    }

    .avatar-circle{
      width:34px;
      height:34px;
      border-radius:999px;
      background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
      padding:2px;
      display:flex;
      align-items:center;
      justify-content:center;
      box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 22px rgba(56,189,248,0.45);
      transition:transform .2s ease, box-shadow .2s ease;
    }
    .avatar-circle span{
      width:100%;
      height:100%;
      border-radius:inherit;
      display:flex;
      align-items:center;
      justify-content:center;
      background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
      font-size:18px;
    }
    .brand:hover .avatar-circle{
      transform:translateY(-1px) scale(1.05);
      box-shadow:0 0 0 1px rgba(148,163,184,.6),0 0 26px rgba(129,140,248,0.65);
    }

    .nav ul{
      list-style:none;
      display:flex;
      gap:14px;
      margin:0;
      padding:0;
    }

    .nav a.nav-link,
    .dropdown-toggle{
      padding:7px 12px;
      border-radius:999px;
      color:#e5e7eb;
      display:inline-flex;
      align-items:center;
      gap:6px;
      font-size:13px;
      border:1px solid transparent;
      background:transparent;
      transition:background .18s ease, border-color .18s ease, color .18s ease, transform .18s ease, box-shadow .18s ease;
      cursor:pointer;
    }

    .nav a.nav-link:hover,
    .dropdown-toggle:hover{
      background:rgba(15,23,42,0.85);
      border-color:rgba(148,163,184,0.55);
      transform:translateY(-1px);
      box-shadow:0 10px 24px rgba(15,23,42,0.7);
    }

    .nav a.nav-link.active,
    .dropdown-toggle.active{
      background:radial-gradient(circle at 0 0,rgba(129,140,248,0.9),rgba(56,189,248,0.25));
      border-color:rgba(129,140,248,0.8);
      color:#f9fafb;
      box-shadow:0 12px 30px rgba(79,70,229,0.55);
    }

    .nav .actions{
      display:flex;
      gap:10px;
      align-items:center;
    }

    .btn{
      border:none;
      border-radius:999px;
      padding:8px 16px;
      cursor:pointer;
      font-size:13px;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      gap:6px;
      background:var(--btn-grad);
      color:var(--btn-text);
      box-shadow:0 16px 38px rgba(56,189,248,0.5);
      transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
      white-space:nowrap;
    }
    .btn:hover{
      transform:translateY(-1px) scale(1.02);
      filter:brightness(1.06);
      box-shadow:0 20px 46px rgba(56,189,248,0.7);
    }

    .btn.alt{
      background:var(--btn-grad-alt);
      border:1px solid rgba(148,163,184,0.65);
      box-shadow:0 12px 30px rgba(15,23,42,0.9);
    }
    .btn.alt:hover{
      box-shadow:0 16px 34px rgba(15,23,42,1);
      filter:brightness(1.02);
    }

    .dropdown{
      position:relative;
    }

    .dropdown-menu{
      position:absolute;
      top:110%;
      left:0;
      min-width:190px;
      background:radial-gradient(circle at top,rgba(15,23,42,0.98),rgba(15,23,42,0.94));
      border:1px solid rgba(148,163,184,0.55);
      border-radius:14px;
      box-shadow:0 18px 40px rgba(0,0,0,.9);
      padding:6px;
      display:none;
      animation:fadeDown .18s ease-out forwards;
      transform-origin:top center;
      z-index:30;
    }

    /* show menu when dropdown has .open */
    .dropdown.open .dropdown-menu{
      display:block;
    }

    .dropdown-item{
      display:block;
      padding:8px 11px;
      border-radius:10px;
      color:#e5e7eb;
      font-size:13px;
      transition:background .15s ease, color .15s ease, transform .15s ease;
    }
    .dropdown-item:hover{
      background:linear-gradient(120deg,rgba(56,189,248,0.16),rgba(129,140,248,0.20));
      transform:translateY(-1px);
    }

    @keyframes fadeDown{
      0%{opacity:0;transform:translateY(-5px) scale(0.97);}
      100%{opacity:1;transform:translateY(0) scale(1);}
    }

    /* HERO */
    .hero{
      position:relative;
      overflow:hidden;
      border-radius:22px;
      margin:22px 0;
      padding:22px 22px 24px;
      background:linear-gradient(135deg,#1d4ed8,#7c3aed,#db2777);
      box-shadow:0 25px 60px rgba(17,24,39,0.95);
      isolation:isolate;
    }
    .hero::before,
    .hero::after{
      content:"";
      position:absolute;
      border-radius:999px;
      filter:blur(30px);
      opacity:.35;
      pointer-events:none;
      mix-blend-mode:screen;
    }
    .hero::before{
      width:220px;height:220px;
      background:#38bdf8;
      top:-40px;right:-60px;
    }
    .hero::after{
      width:260px;height:260px;
      background:#a855f7;
      bottom:-90px;left:-40px;
    }

    .hero .row{
      position:relative;
      display:flex;
      flex-wrap:wrap;
      align-items:center;
      gap:18px;
      z-index:1;
    }
    .hero .left{flex:1 1 460px}
    .hero h1{
      margin:0 0 6px 0;
      font-size:26px;
      letter-spacing:.2px;
    }
    .hero .muted{
      color:#e5e7eb;
      opacity:.88;
      font-size:13px;
    }
    .hero .right{
      display:flex;
      gap:10px;
      flex-wrap:wrap;
      justify-content:flex-start;
    }
    .hero .btn{
      box-shadow:0 14px 36px rgba(15,23,42,0.55);
    }

    /* KPI + SEARCH LAYOUT */
    .top-layout{
      display:grid;
      grid-template-columns:3fr 2fr;
      gap:16px;
      margin-top:8px;
      align-items:start;
    }

    .grid{
      display:grid;
      grid-template-columns:repeat(2,1fr);
      gap:14px;
    }

    .card{
      position:relative;
      background:radial-gradient(circle at 0 0,rgba(148,163,184,0.10),rgba(15,23,42,0.98));
      border-radius:18px;
      padding:14px 14px 16px;
      border:1px solid rgba(148,163,184,0.35);
      box-shadow:var(--shadow-soft);
      overflow:hidden;
      backdrop-filter:blur(18px);
      transform:translateY(0);
      opacity:0;
      animation:fadeUp .4s ease forwards;
    }
    .card::before{
      content:"";
      position:absolute;
      inset:-40%;
      background:radial-gradient(circle at top left,rgba(56,189,248,0.14),transparent 55%);
      opacity:0;
      transition:opacity .2s ease;
      pointer-events:none;
    }
    .card:hover::before{
      opacity:1;
    }
    .card:hover{
      transform:translateY(-4px);
      box-shadow:0 22px 50px rgba(15,23,42,0.96);
    }

    .kpi-card:nth-child(1){animation-delay:.02s}
    .kpi-card:nth-child(2){animation-delay:.06s}
    .kpi-card:nth-child(3){animation-delay:.1s}
    .kpi-card:nth-child(4){animation-delay:.14s}

    @keyframes fadeUp{
      0%{opacity:0;transform:translateY(10px);}
      100%{opacity:1;transform:translateY(0);}
    }

    .muted{color:var(--sub);font-size:12px}
    .kpi{
      font-size:1.5rem;
      font-weight:700;
      margin-top:5px;
      letter-spacing:.5px;
    }

    /* SEARCH CARD */
    .search-title{
      font-size:13px;
      font-weight:600;
      margin-bottom:6px;
    }
    .search-input-wrap{
      margin-top:6px;
      display:flex;
      gap:8px;
    }
    .search-input{
      flex:1;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.55);
      background:#020617;
      color:#e5e7eb;
      padding:7px 12px;
      font-size:13px;
      outline:none;
      box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
    }
    .search-input::placeholder{
      color:rgba(148,163,184,0.9);
    }

    /* INSIGHTS SECTION */
    .insights{
      display:grid;
      grid-template-columns:2fr 1.5fr;
      gap:16px;
      margin-top:18px;
    }
    .card-header{
      display:flex;
      align-items:center;
      justify-content:space-between;
      margin-bottom:6px;
      font-size:13px;
      font-weight:600;
    }
    .pill{
      border-radius:999px;
      padding:3px 8px;
      font-size:11px;
      background:rgba(15,23,42,0.95);
      border:1px solid rgba(148,163,184,0.6);
      color:var(--sub);
    }

    .activity-list{
      list-style:none;
      margin:6px 0 0;
      padding:0;
      font-size:12px;
    }
    .activity-list li{
      display:flex;
      justify-content:space-between;
      align-items:flex-start;
      padding:6px 0;
      border-bottom:1px dashed rgba(55,65,81,0.7);
      gap:10px;
    }
    .activity-main{
      display:flex;
      gap:6px;
      align-items:flex-start;
    }
    .bullet{
      width:7px;
      height:7px;
      border-radius:999px;
      margin-top:5px;
    }
    .bullet.green{background:#22c55e;}
    .bullet.amber{background:#f59e0b;}
    .bullet.red{background:#ef4444;}
    .activity-text{color:#e5e7eb;}
    .activity-meta{color:var(--sub);font-size:11px;white-space:nowrap;}

    .health-list{
      list-style:none;
      margin:8px 0 0;
      padding:0;
      font-size:12px;
    }
    .health-list li{
      display:flex;
      align-items:center;
      justify-content:space-between;
      padding:4px 0;
    }
    .health-label{
      display:flex;
      align-items:center;
      gap:6px;
    }
    .status-dot{
      width:9px;
      height:9px;
      border-radius:999px;
    }
    .status-dot.ok{background:#22c55e;}
    .status-dot.warn{background:#f59e0b;}
    .status-dot.err{background:#ef4444;}

    /* QUICK ACTIONS */
    .quick-actions{
      margin-top:20px;
      display:grid;
      grid-template-columns:repeat(4,1fr);
      gap:14px;
    }
    .quick-card{
      text-align:left;
      padding:12px 14px 14px;
      border-radius:16px;
      border:1px solid rgba(148,163,184,0.4);
      background:radial-gradient(circle at 0 0,rgba(99,102,241,0.22),rgba(15,23,42,0.98));
      box-shadow:var(--shadow-soft);
      font-size:12px;
      opacity:0;
      animation:fadeUp .4s ease forwards;
    }
    .quick-card:nth-child(1){animation-delay:.16s}
    .quick-card:nth-child(2){animation-delay:.2s}
    .quick-card:nth-child(3){animation-delay:.24s}
    .quick-card:nth-child(4){animation-delay:.28s}
    .quick-label{
      font-size:13px;
      font-weight:600;
      margin-bottom:4px;
    }
    .quick-desc{
      color:var(--sub);
      margin-bottom:8px;
    }
    .quick-actions .btn{
      width:100%;
      justify-content:center;
      padding:7px 0;
      font-size:12px;
    }

    /* RESPONSIVE */
    @media (max-width: 960px){
      .top-layout{
        grid-template-columns:1fr;
      }
      .grid{
        grid-template-columns:repeat(2,1fr);
      }
      .insights{
        grid-template-columns:1fr;
      }
      .quick-actions{
        grid-template-columns:repeat(2,1fr);
      }
      .nav{
        flex-wrap:wrap;
        gap:10px;
      }
      .nav ul{
        flex-wrap:wrap;
        justify-content:flex-start;
      }
    }

    @media (max-width: 640px){
      .grid{
        grid-template-columns:1fr;
      }
      .quick-actions{
        grid-template-columns:1fr;
      }
      .hero{
        padding:18px 16px 20px;
      }
    }

    .footer{
      color:var(--sub);
      text-align:center;
      margin:26px 0 6px;
      font-size:12px;
    }
  </style>
</head>
<body>

  <!-- Top Nav -->
  <nav class="nav">
    <!-- Profile / brand -->
    <div class="brand dropdown">
      <a class="dropdown-toggle" href="javascript:void(0)">
        <div class="avatar-circle"><span>👤</span></div>
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="<%=ctx%>/admin/profile">View Profile</a>
        <a class="dropdown-item" href="<%=ctx%>/admin/changePassword" target="_blank">Change password</a>
      </div>
    </div>

    <ul>
      <!-- Manage Users dropdown -->
      <li class="dropdown">
        <a class="dropdown-toggle <%= "users".equals(activeTab) ? "active" : "" %>" href="javascript:void(0)">Manage Users ▾</a>
        <div class="dropdown-menu">
          <!-- keep original functionality -->
          <a class="dropdown-item" href="/adminLogin/viewUsers" target="_blank">View Users</a>
          <a class="dropdown-item" href="/admin/adduser" target="_blank">Add User</a>
        </div>
      </li>

      <!-- Manage Assets dropdown -->
      <li class="dropdown">
        <a class="dropdown-toggle <%= "assets".equals(activeTab) ? "active" : "" %>" href="javascript:void(0)">Manage Assets ▾</a>
        <div class="dropdown-menu">
          <!-- keep original functionality -->
          <a class="dropdown-item" href="/admin/assets/view" target="_blank">View Assets</a>
          <a class="dropdown-item" href="/admin/assets/add" target="_blank">Add Asset</a>
          <a class="dropdown-item" href="/admin/assets/allocate" target="_blank">Allocate Asset</a>
        </div>
      </li>

      <!-- Manage Requests dropdown -->
      <li class="dropdown">
        <a class="dropdown-toggle <%= "requests".equals(activeTab) ? "active" : "" %>" href="javascript:void(0)">Manage Requests ▾</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/admin/requests" target="_blank">View Requests</a>
        </div>
      </li>
    </ul>

    <div class="actions">

      <a class="btn" href="<%=ctx%>/logout">Logout</a>
    </div>
  </nav>

  <div class="wrap">

    <!-- Welcome / Hero -->
    <section class="hero">
      <div class="row">
        <div class="left">
          <h1>Welcome ${sessionScope.userName}</h1>
          <div class="muted">
            Get a quick overview of your users, assets, allocations and requests – and jump into actions in one click.
          </div>
        </div>
        <div class="right">
          <!-- same functionality as before -->
          <a class="btn alt" href="<%=ctx%>/admin/users">View Users</a>
          <a class="btn" href="<%=ctx%>/admin/assets">Manage Assets</a>
        </div>
      </div>
    </section>

    <!-- KPIs + Search -->
    <div class="top-layout">
      <!-- KPIs -->
      <section class="grid">
        <div class="card kpi-card">
          <div class="muted">Total Users</div>
          <div class="kpi"><%= request.getAttribute("kpiUsers") != null ? request.getAttribute("kpiUsers") : 0 %></div>
        </div>
        <div class="card kpi-card">
          <div class="muted">Total Assets</div>
          <div class="kpi"><%= request.getAttribute("kpiAssets") != null ? request.getAttribute("kpiAssets") : 0 %></div>
        </div>
        <div class="card kpi-card">
          <div class="muted">Active Allocations</div>
          <div class="kpi"><%= request.getAttribute("kpiAllocations") != null ? request.getAttribute("kpiAllocations") : 2 %></div>
        </div>
        <div class="card kpi-card">
          <div class="muted">Pending Requests</div>
          <div class="kpi"><%= request.getAttribute("kpiRequests") != null ? request.getAttribute("kpiRequests") : 8 %></div>
        </div>
      </section>

      <!-- Global Search card (visual only – you can wire it later) -->
      <section class="card">
        <div class="card-header">
          <span>Quick Search</span>
          <span class="pill">Search users, assets, requests</span>
        </div>
        <div class="muted">
          Type a name, asset ID, or request ID to quickly locate records.
        </div>
        <div class="search-input-wrap">
          <input class="search-input" type="text" placeholder="e.g. John Doe, LAP-1023, REQ-0091" />
          <!-- This button can later submit to a search endpoint -->
          <button class="btn alt" type="button">Search</button>
        </div>
      </section>
    </div>

    <!-- Insights row -->
    <section class="insights">
      <!-- Recent Activity -->
      <div class="card">
        <div class="card-header">
          <span>Recent Activity</span>
          <span class="pill">Last 24 hours</span>
        </div>
        <ul class="activity-list">
          <!-- These are placeholders; you can replace with real logs -->
          <li>
            <div class="activity-main">
              <span class="bullet green"></span>
              <div>
                <div class="activity-text">Asset <strong>LAP-1042</strong> allocated to <strong>John Doe</strong>.</div>
                <div class="activity-meta">5 min ago • via Admin Panel</div>
              </div>
            </div>
          </li>
          <li>
            <div class="activity-main">
              <span class="bullet amber"></span>
              <div>
                <div class="activity-text">New user <strong>Sarah Parker</strong> created.</div>
                <div class="activity-meta">32 min ago • HR upload</div>
              </div>
            </div>
          </li>
          <li>
            <div class="activity-main">
              <span class="bullet red"></span>
              <div>
                <div class="activity-text">Request <strong>REQ-0089</strong> marked as <strong>Rejected</strong>.</div>
                <div class="activity-meta">1 hr ago • Pending hardware</div>
              </div>
            </div>
          </li>
          <li>
            <div class="activity-main">
              <span class="bullet green"></span>
              <div>
                <div class="activity-text">3 assets returned and moved to available pool.</div>
                <div class="activity-meta">2 hrs ago • Auto-sync</div>
              </div>
            </div>
          </li>
        </ul>
      </div>

      <!-- System Health / Requests Highlight -->
      <div class="card">
        <div class="card-header">
          <span>System & Requests</span>
          <span class="pill">Status overview</span>
        </div>
        <ul class="health-list">
          <li>
            <div class="health-label">
              <span class="status-dot ok"></span>
              <span>Application status</span>
            </div>
            <span class="activity-meta">Online</span>
          </li>
          <li>
            <div class="health-label">
              <span class="status-dot ok"></span>
              <span>Database connection</span>
            </div>
            <span class="activity-meta">Healthy</span>
          </li>
          <li>
            <div class="health-label">
              <span class="status-dot warn"></span>
              <span>Pending requests</span>
            </div>
            <span class="activity-meta">
              <%= request.getAttribute("kpiRequests") != null ? request.getAttribute("kpiRequests") : 8 %> awaiting review
            </span>
          </li>
          <li>
            <div class="health-label">
              <span class="status-dot ok"></span>
              <span>Allocations nearing end-date</span>
            </div>
            <span class="activity-meta">3 due this week</span>
          </li>
        </ul>
        <div style="margin-top:12px;">
          <!-- same requests functionality, just surfaced nicely -->
          <a href="<%=ctx%>/admin/requests" class="btn" style="width:100%;justify-content:center;">Review Requests</a>
        </div>
      </div>
    </section>



    <div class="footer">
      © <script>document.write(new Date().getFullYear())</script> Asset Management • Admin Portal
    </div>
  </div>

  <script>
    // Click-to-open dropdowns: profile + Manage Users + Manage Assets + Manage Requests
    document.addEventListener('DOMContentLoaded', function () {
      const dropdowns = document.querySelectorAll('.dropdown');

      dropdowns.forEach(function (dd) {
        const toggle = dd.querySelector('.dropdown-toggle');
        if (!toggle) return;

        toggle.addEventListener('click', function (e) {
          e.preventDefault();
          e.stopPropagation();

          // Close all other dropdowns
          dropdowns.forEach(d2 => {
            if (d2 !== dd) d2.classList.remove('open');
          });

          // Toggle this one
          dd.classList.toggle('open');
        });
      });

      // Close all when clicking outside
      document.addEventListener('click', function () {
        dropdowns.forEach(d => d.classList.remove('open'));
      });
    });
  </script>
</body>
</html>
