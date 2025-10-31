package com.asset.asset_management.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.Admin;

@Repository
public interface AdminRepo extends JpaRepository<Admin,Integer>{
	
	Admin findByEmail(String email);


}
