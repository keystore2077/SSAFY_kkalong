package com.ssafy.kkalong.domain.cloth.repository;

import com.ssafy.kkalong.domain.cloth.entity.TagRelation;
import com.ssafy.kkalong.domain.cloth.entity.TagRelationKey;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TagRelaionRepository extends JpaRepository<TagRelation, TagRelationKey> {
}
