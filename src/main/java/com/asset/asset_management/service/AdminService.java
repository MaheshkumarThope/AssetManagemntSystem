package com.asset.asset_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asset.asset_management.entity.Admin;
import com.asset.asset_management.repo.AdminRepo;

@Service
public class AdminService {
	
	@Autowired
	AdminRepo adminRepo;
	
	public List<Admin> getAllAdmins()
	{
		return adminRepo.findAll();
	}
	
	public boolean validation(String email,String password)
	{
		Admin aobj=adminRepo.findByEmail(email);
		if(aobj==null)
		{
			return false;
		}
		System.out.println("");
		if(aobj.getPassword_hash().equals(password))
		{
			return true;
		}
		return false;
	}
	
	public Admin getAdmin(String email)
	{
		return adminRepo.findByEmail(email);
	}
	



}
