package com.asset.asset_management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asset.asset_management.entity.Asset;
import com.asset.asset_management.entity.Users;
import com.asset.asset_management.repo.AssetRepo;

import jakarta.transaction.Transactional;

@Service
public class AssetService {
	
	@Autowired
	AssetRepo assetRepo;

	public List<Asset> search(String q) {

		return assetRepo.findByassetName(q);
	}


	public List<Asset> findAll() {
		return assetRepo.findAll();
	}

	

	

}
