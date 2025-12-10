package com.asset.asset_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.Asset;

@Repository
public interface AssetRepo extends JpaRepository<Asset,Integer>{

	List<Asset> findByassetName(String assetName);
	
    @Query("SELECT a FROM Asset a WHERE a.statusA = :status")
    List<Asset> findByStatus(@Param("status") String status);

}
