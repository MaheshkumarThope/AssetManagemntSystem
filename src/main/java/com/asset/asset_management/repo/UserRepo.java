package com.asset.asset_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.asset.asset_management.entity.Users;

public interface UserRepo extends JpaRepository<Users,Integer>{
	
	List<Users> findByfullName(String name);

	Users findByEmail(String email);
	
	List<Users> findByDepartment_DepartmentId(Integer departmentId);
	

	
	

}
