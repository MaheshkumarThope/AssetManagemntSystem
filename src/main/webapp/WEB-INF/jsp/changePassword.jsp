<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Change Password</title>
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
      --btn-grad-alt:linear-gradient(135deg,#0f172a,#1f2937);
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
      display:flex;
      align-items:center;
      justify-content:center;
      padding:24px 16px;
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

	 .error-banner{
    margin-bottom:8px;
    padding:7px 9px;
    font-size:12px;
    border-radius:10px;
    border:1px solid rgba(248,113,113,0.7);
    background:rgba(127,29,29,0.25);
    color:#fecaca;
    box-shadow:0 10px 24px rgba(127,29,29,0.9);
    text-align:center;
  }

    a{ color:inherit; text-decoration:none; }

    .card-wrap{
      width:100%;
      max-width:420px;
      background:var(--card-soft);
      border-radius:var(--radius);
      border:1px solid var(--line);
      box-shadow:var(--shadow-soft);
      backdrop-filter:blur(18px);
      padding:22px 20px 20px;
      position:relative;
      overflow:hidden;
      opacity:0;
      transform:translateY(12px);
      animation:fadeUp .35s ease-out forwards;
    }

    .card-wrap::before{
      content:"";
      position:absolute;
      inset:-40%;
      background:radial-gradient(circle at top right,rgba(56,189,248,0.18),transparent 55%);
      opacity:.45;
      mix-blend-mode:screen;
      pointer-events:none;
    }

    @keyframes fadeUp{
      to{opacity:1;transform:translateY(0);}
    }

    .card-header{
      display:flex;
      align-items:center;
      gap:10px;
      margin-bottom:12px;
    }

    .avatar-circle{
      width:40px;
      height:40px;
      border-radius:999px;
      background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
      padding:2px;
      display:flex;
      align-items:center;
      justify-content:center;
      box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 22px rgba(56,189,248,0.55);
    }
    .avatar-circle span{
      width:100%;
      height:100%;
      border-radius:inherit;
      display:flex;
      align-items:center;
      justify-content:center;
      background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
      font-size:20px;
    }

    .title-group{
      display:flex;
      flex-direction:column;
    }
    .title-group h1{
      margin:0;
      font-size:18px;
      letter-spacing:.18px;
    }
    .title-group p{
      margin:3px 0 0;
      font-size:11px;
      color:var(--sub);
    }

    .section-title{
      margin:10px 0 8px;
      font-size:13px;
      font-weight:600;
    }

    label{
      display:block;
      margin:8px 0 4px;
      font-size:12px;
      font-weight:600;
      color:#e5e7eb;
    }

    input[type=password]{
      width:100%;
      padding:9px 11px;
      border-radius:10px;
      border:1px solid rgba(148,163,184,0.6);
      background:#020617;
      color:#e5e7eb;
      font-size:13px;
      outline:none;
      box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
      transition:border-color .15s ease, box-shadow .15s ease, transform .15s ease, background .15s ease;
    }
    input[type=text]{
      width:100%;
      padding:9px 11px;
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

    .btn{
      width:100%;
      margin-top:14px;
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

    .btn:hover{
      transform:translateY(-1px) scale(1.02);
      filter:brightness(1.06);
      box-shadow:0 22px 48px rgba(56,189,248,0.9);
    }

    .btn-secondary{
      background:var(--btn-grad-alt);
      border:1px solid rgba(148,163,184,0.7);
      box-shadow:0 14px 30px rgba(15,23,42,0.9);
      margin-top:8px;
    }

    .btn-secondary:hover{
      box-shadow:0 18px 38px rgba(15,23,42,1);
    }

    .message{
      margin-bottom:10px;
      font-size:12px;
      border-radius:10px;
      padding:7px 9px;
      text-align:left;
    }

    .message.error{
      color:#fecaca;
      background:rgba(127,29,29,0.25);
      border:1px solid rgba(248,113,113,0.7);
      box-shadow:0 10px 24px rgba(127,29,29,0.9);
    }

    .message.success{
      color:#bbf7d0;
      background:rgba(22,163,74,0.22);
      border:1px solid rgba(34,197,94,0.75);
      box-shadow:0 10px 24px rgba(22,163,74,0.9);
    }

    .hint{
      font-size:11px;
      color:var(--sub);
      margin-top:6px;
    }

    .footer-text{
      margin-top:14px;
      text-align:center;
      font-size:11px;
      color:var(--sub);
    }
  </style>
</head>
<body>

<div class="card-wrap">
  <!-- Header -->
  <div class="card-header">
    <div class="avatar-circle"><span>🔐</span></div>
    <div class="title-group">
      <h1>Change Password</h1>
      <p>Update your account password to keep your access secure.</p>
    </div>
  </div>

  
    <c:if test="${param.error == 'nomatch'}">
    <div class="error-banner">
      Passwords do not match please re-enter
    </div>
    <script>
      // keep original behavior too (alert)
      alert("passwords do not match please re- enter ");
    </script>
  </c:if>
  
      <c:if test="${param.error == 'invalid'}">
    <div class="error-banner">
      Invalid Crendentials
    </div>
    <script>
      // keep original behavior too (alert)
      alert("Invalid Credentials");
    </script>
  </c:if>
  
      <c:if test="${param.success == 'success'}">
    <div class="error-banner">
      password changed
    </div>
    <script>
      // keep original behavior too (alert)
      alert("Sucessfully changed password");
    </script>
  </c:if>

  <!-- Form -->
  <!-- Adjust action URL to match your controller mapping -->
  <form action="changePassword" method="post">
  
    <div class="section-title">Current Email</div>
    <input type="text" id="email" name="email"
           placeholder="Enter your current Email" required>
           
    <div class="section-title">Current Password</div>
    <input type="password" id="oldpassword" name="oldpassword"
           placeholder="Enter your current password" required>

    <div class="section-title" style="margin-top:12px;">New Password</div>
    <input type="password" id="newpassword" name="newpassword"
           placeholder="Choose a strong password" required>

    <div class="section-title" style="margin-top:12px;">New Password</div>
    <input type="password" id="confirmpassword" name="confirmpassword"
           placeholder="Re-enter new password" required>

    <p class="hint">
      Use at least 8 characters with a mix of letters, numbers, and symbols.
    </p>

    <button type="submit" class="btn">Update Password</button>

    <!-- Optional: back button (change href as needed) -->
    <a href="javascript:history.back()" class="btn btn-secondary" style="display:block;text-align:center;">
      ⬅ Back
    </a>
  </form>

  <div class="footer-text">
    © <script>document.write(new Date().getFullYear())</script> Asset Management • Security Settings
  </div>
</div>

</body>
</html>
