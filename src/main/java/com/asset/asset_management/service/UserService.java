package com.asset.asset_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asset.asset_management.entity.Admin;
import com.asset.asset_management.entity.Department;
import com.asset.asset_management.entity.Users;
import com.asset.asset_management.repo.DepartmentRepo;
import com.asset.asset_management.repo.UserRepo;

import jakarta.transaction.Transactional;

@Service
public class UserService {

	@Autowired
	UserRepo userRepo;
	
	@Autowired
	DepartmentRepo deptRepo;

	public List<Users> findAll() {
		
		return userRepo.findAll();
	}

	public List<Users> search(String q) {
	
		return userRepo.findByfullName(q);
	}



	public Users addUser(Users user) {
		
		Department dep = deptRepo.findById(user.getDepartmentId()).get();
		user.setDepartment(dep);
		return userRepo.save(user);
		
	}

	public boolean validation(String email, String password) {
		Users uobj=userRepo.findByEmail(email);
		if(uobj==null)
		{
			return false;
		}
		System.out.println("");
		if(uobj.getPasswordH().equals(password))
		{
			return true;
		}
		return false;
	
	}

	public Users getUser(String email) {
		return userRepo.findByEmail(email);
	}
	
	public void deleteuser(int id)
	{
		userRepo.deleteById(id);
		
	}

	public List<Users> findByDepartment_DepartmentId(Integer departmentId) {
		
		return userRepo.findByDepartment_DepartmentId(departmentId);
	}
}
