package com.asset.asset_management.entity;

import java.security.Timestamp;
import java.time.*;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="users")
public class Users {
	
		@ManyToOne
		@JoinColumn(name = "department_id") // nullable
		private Department department;
		
		@OneToOne(mappedBy = "user")
		private Allocation allocations;
	
		@OneToMany(mappedBy = "user")
		private List<Request> requests = new ArrayList<>();
		
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name = "user_id")
	    private Integer userId;

	    @Column(name = "full_name")
	    private String fullName;

	    @Column(name = "email")
	    private String email;

	    @Column(name = "password_h")
	    private String passwordH;

	    @Column(name = "phone")
	    private String phone;

	    @Column(name = "department_id", insertable = false, updatable = false)
	    private Long departmentId;

	    @Column(name = "status_a")
	    private String statusA;   
	    

	    @CreationTimestamp
	    @Column(name = "created_at", updatable = false)
	    private LocalDate createdAt;

	    public Integer getUserId() {
			return userId;
		}

		public void setUserId(Integer userId) {
			this.userId = userId;
		}

		public String getFullName() {
			return fullName;
		}

		public void setFullName(String fullName) {
			this.fullName = fullName;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPasswordH() {
			return passwordH;
		}

		public void setPasswordH(String passwordH) {
			this.passwordH = passwordH;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		public Long getDepartmentId() {
			return departmentId;
		}

		public void setDepartmentId(Long departmentId) {
			this.departmentId = departmentId;
		}

		public String getStatusA() {
			return statusA;
		}

		public void setStatusA(String statusA) {
			this.statusA = statusA;
		}

		public LocalDate getCreatedAt() {
			return createdAt;
		}

		public void setCreatedAt(LocalDate createdAt) {
			this.createdAt = createdAt;
		}

		public Department getDepartment() {
		    return department;
		}

		public void setDepartment(Department department) {
		    this.department = department;
		}
		@Override
		public String toString() {
			return "Users [userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", passwordH="
					+ passwordH + ", phone=" + phone + ", departmentId=" + departmentId + ", statusA=" + statusA
					+ ", createdAt=" + createdAt + "]";
		}

		
	    
}
