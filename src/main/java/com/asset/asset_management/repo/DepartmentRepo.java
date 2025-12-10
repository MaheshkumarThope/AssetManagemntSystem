package com.asset.asset_management.repo;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.asset.asset_management.entity.Department;

@Repository
public interface DepartmentRepo extends JpaRepository<Department,Long>{



}
