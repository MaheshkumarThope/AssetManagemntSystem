<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Allocate Asset</title>

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
    display:flex;
    align-items:center;
    justify-content:center;
    padding:24px 16px;
    position:relative;
    overflow:hidden;
  }

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

  .container{
    width:100%;
    max-width:500px;
    background:radial-gradient(circle at 0 0,rgba(148,163,184,0.14),var(--card));
    padding:22px 22px 18px;
    border-radius:var(--radius);
    box-shadow:var(--shadow-soft);
    border:1px solid var(--line);
    backdrop-filter:blur(18px);
    position:relative;
    overflow:hidden;
    opacity:0;
    transform:translateY(12px);
    animation:fadeUp .35s ease-out forwards;
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
    to{opacity:1;transform:translateY(0);}
  }

  .header{
    display:flex;
    flex-direction:column;
    align-items:center;
    gap:6px;
    margin-bottom:12px;
  }

  .avatar-circle{
    width:40px;
    height:40px;
    border-radius:999px;
    background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));
    padding:3px;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 24px rgba(56,189,248,0.55);
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

  h2{
    margin:4px 0 0;
    font-size:20px;
    letter-spacing:.2px;
  }

  .subtext{
    font-size:12px;
    color:var(--sub);
    margin-top:4px;
    text-align:center;
  }

  label{
    display:block;
    margin-top:10px;
    margin-bottom:4px;
    font-weight:600;
    font-size:12px;
    color:#e5e7eb;
  }

  input, select, textarea{
    width:100%;
    padding:8px 10px;
    border-radius:10px;
    border:1px solid rgba(148,163,184,0.6);
    background:#020617;
    color:#e5e7eb;
    font-size:13px;
    outline:none;
    box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
    transition:border-color .15s ease, box-shadow .15s ease, transform .15s ease, background .15s ease;
  }

  input::placeholder,
  textarea::placeholder{
    color:rgba(148,163,184,0.9);
  }

  input:focus,
  select:focus,
  textarea:focus{
    border-color:rgba(56,189,248,0.9);
    box-shadow:0 0 0 1px rgba(56,189,248,0.75),0 0 24px rgba(37,99,235,0.4);
    transform:translateY(-1px);
  }

  textarea{
    resize:vertical;
    min-height:60px;
  }

  select{
    appearance:none;
    -webkit-appearance:none;
    -moz-appearance:none;
    background-image:linear-gradient(45deg,transparent 50%,#9ca3af 50%),linear-gradient(135deg,#9ca3af 50%,transparent 50%);
    background-position:calc(100% - 18px) 50%,calc(100% - 12px) 50%;
    background-size:6px 6px,6px 6px;
    background-repeat:no-repeat;
  }

  .row{
    display:flex;
    gap:10px;
    margin-top:4px;
  }

  .row .col{
    flex:1;
  }

  .hint{
    font-size:11px;
    color:var(--sub);
    margin-top:2px;
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

  button{
    margin-top:16px;
    width:100%;
    padding:10px;
    border:none;
    border-radius:999px;
    background:var(--btn-grad);
    color:var(--btn-text);
    font-size:14px;
    font-weight:500;
    cursor:pointer;
    box-shadow:0 18px 38px rgba(56,189,248,0.7);
    transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
  }

  button:hover{
    transform:translateY(-1px) scale(1.02);
    filter:brightness(1.06);
    box-shadow:0 22px 48px rgba(56,189,248,0.9);
  }

  .back-link{
    display:block;
    text-align:center;
    margin-top:10px;
    font-size:12px;
    text-decoration:none;
    color:var(--sub);
    transition:color .15s ease, transform .15s ease;
  }

  .back-link:hover{
    color:#e5e7eb;
    transform:translateY(-1px);
  }

  @media(max-width:520px){
    .container{padding:20px 16px 18px;}
    .row{flex-direction:column;}
  }
</style>
</head>
<body>

<div class="container">
  <div class="header">
    <div class="avatar-circle"><span>🔗</span></div>
    <h2>Allocate Asset</h2>
    <div class="subtext">
      Link an available asset to a user and define allocation and return details.
    </div>
  </div>

  <!-- Error from param: asset already assigned -->
  <c:if test="${param.error == 'assigned'}">
    <div class="error-banner">
      This asset is already assigned. Please select a different asset.
    </div>
    <script>
      // keep original behavior too (alert)
      alert("This asset is already assigned. Please select a different asset.");
    </script>
  </c:if>
  
 <c:if test="${param.error == 'userhasAsset'}">
    <div class="error-banner">
      This user has an asset assigned. Please return user asset.
    </div>
    <script>
      // keep original behavior too (alert)
      alert("This user has an asset assigned. Please return user asset");
    </script>
  </c:if>
  
  

  <!-- FUNCTIONALITY UNCHANGED -->
  <form method="post" action="/admin/allocation/save">

    <!-- Asset selection -->
    <label for="assetId">Asset</label>
    <select name="assetId" id="assetId" required>
      <option value="">-- Select Asset --</option>
      <c:forEach var="a" items="${assets}">
        <option value="${a.assetId}">
          ${a.assetName} (${a.assetType}) - ${a.statusA}
        </option>
      </c:forEach>
    </select>

    <!-- User selection -->
    <label for="userId">Allocate To (User)</label>
    <select name="userId" id="userId" required>
      <option value="">-- Select User --</option>
      <c:forEach var="u" items="${users}">
        <option value="${u.userId}">
          ${u.fullName} (${u.email})
        </option>
      </c:forEach>
    </select>

    <!-- Dates -->
    <div class="row">
      <div class="col">
        <label for="allocationDate">Allocation Date</label>
        <input type="date" id="allocationDate" name="allocationDate" required>
      </div>
      <div class="col">
        <label for="expectedReturnDate">Expected Return</label>
        <input type="date" id="expectedReturnDate" name="expectedReturnDate">
      </div>
    </div>

    <label for="returnDate">Return Date</label>
    <input type="date" id="returnDate" name="returnDate">
    <div class="hint">Leave empty for new allocations; set later when the asset is returned.</div>

    <!-- Status -->
    <label for="status">Status</label>
    <select name="status" id="status" required>
      <option value="Active">Active</option>
      <option value="Returned">Returned</option>
      <option value="Overdue">Overdue</option>
    </select>

    <!-- Remarks -->
    <label for="remarks">Remarks</label>
    <textarea id="remarks" name="remarks" placeholder="Optional comments..."></textarea>

    <button type="submit">Save Allocation</button>
  </form>

  <a href="/admin/assets" class="back-link">← Back to Assets</a>
</div>

<script>
  // Small UX enhancement: default allocation date to today
  (function(){
    const allocInput = document.getElementById('allocationDate');
    if (allocInput && !allocInput.value) {
      const today = new Date();
      const yyyy = today.getFullYear();
      const mm = String(today.getMonth()+1).padStart(2,'0');
      const dd = String(today.getDate()).padStart(2,'0');
      allocInput.value = `${yyyy}-${mm}-${dd}`;
    }
  })();
</script>

</body>
</html>
