package com.asset.asset_management.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "asset")
public class Asset {
	
	@OneToMany(mappedBy = "asset",fetch = FetchType.EAGER)
	private List<Allocation> allocations = new ArrayList<>();
	
	public List<Allocation> getAllocations() {
		return allocations;
	}

	public void setAllocations(List<Allocation> allocations) {
		this.allocations = allocations;
	}

	public List<MaintananceRecord> getMaintenanceRecords() {
		return maintenanceRecords;
	}

	public void setMaintenanceRecords(List<MaintananceRecord> maintenanceRecords) {
		this.maintenanceRecords = maintenanceRecords;
	}

	@OneToMany(mappedBy = "asset")
	private List<MaintananceRecord> maintenanceRecords = new ArrayList<>();

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "asset_id")
    private Long assetId;
    
    @Transient
    public String getAllocatedUserName() {
        if (allocations == null || allocations.isEmpty()) {
            return "N/A";
        }
        return allocations.get(0).getUser().getFullName();
    }

    @Column(name = "asset_name", nullable = false, length = 100)
    private String assetName;

    @Column(name = "asset_type", nullable = false, length = 50)
    private String assetType;

    @Column(name = "serial_number", length = 100)
    private String serialNumber;

    @Column(name = "condition_a", nullable = false, length = 20)
    private String conditionA;  // e.g. "New", "Good", "NeedsRepair", "Damaged"

    @Column(name = "status_a", nullable = false, length = 20)
    private String statusA;     // e.g. "Available", "Assigned", etc.

    // --- Getters and Setters ---

    public Long getAssetId() {
        return assetId;
    }

    public void setAssetId(Long assetId) {
        this.assetId = assetId;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getAssetType() {
        return assetType;
    }

    public void setAssetType(String assetType) {
        this.assetType = assetType;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getConditionA() {
        return conditionA;
    }

    public void setConditionA(String conditionA) {
        this.conditionA = conditionA;
    }

    @Override
	public String toString() {
		return "Asset [assetId=" + assetId + ", assetName=" + assetName + ", assetType=" + assetType + ", serialNumber="
				+ serialNumber + ", conditionA=" + conditionA + ", statusA=" + statusA + "]";
	}

	public String getStatusA() {
        return statusA;
    }

    public void setStatusA(String statusA) {
        this.statusA = statusA;
    }


}

