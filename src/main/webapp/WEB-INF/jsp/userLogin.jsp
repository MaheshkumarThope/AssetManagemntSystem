<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
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

        *{
          box-sizing:border-box;
        }

        html,body{
          margin:0;
          padding:0;
          font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;
          color:var(--text);
          min-height:100vh;
        }

        body{
          background:radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
          display:flex;
          align-items:center;
          justify-content:center;
          padding:24px 16px;
          position:relative;
          overflow:hidden;
        }

        /* animated background glow */
        body::before{
          content:"";
          position:fixed;
          inset:-40%;
          background:
            radial-gradient(circle at 10% 20%,rgba(56,189,248,0.22) 0,transparent 55%),
            radial-gradient(circle at 80% 0%,rgba(147,51,234,0.24) 0,transparent 60%),
            radial-gradient(circle at 70% 90%,rgba(34,197,94,0.2) 0,transparent 60%);
          opacity:0.95;
          z-index:-2;
          animation:glowShift 26s ease-in-out infinite alternate;
        }

        @keyframes glowShift{
          0%{transform:translate3d(0,0,0) scale(1);}
          50%{transform:translate3d(-40px,20px,0) scale(1.05);}
          100%{transform:translate3d(30px,-20px,0) scale(1.02);}
        }

        .login-container{
          width:100%;
          max-width:380px;
          background:radial-gradient(circle at 0 0,rgba(148,163,184,0.14),var(--card));
          padding:24px 22px 22px;
          border-radius:var(--radius);
          box-shadow:var(--shadow-soft);
          border:1px solid var(--line);
          backdrop-filter:blur(18px);
          position:relative;
          overflow:hidden;
          opacity:0;
          transform:translateY(14px);
          animation:fadeUp .35s ease-out forwards;
        }

        .login-container::before{
          content:"";
          position:absolute;
          inset:-40%;
          background:radial-gradient(circle at top right,rgba(56,189,248,0.18),transparent 55%);
          opacity:.45;
          pointer-events:none;
          mix-blend-mode:screen;
        }

        @keyframes fadeUp{
          to{
            opacity:1;
            transform:translateY(0);
          }
        }

        .logo-wrap{
          display:flex;
          flex-direction:column;
          align-items:center;
          gap:8px;
          margin-bottom:16px;
        }

        .logo-mark{
          width:46px;
          height:46px;
          border-radius:999px;
          background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
          padding:3px;
          display:flex;
          align-items:center;
          justify-content:center;
          box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 24px rgba(56,189,248,0.55);
        }

        .logo-mark span{
          width:100%;
          height:100%;
          border-radius:inherit;
          display:flex;
          align-items:center;
          justify-content:center;
          background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
          font-size:22px;
        }

        .logo-text{
          text-align:center;
        }

        .logo-title{
          margin:0;
          font-size:18px;
          letter-spacing:.18px;
        }

        .logo-sub{
          margin:4px 0 0;
          font-size:11px;
          color:var(--sub);
        }

        h2{
          margin:14px 0 6px;
          text-align:center;
          font-size:16px;
          letter-spacing:.15px;
        }

        .hint{
          text-align:center;
          font-size:11px;
          color:var(--sub);
          margin-bottom:10px;
        }

        label{
          display:block;
          margin:10px 0 4px;
          font-size:12px;
          font-weight:600;
          color:#e5e7eb;
        }

        input[type=text],
        input[type=password]{
          width:100%;
          padding:9px 11px;
          margin:0 0 4px;
          border-radius:10px;
          border:1px solid rgba(148,163,184,0.6);
          background:#020617;
          color:#e5e7eb;
          font-size:13px;
          outline:none;
          box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
          transition:border-color .15s ease, box-shadow .15s ease, transform .15s ease, background .15s ease;
        }

        input::placeholder{
          color:rgba(148,163,184,0.9);
        }

        input:focus{
          border-color:rgba(56,189,248,0.9);
          box-shadow:0 0 0 1px rgba(56,189,248,0.75),0 0 24px rgba(37,99,235,0.4);
          transform:translateY(-1px);
        }

        button{
          width:100%;
          margin-top:12px;
          padding:10px;
          border:none;
          border-radius:999px;
          cursor:pointer;
          font-size:14px;
          font-weight:500;
          background:var(--btn-grad);
          color:var(--btn-text);
          box-shadow:0 18px 38px rgba(56,189,248,0.7);
          transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
        }

        button:hover{
          transform:translateY(-1px) scale(1.02);
          filter:brightness(1.06);
          box-shadow:0 22px 48px rgba(56,189,248,0.9);
        }

        .error{
          color:#fecaca;
          background:rgba(127,29,29,0.22);
          border:1px solid rgba(248,113,113,0.6);
          border-radius:10px;
          text-align:center;
          font-weight:500;
          margin-bottom:10px;
          padding:6px 8px;
          font-size:12px;
          box-shadow:0 10px 24px rgba(127,29,29,0.9);
        }

        .footer-text{
          margin-top:14px;
          text-align:center;
          font-size:11px;
          color:var(--sub);
        }

        .footer-text span{
          opacity:.9;
        }

        /* switch to admin */
        .switch-admin-wrap{
          margin-top:14px;
          text-align:center;
          font-size:11px;
          color:var(--sub);
        }

        .switch-admin-wrap span{
          display:block;
          margin-bottom:6px;
        }

        .btn-admin{
          display:inline-block;
          padding:8px 16px;
          border-radius:999px;
          border:1px solid rgba(148,163,184,0.7);
          background:#020617;
          color:#e5e7eb;
          font-size:12px;
          text-decoration:none;
          cursor:pointer;
          transition:background .18s ease,border-color .18s ease,transform .18s ease,box-shadow .18s ease;
          box-shadow:0 10px 26px rgba(15,23,42,0.8);
        }

        .btn-admin:hover{
          background:#0f172a;
          border-color:rgba(56,189,248,0.9);
          transform:translateY(-1px);
          box-shadow:0 16px 34px rgba(15,23,42,1);
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Logo / brand -->
        <div class="logo-wrap">
            <div class="logo-mark">
                <!-- user logo icon -->
                <span>👤</span>
            </div>
            <div class="logo-text">
                <p class="logo-title">Asset User Portal</p>
                <p class="logo-sub">Access your assigned assets and requests</p>
            </div>
        </div>

        <h2>User Login</h2>
        <div class="hint">Use your registered user credentials to sign in.</div>

        <!-- Error message from backend -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <p class="error"><%= error %></p>
        <%
            }
        %>

        <form action="userLogin" method="post">
            <label for="email">Username</label>
            <input type="text" id="email" name="email" placeholder="Enter email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required>

            <button type="submit">Login</button>
        </form>

        <!-- NEW: link to admin login -->
        <div class="switch-admin-wrap">
            <span>Are you an admin?</span>
            <a href="adminLogin" class="btn-admin">Login as Admin</a>
        </div>

        <div class="footer-text">
            <span>© <script>document.write(new Date().getFullYear())</script> Asset Management • User</span>
        </div>
    </div>
</body>
</html>
