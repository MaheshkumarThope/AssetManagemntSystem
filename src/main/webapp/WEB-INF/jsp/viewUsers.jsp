<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Users</title>

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
    padding:20px 16px 32px;
    overflow-x:auto;
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

  .page-wrap{
    max-width:1100px;
    margin:0 auto;
  }

  .page-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:14px;
    gap:10px;
  }

  .title-block{
    display:flex;
    flex-direction:column;
    gap:3px;
  }

  h1{
    margin:0;
    font-size:22px;
    letter-spacing:.2px;
  }

  .subtitle{
    font-size:12px;
    color:var(--sub);
  }

  .badge-pill{
    border-radius:999px;
    padding:4px 10px;
    font-size:11px;
    border:1px solid rgba(148,163,184,0.6);
    background:rgba(15,23,42,0.95);
    color:var(--sub);
  }

  /* Search / filter bar */
  .filter-card{
    background:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),var(--card));
    border-radius:var(--radius);
    border:1px solid var(--line);
    box-shadow:var(--shadow-soft);
    padding:14px 16px;
    margin-bottom:14px;
    backdrop-filter:blur(18px);
  }

  form.filter-form{
    display:flex;
    flex-wrap:wrap;
    gap:10px;
    align-items:center;
  }

  .filter-label{
    font-size:12px;
    color:var(--sub);
  }

  input, select{
    padding:8px 10px;
    border-radius:999px;
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

  input[name="q"]{
    min-width:220px;
    flex:1;
  }

  select[name="departmentId"]{
    min-width:180px;
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

  button{
    padding:8px 16px;
    border-radius:999px;
    border:none;
    cursor:pointer;
    font-size:13px;
    font-weight:500;
    background:var(--btn-grad);
    color:var(--btn-text);
    box-shadow:0 16px 32px rgba(56,189,248,0.6);
    white-space:nowrap;
    transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
  }

  button:hover{
    transform:translateY(-1px) scale(1.02);
    filter:brightness(1.06);
    box-shadow:0 20px 40px rgba(56,189,248,0.8);
  }

  /* TABLE WRAP */
  .table-card{
    background:radial-gradient(circle at 0 0,rgba(148,163,184,0.12),var(--card));
    border-radius:var(--radius);
    border:1px solid var(--line);
    box-shadow:var(--shadow-soft);
    padding:10px 14px 12px;
    backdrop-filter:blur(18px);
    overflow:hidden;
  }

  .table-inner{
    max-height:540px;
    overflow:auto;
    border-radius:12px;
  }

  table{
    width:100%;
    border-collapse:collapse;
    font-size:13px;
    color:var(--text);
  }

  thead{
    position:sticky;
    top:0;
    z-index:1;
  }

  th{
    background:linear-gradient(135deg,#111827,#1f2937);
    color:#e5e7eb;
    padding:9px 10px;
    text-align:left;
    font-weight:600;
    border-bottom:1px solid rgba(31,41,55,0.9);
    position:relative;
  }

  th:first-child{
    border-top-left-radius:12px;
  }
  th:last-child{
    border-top-right-radius:12px;
  }

  tbody tr{
    background:rgba(15,23,42,0.9);
    transition:background .15s ease, transform .15s ease, box-shadow .15s ease;
  }

  tbody tr:nth-child(even){
    background:rgba(15,23,42,0.94);
  }

  tbody tr:hover{
    background:radial-gradient(circle at 0 0,rgba(56,189,248,0.12),rgba(15,23,42,0.98));
    box-shadow:0 8px 24px rgba(15,23,42,0.9);
    transform:translateY(-1px);
  }

  td{
    padding:8px 10px;
    border-bottom:1px solid rgba(31,41,55,0.9);
    vertical-align:middle;
  }

  .status-cell{
    font-size:12px;
  }

  .status-pill{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:3px 8px;
    border-radius:999px;
    font-size:11px;
    font-weight:600;
  }

  .status-pill[data-status="Active"]{
    background:rgba(34,197,94,0.16);
    color:#bbf7d0;
    border:1px solid rgba(34,197,94,0.4);
  }

  .status-pill[data-status="Inactive"]{
    background:rgba(148,163,184,0.10);
    color:#e5e7eb;
    border:1px solid rgba(148,163,184,0.45);
  }

  a{
    text-decoration:none;
    color:var(--accent);
    font-weight:500;
  }

  a:hover{
    color:#7dd3fc;
  }
  
  .delete-btn{
    display:inline-block;
    padding:6px 12px;
    background:#dc3545;
    color:#fff;
    border-radius:999px;
    font-size:12px;
    font-weight:600;
    text-decoration:none;
    border:1px solid rgba(239,68,68,0.85);
    box-shadow:0 10px 24px rgba(127,29,29,0.8);
    transition:background .15s ease, transform .15s ease, box-shadow .15s ease;
  }

  .delete-btn:hover{
    background:#b02a37;
    transform:translateY(-1px);
    box-shadow:0 14px 32px rgba(127,29,29,1);
  }

  .table-meta{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:6px;
    font-size:11px;
    color:var(--sub);
  }

  .table-meta .hint{
    opacity:.85;
  }

  .table-meta .count{
    opacity:.9;
  }

  .live-indicator{
    display:inline-flex;
    align-items:center;
    gap:5px;
  }

  .live-dot{
    width:7px;
    height:7px;
    border-radius:999px;
    background:#22c55e;
    box-shadow:0 0 10px rgba(34,197,94,0.9);
  }

  /* Responsive tweaks */
  @media(max-width:720px){
    form.filter-form{
      flex-direction:column;
      align-items:stretch;
    }
    input[name="q"],
    select[name="departmentId"]{
      width:100%;
    }
    button{
      width:100%;
      justify-content:center;
      display:flex;
    }
  }
</style>

</head>
<body>

<div class="page-wrap">

  <div class="page-header">
    <div class="title-block">
      <h1>Users Directory</h1>
      <div class="subtitle">Search, filter and manage all registered users in the system.</div>
    </div>
    <div class="badge-pill">
      Users View
    </div>
  </div>

  <!-- Filter / Search Card -->
  <div class="filter-card">
    <form class="filter-form" method="get" action="/adminLogin/viewUsers">
      <div style="flex:1;min-width:220px;">
        <div class="filter-label">Search</div>
        <input name="q" placeholder="Search by name or email" value="${q}">
      </div>

      <div>
        <div class="filter-label">Department</div>
        <select name="departmentId">
          <option value="">All Departments</option>
          <c:forEach var="d" items="${departments}">
            <option value="${d.departmentId}"
              <c:if test="${selectedDeptId != null && selectedDeptId == d.departmentId}">
                selected
              </c:if>
            >
              ${d.name}
            </option>
          </c:forEach>
        </select>
      </div>

      <div>
        <button type="submit">Apply</button>
      </div>
    </form>
  </div>

  <!-- Table Card -->
  <div class="table-card">
    <div class="table-inner">
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
            <th>Dept Id</th>
            <th>Status</th>
            <th>Delete User</th>
          </tr>
        </thead>
        <tbody id="users-tbody">
          <c:forEach var="u" items="${users}">
            <tr>
              <td>${u.fullName}</td>
              <td>${u.email}</td>
              <td>${u.department.name}</td>
              <td>${u.departmentId}</td>
              <td class="status-cell">
                <span class="status-pill" data-status="${u.statusA}">${u.statusA}</span>
              </td>
              <td>
                <a href="/admin/delete/${u.userId}"
                   class="delete-btn"
                   onclick="return confirm('Are you sure you want to delete this user?');">
                   delete
                </a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="table-meta">
      <div class="hint">
        <span class="live-indicator">
          <span class="live-dot"></span>
          <span>Live client-side filter active as you type.</span>
        </span>
      </div>
      <div class="count">
        Showing <span id="row-count"></span> user(s)
      </div>
    </div>
  </div>

</div>

<script>
  // Simple client-side live filtering on top of server-side filter
  (function(){
    const searchInput = document.querySelector('input[name="q"]');
    const tbody = document.getElementById('users-tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const rowCountEl = document.getElementById('row-count');

    function updateRowCount(visibleRows){
      if(rowCountEl){
        rowCountEl.textContent = visibleRows;
      }
    }

    function applyClientFilter(){
      const term = (searchInput.value || '').toLowerCase().trim();
      let visible = 0;
      rows.forEach(tr => {
        const text = tr.textContent.toLowerCase();
        const match = !term || text.indexOf(term) !== -1;
        tr.style.display = match ? '' : 'none';
        if(match) visible++;
      });
      updateRowCount(visible);
    }

    if(searchInput && rows.length){
      searchInput.addEventListener('input', applyClientFilter);
      // initial count
      applyClientFilter();
    }
  })();
</script>

</body>
</html>
