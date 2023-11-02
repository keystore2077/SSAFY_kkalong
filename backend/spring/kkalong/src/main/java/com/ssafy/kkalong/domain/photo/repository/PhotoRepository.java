package com.ssafy.kkalong.domain.photo.repository;

import com.ssafy.kkalong.domain.photo.entity.Photo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PhotoRepository extends JpaRepository<Photo, Integer> {
}
