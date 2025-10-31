package com.asset.asset_management.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="users")
public class Users {
	
	 	@Id
	    @GeneratedValue
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

	    @Column(name = "department_id")
	    private Integer departmentId;

	    @Column(name = "status_a")
	    private String statusA;   
	    

		@Column(name = "created_at")
	    private LocalDateTime createdAt;

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

		public Integer getDepartmentId() {
			return departmentId;
		}

		public void setDepartmentId(Integer departmentId) {
			this.departmentId = departmentId;
		}

		public String getStatusA() {
			return statusA;
		}

		public void setStatusA(String statusA) {
			this.statusA = statusA;
		}

		public LocalDateTime getCreatedAt() {
			return createdAt;
		}

		public void setCreatedAt(LocalDateTime createdAt) {
			this.createdAt = createdAt;
		}

		@Override
		public String toString() {
			return "Users [userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", passwordH="
					+ passwordH + ", phone=" + phone + ", departmentId=" + departmentId + ", statusA=" + statusA
					+ ", createdAt=" + createdAt + "]";
		}

		
	    
}
