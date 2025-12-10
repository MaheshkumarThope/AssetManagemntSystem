<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Asset</title>
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
        html,body{margin:0;padding:0;font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;color:var(--text);min-height:100vh;}
        body{
          background:radial-gradient(circle at top left,#1f2937 0%,#020617 55%,#000 100%);
          display:flex;align-items:center;justify-content:center;padding:24px 16px;position:relative;overflow:hidden;
        }
        body::before{
          content:"";position:fixed;inset:-40%;
          background:
            radial-gradient(circle at 10% 20%,rgba(56,189,248,0.22) 0,transparent 55%),
            radial-gradient(circle at 80% 0%,rgba(147,51,234,0.24) 0,transparent 60%),
            radial-gradient(circle at 70% 90%,rgba(34,197,94,0.2) 0,transparent 60%);
          opacity:0.95;z-index:-2;
          animation:glowShift 26s ease-in-out infinite alternate;
        }
        @keyframes glowShift{
          0%{transform:translate3d(0,0,0) scale(1);}
          50%{transform:translate3d(-40px,20px,0) scale(1.05);}
          100%{transform:translate3d(30px,-20px,0) scale(1.02);}
        }

        .request-container{
          width:100%;max-width:520px;
          background:radial-gradient(circle at 0 0,rgba(148,163,184,0.14),var(--card));
          padding:24px 24px 22px;border-radius:var(--radius);
          box-shadow:var(--shadow-soft);border:1px solid var(--line);
          backdrop-filter:blur(18px);position:relative;overflow:hidden;
          opacity:0;transform:translateY(14px);animation:fadeUp .35s ease-out forwards;
        }
        .request-container::before{
          content:"";position:absolute;inset:-40%;
          background:radial-gradient(circle at top right,rgba(56,189,248,0.18),transparent 55%);
          opacity:.45;pointer-events:none;mix-blend-mode:screen;
        }
        @keyframes fadeUp{to{opacity:1;transform:translateY(0);}}

        .header-wrap{display:flex;align-items:center;justify-content:space-between;gap:10px;margin-bottom:10px;}
        .logo-wrap{display:flex;align-items:center;gap:10px;}
        .logo-mark{width:40px;height:40px;border-radius:999px;background:conic-gradient(from 160deg,var(--accent),var(--accent2),var(--accent3),var(--accent));padding:3px;display:flex;align-items:center;justify-content:center;box-shadow:0 0 0 1px rgba(15,23,42,0.9),0 0 24px rgba(56,189,248,0.55);}
        .logo-mark span{width:100%;height:100%;border-radius:inherit;display:flex;align-items:center;justify-content:center;background:radial-gradient(circle at 30% 0%,#0b1120,#020617);font-size:20px;}
        .logo-text{display:flex;flex-direction:column;gap:2px;}
        .logo-title{margin:0;font-size:16px;letter-spacing:.15px;}
        .logo-sub{margin:0;font-size:11px;color:var(--sub);}
        .user-chip{font-size:11px;color:var(--sub);text-align:right;}
        .user-chip strong{color:#e5e7eb;}

        h2{margin:12px 0 6px;text-align:left;font-size:17px;letter-spacing:.15px;}
        .hint{font-size:11px;color:var(--sub);margin-bottom:12px;}
        label{display:block;margin:10px 0 4px;font-size:12px;font-weight:600;color:#e5e7eb;}
        input[type=text], input[type=number], select, textarea{
          width:100%;padding:9px 11px;margin:0 0 4px;border-radius:10px;border:1px solid rgba(148,163,184,0.6);
          background:#020617;color:#e5e7eb;font-size:13px;outline:none;box-shadow:inset 0 0 0 1px rgba(15,23,42,0.9);
          transition:border-color .15s ease, box-shadow .15s ease, transform .15s ease, background .15s ease;
        }
        textarea{min-height:80px;max-height:180px;resize:vertical;}
        input::placeholder, textarea::placeholder{color:rgba(148,163,184,0.9);}
        input:focus, textarea:focus, select:focus{
          border-color:rgba(56,189,248,0.9);box-shadow:0 0 0 1px rgba(56,189,248,0.75),0 0 24px rgba(37,99,235,0.4);
          transform:translateY(-1px);
        }
        select{cursor:pointer;}
        .readonly-info{font-size:12px;color:var(--sub);background:rgba(15,23,42,0.7);border-radius:10px;padding:8px 10px;border:1px solid rgba(148,163,184,0.4);margin-bottom:12px;}
        .small-note{font-size:10px;color:var(--sub);margin-bottom:4px;}
        button{width:100%;margin-top:12px;padding:10px;border:none;border-radius:999px;cursor:pointer;font-size:14px;font-weight:500;background:var(--btn-grad);color:var(--btn-text);box-shadow:0 18px 38px rgba(56,189,248,0.7);transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;}
        button:hover{transform:translateY(-1px) scale(1.02);filter:brightness(1.06);box-shadow:0 22px 48px rgba(56,189,248,0.9);}
        .error{color:#fecaca;background:rgba(127,29,29,0.22);border:1px solid rgba(248,113,113,0.6);border-radius:10px;text-align:left;font-weight:500;margin-bottom:10px;padding:6px 8px;font-size:12px;box-shadow:0 10px 24px rgba(127,29,29,0.9);}
        .success{color:#bbf7d0;background:rgba(22,163,74,0.22);border:1px solid rgba(34,197,94,0.7);border-radius:10px;text-align:left;font-weight:500;margin-bottom:10px;padding:6px 8px;font-size:12px;box-shadow:0 10px 24px rgba(22,163,74,0.9);}
        .footer-text{margin-top:10px;text-align:center;font-size:11px;color:var(--sub);}
        .footer-text a{text-decoration:underline;color:#bae6fd;}
    </style>
</head>
<body>
<div class="request-container">
    <div class="header-wrap">
        <div class="logo-wrap">
            <div class="logo-mark"><span>📥</span></div>
            <div class="logo-text">
                <p class="logo-title">Request an Asset</p>
                <p class="logo-sub">Create a new asset allocation request</p>
            </div>
        </div>
        <div class="user-chip">
            Logged in as<br>
            <strong>${sessionScope.userName}</strong>
        </div>
    </div>

    <h2>Asset Request Form</h2>
    <div class="hint">
        Select an available laptop/asset from the list, or describe it below. Status will be <strong>Pending</strong>.
    </div>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="success">${message}</div>
    </c:if>

    <div class="readonly-info">
        <strong>User:</strong> ${sessionScope.userName} <br/>
        <strong>Email:</strong> ${sessionScope.email} <br/>
        <strong>Department:</strong> ${sessionScope.department}
    </div>

    <form action="/user/requestAsset" method="post">
        <input type="hidden" name="userId" value="${sessionScope.userId}" />

        <!-- Asset dropdown -->
        <label for="assetId">Select Available Asset</label>
        <select id="assetId" name="assetId" onchange="updateAssetName()">
            <option value="">-- Select from available assets --</option>
            <c:forEach var="asset" items="${availableAssets}">
                <option value="${asset.assetId}" data-name="${asset.assetName}">
                    ${asset.assetName}
                    <c:if test="${not empty asset.serialNumber}">(SN: ${asset.serialNumber})</c:if>
                </option>
            </c:forEach>
        </select>
        <div class="small-note">If your asset is not listed, describe it below.</div>

        <!-- Auto-filled asset name -->
        <label for="assetName">Asset Name</label>
        <input type="text" id="assetName" name="assetName" placeholder="Asset name" />

        <label for="reason">Reason for Request</label>
        <textarea id="reason" name="reason" placeholder="Explain why you need this asset" required></textarea>

        <label for="remarks">Additional Remarks (optional)</label>
        <textarea id="remarks" name="remarks" placeholder="Any extra info for admin"></textarea>

        <button type="submit">Submit Request</button>
    </form>

    <div class="footer-text">
        Check your existing requests: <a href="/user/myRequests">View My Requests</a>
    </div>
</div>

<script>
function updateAssetName() {
    const select = document.getElementById("assetId");
    const nameInput = document.getElementById("assetName");
    const selectedOption = select.options[select.selectedIndex];
    const assetName = selectedOption.getAttribute("data-name");
    nameInput.value = assetName ? assetName : "";
}
</script>
</body>
</html>
