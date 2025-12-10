package com.asset.asset_management.entity;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "maintenance_record")
public class MaintananceRecord {

	@ManyToOne(optional = false)
	@JoinColumn(name = "asset_id")
	private Asset asset;
	
    @Id
    @Column(name = "maintenance_id", nullable = false)
    private Long maintenanceId;

    @Column(name = "asset_id", insertable = false, updatable = false)
    private Long assetId;

    @Column(name = "maintenance_date", nullable = false)
    private LocalDate maintenanceDate;

    @Column(name = "issue_reported", nullable = false, length = 255)
    private String issueReported;

    @Column(name = "action_taken", length = 255)
    private String actionTaken;

    @Column(name = "technician_name", length = 100)
    private String technicianName;

    // --- Getters and Setters ---

    public Long getMaintenanceId() {
        return maintenanceId;
    }

    public void setMaintenanceId(Long maintenanceId) {
        this.maintenanceId = maintenanceId;
    }

    public Long getAssetId() {
        return assetId;
    }

    public void setAssetId(Long assetId) {
        this.assetId = assetId;
    }

    public LocalDate getMaintenanceDate() {
        return maintenanceDate;
    }

    public void setMaintenanceDate(LocalDate maintenanceDate) {
        this.maintenanceDate = maintenanceDate;
    }

    public String getIssueReported() {
        return issueReported;
    }

    public void setIssueReported(String issueReported) {
        this.issueReported = issueReported;
    }

    public String getActionTaken() {
        return actionTaken;
    }

    public void setActionTaken(String actionTaken) {
        this.actionTaken = actionTaken;
    }

    public String getTechnicianName() {
        return technicianName;
    }

    public void setTechnicianName(String technicianName) {
        this.technicianName = technicianName;
    }
}
