package com.asset.asset_management.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "request")
public class Request {
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id")
	private Users user;
	
	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Admin getProcessedBy() {
		return processedBy;
	}

	public void setProcessedBy(Admin processedBy) {
		this.processedBy = processedBy;
	}

	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}

	@ManyToOne
	@JoinColumn(name = "processed_by_admin_id", nullable = true)
	private Admin processedBy;
	
	@ManyToOne
	@JoinColumn(name = "asset_id", nullable = true)
	private Asset asset;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id", nullable = false)
    private Long requestId;  // manually assigned, not auto-increment

    @Column(name = "user_id",insertable = false, updatable = false)
    private Long userId;

    @Column(name = "asset_id", insertable = false, updatable = false)
    private int assetId;

    @Column(name = "asset_name", nullable = false, length = 100)
    private String assetName;

    @Column(name = "reason", length = 255)
    private String reason;

    @Column(name = "request_date", nullable = false)
    private LocalDate requestDate;

    @Column(name = "status_h", nullable = false, length = 20)
    private String statusH;   // e.g. "Pending", "Approved", "Rejected", "Completed"

    @Column(name = "processed_by_admin_id", insertable = false, updatable = false)
    private Long processedByAdminId;

    @Column(name = "remarks", length = 255)
    private String remarks;

    // --- Getters and Setters ---

    public Long getRequestId() {
        return requestId;
    }

    public void setRequestId(Long requestId) {
        this.requestId = requestId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public int getAssetId() {
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public LocalDate getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(LocalDate requestDate) {
        this.requestDate = requestDate;
    }

    public String getStatusH() {
        return statusH;
    }

    public void setStatusH(String statusH) {
        this.statusH = statusH;
    }

    public Long getProcessedByAdminId() {
        return processedByAdminId;
    }

    public void setProcessedByAdminId(Long processedByAdminId) {
        this.processedByAdminId = processedByAdminId;
    }

    public String getRemarks() {
        return remarks;
    }

    @Override
	public String toString() {
		return "Request [requestId=" + requestId + ", userId=" + userId + ", assetId=" + assetId + ", assetName="
				+ assetName + ", reason=" + reason + ", requestDate=" + requestDate + ", statusH=" + statusH
				+ ", processedByAdminId=" + processedByAdminId + ", remarks=" + remarks + "]";
	}

	public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}