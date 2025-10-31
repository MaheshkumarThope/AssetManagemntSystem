package com.asset.asset_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asset.asset_management.entity.Users;
import com.asset.asset_management.repo.UserRepo;

@Service
public class UserService {

	@Autowired
	UserRepo userRepo;

	public List<Users> findAll() {
		
		return userRepo.findAll();
	}

	public List<Users> search(String q) {
		return userRepo.findByfullName(q);
	}
}
