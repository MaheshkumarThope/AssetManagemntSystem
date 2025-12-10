package com.asset.asset_management.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.MaintananceRecord;

@Repository
public interface MaintananceRepo extends JpaRepository<MaintananceRecord,Integer>{

}
