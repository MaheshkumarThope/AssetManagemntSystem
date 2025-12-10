package com.asset.asset_management.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="admin")
public class Admin {
	
	@OneToMany(mappedBy = "allocatedBy")
	private List<Allocation> allocationsMade = new ArrayList<>();
	
	@OneToMany(mappedBy = "processedBy")
	private List<Request> processedRequests = new ArrayList<>();
	
	@Id
	@GeneratedValue
	private int admin_id;

	@Override
	public String toString() {
		return "Admin [admin_id=" + admin_id + ", full_name=" + full_name + ", email=" + email + ", password_hash="
				+ password_hash + ", phone=" + phone + "]";
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword_hash() {
		return password_hash;
	}
	public void setPassword_hash(String password_hash) {
		this.password_hash = password_hash;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	private String full_name;
	private String email;
	private String password_hash;
	private String phone;
}
