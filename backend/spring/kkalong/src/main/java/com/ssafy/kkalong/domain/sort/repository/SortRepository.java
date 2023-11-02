package com.ssafy.kkalong.domain.sort.repository;

import com.ssafy.kkalong.domain.sort.entity.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SortRepository extends JpaRepository<Sort, Integer> {
}
