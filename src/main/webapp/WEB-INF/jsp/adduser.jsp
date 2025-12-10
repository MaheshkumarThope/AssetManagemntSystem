<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add User</title>

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
    --btn-grad-alt:linear-gradient(135deg,#0f172a,#1f2937);
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
    background:
      radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
    position:relative;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:24px 16px;
    overflow:hidden;
  }

  /* animated glow backdrop for consistency with dashboard */
  body::before{
    content:"";
    position:fixed;
    inset:-40%;
    background:
      radial-gradient(circle at 10% 20%,rgba(56,189,248,0.18) 0,transparent 55%),
      radial-gradient(circle at 80% 0%,rgba(147,51,234,0.22) 0,transparent 60%),
      radial-gradient(circle at 70% 90%,rgba(34,197,94,0.18) 0,transparent 60%);
    opacity:0.9;
    z-index:-2;
    animation:glowShift 26s ease-in-out infinite alternate;
  }

  @keyframes glowShift{
    0%{transform:translate3d(0,0,0) scale(1);}
    50%{transform:translate3d(-40px,20px,0) scale(1.05);}
    100%{transform:translate3d(30px,-20px,0) scale(1.02);}
  }

  .container{
    width:100%;
    max-width:440px;
    background:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),var(--card));
    border-radius:var(--radius);
    box-shadow:var(--shadow-soft);
    padding:22px 22px 20px;
    border:1px solid var(--line);
    backdrop-filter:blur(18px);
    position:relative;
    overflow:hidden;
    animation:fadeUp .35s ease-out forwards;
    opacity:0;
    transform:translateY(12px);
  }

  .container::before{
    content:"";
    position:absolute;
    inset:-40%;
    background:radial-gradient(circle at top right,rgba(56,189,248,0.18),transparent 55%);
    opacity:.4;
    pointer-events:none;
    mix-blend-mode:screen;
  }

  @keyframes fadeUp{
    to{
      opacity:1;
      transform:translateY(0);
    }
  }

  .header{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    margin-bottom:16px;
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
  }

  .avatar-circle span{
    width:100%;
    height:100%;
    border-radius:inherit;
    display:flex;
    align-items:center;
    justify-content:center;
    background:radial-gradient(circle at 30% 0%,#0b1120,#020617);
    font-size:17px;
  }

  h2{
    margin:0;
    font-size:20px;
    letter-spacing:.2px;
  }

  .subtext{
    text-align:center;
    font-size:12px;
    color:var(--sub);
    margin-bottom:14px;
  }

  label{
    font-size:12px;
    font-weight:600;
    display:block;
    margin:10px 0 6px;
    color:#e5e7eb;
  }

  .field-note{
    font-size:11px;
    color:var(--sub);
    margin-top:2px;
  }

  input, select{
    width:100%;
    padding:9px 11px;
    border-radius:10px;
    border:1px solid rgba(148,163,184,0.6);
    background:#020617;
    color:#e5e7eb;
    font-size:13px;
    outline:none;
    transition:border-color .15s ease, box-shadow .15s ease, background .15s ease, transform .15s ease;
    box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
  }

  input::placeholder{
    color:rgba(148,163,184,0.9);
  }

  input:focus,
  select:focus{
    border-color:rgba(56,189,248,0.9);
    box-shadow:0 0 0 1px rgba(56,189,248,0.75),0 0 24px rgba(37,99,235,0.4);
    transform:translateY(-1px);
  }

  select{
    appearance:none;
    -webkit-appearance:none;
    -moz-appearance:none;
    background-image:linear-gradient(45deg,transparent 50%,#9ca3af 50%),linear-gradient(135deg,#9ca3af 50%,transparent 50%);
    background-position:calc(100% - 16px) 14px,calc(100% - 11px) 14px;
    background-size:6px 6px,6px 6px;
    background-repeat:no-repeat;
  }

  button{
    width:100%;
    margin-top:18px;
    padding:10px;
    border:none;
    border-radius:999px;
    cursor:pointer;
    font-size:14px;
    font-weight:500;
    background:var(--btn-grad);
    color:var(--btn-text);
    box-shadow:0 18px 38px rgba(56,189,248,0.65);
    transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
  }

  button:hover{
    transform:translateY(-1px) scale(1.02);
    filter:brightness(1.06);
    box-shadow:0 22px 48px rgba(56,189,248,0.8);
  }

  .back-link{
    display:inline-flex;
    align-items:center;
    gap:4px;
    margin-top:14px;
    font-size:12px;
    color:var(--sub);
    text-decoration:none;
    transition:color .15s ease, transform .15s ease;
    justify-content:center;
    width:100%;
  }

  .back-link:hover{
    color:#e5e7eb;
    transform:translateY(-1px);
  }

  .back-link span.arrow{
    font-size:13px;
  }

  @media (max-width:480px){
    .container{
      padding:18px 16px 18px;
    }
  }
</style>

</head>
<body>

<div class="container">
  <div class="header">
    <div class="avatar-circle"><span>➕</span></div>
    <h2>Add New User</h2>
  </div>
  <div class="subtext">
    Create a new user record that can be linked to asset allocations and requests.
  </div>

  <!-- FUNCTIONALITY UNCHANGED -->
  <form method="post" action="/admin/users/save">
    
    <label>Full Name</label>
    <input type="text" name="fullName" required>

    <label>Email</label>
    <input type="email" name="email" required>

    <label>Password</label>
    <input type="password" name="passwordH" required>
    <div class="field-note">Use a strong password before sharing credentials with the user.</div>

    <label>Phone</label>
    <input type="text" name="phone" placeholder="optional">

    <label>Department</label>
    <select name="departmentId" required>
      <option value="">-- Select Department --</option>
      <option value="102">HR</option>
      <option value="101">IT</option>
      <option value="103">Finance</option>
      <option value="104">Marketing</option>
      <option value="105">Sales</option>
      <option value="106">Operations</option>
      <option value="107">Customer Support</option>
      <option value="108">Logistics</option>
      <option value="109">Procurement</option>
      <option value="110">Legal</option>
    </select>

    <label>Status</label>
    <select name="statusA" required>
      <option value="Active">Active</option>
      <option value="Inactive">Inactive</option>
    </select>

    <button type="submit">Add User</button>

  </form>

  <a href="/adminLogin/viewUsers" class="back-link">
    <span class="arrow">←</span>
    <span>Back to Users</span>
  </a>
</div>

</body>
</html>
