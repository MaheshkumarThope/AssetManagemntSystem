package com.asset.asset_management.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.Request;

@Repository
public interface RequestRepo extends JpaRepository<Request,Integer>{

	List<Request> findByUser_UserId(int userId);
	
	@Query("SELECT COUNT(r) FROM Request r WHERE r.statusH = 'Pending'")
	int countPendingRequests();
}
