package com.asset.asset_management.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "allocation")
public class Allocation {
	
	@OneToOne(optional = false)
	@JoinColumn(name = "user_id")
	private Users user;
	
	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Asset getAsset() {
		return asset;
	}

	public void setAsset(Asset asset) {
		this.asset = asset;
	}

	public Admin getAllocatedBy() {
		return allocatedBy;
	}

	public void setAllocatedBy(Admin allocatedBy) {
		this.allocatedBy = allocatedBy;
	}

	@OneToOne(optional = false)
	@JoinColumn(name = "asset_id")
	private Asset asset;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "allocated_by_admin_id")
	private Admin allocatedBy; 

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "allocation_id")
    private Long allocationId;

    @Column(name = "asset_id",insertable = false, updatable = false)
    private int assetId;

    @Override
	public String toString() {
		return "Allocation [allocationId=" + allocationId + ", assetId=" + assetId + ", userId=" + userId
				+ ", allocatedByAdminId=" + allocatedByAdminId + ", allocationDate=" + allocationDate
				+ ", expectedReturnDate=" + expectedReturnDate + ", returnDate=" + returnDate + ", status=" + status
				+ ", remarks=" + remarks + "]";
	}

	@Column(name = "user_id",insertable = false, updatable = false)
    private int userId;

    @Column(name = "allocated_by_admin_id",insertable = false, updatable = false)
    private Long allocatedByAdminId;

    @Column(name = "allocation_date", nullable = false)
    private LocalDate allocationDate;

    @Column(name = "expected_return_date")
    private LocalDate expectedReturnDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Column(name = "status", nullable = false)
    private String status;   // stores enum text like "Active", "Returned", etc.

    @Column(name = "remarks", length = 255)
    private String remarks;

    // --- Getters and Setters ---

    public Long getAllocationId() {
        return allocationId;
    }

    public void setAllocationId(Long allocationId) {
        this.allocationId = allocationId;
    }

    public int getAssetId() {
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Long getAllocatedByAdminId() {
        return allocatedByAdminId;
    }

    public void setAllocatedByAdminId(Long allocatedByAdminId) {
        this.allocatedByAdminId = allocatedByAdminId;
    }

    public LocalDate getAllocationDate() {
        return allocationDate;
    }

    public void setAllocationDate(LocalDate allocationDate) {
        this.allocationDate = allocationDate;
    }

    public LocalDate getExpectedReturnDate() {
        return expectedReturnDate;
    }

    public void setExpectedReturnDate(LocalDate expectedReturnDate) {
        this.expectedReturnDate = expectedReturnDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
