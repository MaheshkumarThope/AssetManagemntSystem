package com.asset.asset_management.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "department")
public class Department {
	
	@OneToMany(mappedBy = "department")
	private List<Users> users = new ArrayList<>();

    @Id
    @Column(name = "department_id")
    private Long departmentId;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "manager_name", length = 100)
    private String managerName;

    @Column(name = "department_mail", length = 100)
    private String departmentMail;

    @Column(name = "location", length = 100)
    private String location;

    // --- Getters and Setters ---

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getDepartmentMail() {
        return departmentMail;
    }

    public void setDepartmentMail(String departmentMail) {
        this.departmentMail = departmentMail;
    }

    @Override
	public String toString() {
		return "Department [departmentId=" + departmentId + ", name=" + name + ", managerName=" + managerName
				+ ", departmentMail=" + departmentMail + ", location=" + location + "]";
	}

	public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    
    
}
