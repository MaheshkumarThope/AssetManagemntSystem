<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Dashboard</title>
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
      --btn-grad:linear-gradient(135deg,#38bdf8,#6366f1);
      --btn-grad-green:linear-gradient(135deg,#22c55e,#16a34a);
      --btn-grad-amber:linear-gradient(135deg,#f97316,#eab308);
      --btn-text:#f9fafb;
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
      max-width:1100px;
      margin:0 auto;
      padding:16px 18px 32px;
    }

    /* NAVBAR */
    .nav{
      position:sticky;
      top:0;
      z-index:20;
      backdrop-filter:blur(18px);
      background:linear-gradient(120deg,rgba(15,23,42,0.95),rgba(15,23,42,0.9));
      border-bottom:1px solid rgba(148,163,184,0.35);
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:16px;
      padding:10px 20px;
      box-shadow:0 18px 40px rgba(0,0,0,.7);
    }

    .brand{
      display:flex;
      align-items:center;
      gap:10px;
    }

    .brand-mark{
      width:34px;
      height:34px;
      border-radius:999px;
      background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
      padding:2px;
      display:flex;
      align-items:center;
      justify-content:center;
      box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 20px rgba(56,189,248,0.5);
    }

    .brand-mark span{
      width:100%;
      height:100%;
      border-radius:inherit;
      display:flex;
      align-items:center;
      justify-content:center;
      background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
      font-size:18px;
    }

    .brand-text{
      display:flex;
      flex-direction:column;
    }

    .brand-title{
      font-size:15px;
      font-weight:600;
    }

    .brand-sub{
      font-size:11px;
      color:var(--sub);
    }

    .nav-links{
      display:flex;
      gap:8px;
      flex-wrap:wrap;
      justify-content:center;
      flex:1;
    }

    .nav-link{
      padding:7px 12px;
      border-radius:999px;
      font-size:13px;
      color:#e5e7eb;
      border:1px solid transparent;
      background:transparent;
      transition:background .18s ease, border-color .18s ease, color .18s ease, transform .18s ease, box-shadow .18s ease;
    }

    .nav-link:hover{
      background:rgba(15,23,42,0.9);
      border-color:rgba(148,163,184,0.65);
      transform:translateY(-1px);
      box-shadow:0 10px 24px rgba(15,23,42,0.9);
    }

    .nav-link.primary{
      background:radial-gradient(circle at 0 0,rgba(129,140,248,0.9),rgba(56,189,248,0.3));
      border-color:rgba(129,140,248,0.9);
      box-shadow:0 12px 30px rgba(79,70,229,0.7);
    }

    .nav-right{
      display:flex;
      align-items:center;
      gap:10px;
      font-size:13px;
      color:var(--sub);
    }

    /* Profile dropdown (like admin) */
    .dropdown{
      position:relative;
    }

    .profile-toggle{
      border:none;
      background:transparent;
      display:flex;
      align-items:center;
      gap:8px;
      cursor:pointer;
      color:#e5e7eb;
      padding:4px 6px;
      border-radius:999px;
      transition:background .18s ease, box-shadow .18s ease, transform .18s ease;
    }

    .profile-toggle:hover{
      background:rgba(15,23,42,0.9);
      box-shadow:0 10px 24px rgba(15,23,42,0.9);
      transform:translateY(-1px);
    }

    .profile-avatar{
      width:30px;
      height:30px;
      border-radius:999px;
      background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
      padding:2px;
      display:flex;
      align-items:center;
      justify-content:center;
      box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 18px rgba(56,189,248,0.45);
    }

    .profile-avatar span{
      width:100%;
      height:100%;
      border-radius:inherit;
      display:flex;
      align-items:center;
      justify-content:center;
      background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
      font-size:16px;
    }

    .profile-meta{
      display:flex;
      flex-direction:column;
      align-items:flex-start;
    }
    .profile-name{
      font-size:12px;
      font-weight:600;
      color:#e5e7eb;
    }
    .profile-email{
      font-size:10px;
      color:var(--sub);
    }

    .dropdown-menu{
      position:absolute;
      top:115%;
      right:0;
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
      margin:22px 0 18px;
      padding:22px 22px 24px;
      background:linear-gradient(135deg,#1d4ed8,#7c3aed,#06b6d4);
      box-shadow:0 25px 60px rgba(17,24,39,0.98);
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
      top:-50px;right:-80px;
    }
    .hero::after{
      width:260px;height:260px;
      background:#a855f7;
      bottom:-100px;left:-40px;
    }
    
        .nav .actions{
      display:flex;
      gap:10px;
      align-items:center;
    }

    .hero-row{
      position:relative;
      display:flex;
      flex-wrap:wrap;
      align-items:center;
      justify-content:space-between;
      gap:16px;
      z-index:1;
    }

    .hero-left{
      flex:1 1 420px;
    }

    .hero h1{
      margin:0 0 6px;
      font-size:24px;
      letter-spacing:.2px;
    }

    .hero-sub{
      font-size:13px;
      color:#e5e7eb;
      opacity:.9;
      max-width:440px;
    }

    .hero-right{
      display:flex;
      flex-wrap:wrap;
      gap:10px;
      justify-content:flex-start;
    }

    .btn-hero{
      border:none;
      border-radius:999px;
      padding:8px 16px;
      font-size:13px;
      cursor:pointer;
      color:var(--btn-text);
      background:var(--btn-grad);
      box-shadow:0 16px 36px rgba(15,23,42,0.7);
      display:inline-flex;
      align-items:center;
      gap:6px;
      text-decoration:none;
      transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
    }

    .btn-hero.secondary{
      background:linear-gradient(135deg,#0f172a,#020617);
      border:1px solid rgba(148,163,184,0.7);
      color:#e5e7eb;
    }

    .btn-hero:hover{
      transform:translateY(-1px) scale(1.02);
      filter:brightness(1.05);
      box-shadow:0 20px 44px rgba(15,23,42,0.95);
    }

    /* MAIN LAYOUT */
    .main-grid{
      display:block;
      margin-top:4px;
    }

    .cards-grid{
      display:grid;
      grid-template-columns:repeat(3,1fr);
      gap:14px;
    }

    .card{
      position:relative;
      background:var(--card-soft);
      border-radius:var(--radius);
      padding:14px 14px 16px;
      border:1px solid var(--line);
      box-shadow:var(--shadow-soft);
      backdrop-filter:blur(18px);
      overflow:hidden;
      transform:translateY(0);
      opacity:0;
      animation:fadeUp .4s ease forwards;
    }

    .card::before{
      content:"";
      position:absolute;
      inset:-40%;
      background:radial-gradient(circle at top left,rgba(56,189,248,0.18),transparent 55%);
      opacity:0;
      transition:opacity .2s ease;
      pointer-events:none;
    }

    .card:hover::before{
      opacity:1;
    }
    .card:hover{
      transform:translateY(-3px);
      box-shadow:0 22px 50px rgba(15,23,42,0.97);
    }

    .card:nth-child(1){animation-delay:.02s}
    .card:nth-child(2){animation-delay:.06s}
    .card:nth-child(3){animation-delay:.1s}

    @keyframes fadeUp{
      0%{opacity:0;transform:translateY(10px);}
      100%{opacity:1;transform:translateY(0);}
    }

    .card-title{
      font-size:15px;
      margin:0 0 4px;
      font-weight:600;
    }

    .card-text{
      font-size:12px;
      color:var(--sub);
      margin:0 0 10px;
    }

    .btn-card{
      display:inline-block;
      width:100%;
      border-radius:999px;
      border:none;
      padding:7px 0;
      font-size:13px;
      cursor:pointer;
      color:var(--btn-text);
      text-align:center;
      text-decoration:none;
      box-shadow:0 14px 30px rgba(15,23,42,0.8);
      transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
    }
    .btn-card.primary{ background:var(--btn-grad); }
    .btn-card.green{ background:var(--btn-grad-green); }
    .btn-card.amber{ background:var(--btn-grad-amber); }

    .btn-card:hover{
      transform:translateY(-1px) scale(1.02);
      filter:brightness(1.05);
      box-shadow:0 18px 40px rgba(15,23,42,0.95);
    }

    .footer{
      text-align:center;
      margin:26px 0 8px;
      font-size:11px;
      color:var(--sub);
    }

    /* RESPONSIVE */
    @media (max-width: 960px){
      .cards-grid{
        grid-template-columns:repeat(2,1fr);
      }
      .nav{
        flex-wrap:wrap;
      }
      .nav-links{
        flex-wrap:wrap;
      }
    }

    @media (max-width: 640px){
      .cards-grid{
        grid-template-columns:1fr;
      }
      .hero{
        padding:18px 16px 20px;
      }
    }
  </style>
</head>
<body>


<div class="nav">
      <div class="dropdown">
        <button type="button" class="profile-toggle">
          <div class="profile-avatar"><span>👤</span></div>
          <div class="profile-meta">
            <div class="profile-name">${sessionScope.userName}</div>
            <div class="profile-email">${sessionScope.email}</div>
          </div>
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/user/profile">View Profile</a>
          <a class="dropdown-item" href="/user/changePassword" target="_blank">Change Password</a>
          <a class="dropdown-item" href="/userlogout">Logout</a>
        </div>
        
      </div>
    </div>
    
  </nav>


  <div class="wrap">
    <!-- HERO -->
    <section class="hero">
      <div class="hero-row">
        <div class="hero-left">
          <h1>Welcome, ${sessionScope.userName}</h1>
          <p class="hero-sub">
            Quickly check your allocated assets, track your requests, and raise new ones — all from one simple dashboard.
          </p>
        </div>

      </div>
    </section>

    <!-- MAIN GRID (cards only) -->
    <section class="main-grid">
      <div>
        <div class="cards-grid">
          <!-- Your Current Asset Allocation -->
          <div class="card">
            <h3 class="card-title">Your Current Asset Allocation</h3>
            <c:choose>
              <c:when test="${not empty currentAssetName}">
                <p class="card-text">
                  You are currently using:
                  <br/>
                  <strong style="font-size:13px;color:#e5e7eb;">
                    ${currentAssetName}
                  </strong>
                </p>
              </c:when>
              <c:otherwise>
                <p class="card-text">
                  You don’t have any active asset assigned right now.
                  You can submit a new request from the
                  <strong>Raise New Request</strong> section.
                </p>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- My Requests -->
          <div class="card">
            <h3 class="card-title">My Requests</h3>
            <p class="card-text">
              Track the approval status and history of all asset requests you’ve submitted.
            </p>
            <a href="/requests" class="btn-card green" target="_blank">View Requests</a>
          </div>

          <!-- Raise Request -->
          <div class="card">
            <h3 class="card-title">Raise New Request</h3>
            <p class="card-text">
              Need a new asset or an upgrade? Submit a new request in just a few clicks.
            </p>
            <a href="/user/requestAsset" class="btn-card amber" target="_blank">Raise Request</a>
          </div>
        </div>
      </div>
    </section>

    <div class="footer">
      © 2025 Asset Tracking System • User Dashboard
    </div>
  </div>

  <!-- JS for dropdown click behavior -->
  <script>
    (function() {
      const dropdown = document.querySelector('.dropdown');
      const toggle = document.querySelector('.profile-toggle');
      if (!dropdown || !toggle) return;

      toggle.addEventListener('click', function(e) {
        e.stopPropagation();
        dropdown.classList.toggle('open');
      });

      document.addEventListener('click', function() {
        dropdown.classList.remove('open');
      });
    })();
  </script>

</body>
</html>