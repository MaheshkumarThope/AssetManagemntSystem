package com.asset.asset_management.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.Admin;
import com.asset.asset_management.entity.Allocation;
import com.asset.asset_management.entity.Users;

import jakarta.transaction.Transactional;

@Repository
public interface AllocationRepo extends JpaRepository<Allocation,Integer>{


    @Modifying
    @Transactional
    @Query("DELETE FROM Allocation a WHERE a.assetId = :assetId")
    void deleteByAssetId(@Param("assetId") int assetId);

	Allocation findByuserId(Integer userId);

	Allocation findByAssetId(Integer assetID);
}
