package com.ssafy.kkalong.domain.cloth.repository;

import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ClothRepository extends JpaRepository<Cloth, Integer> {

    List<Cloth> findAllByMemberMemberSeqAndIsClothDeleted(int memberSeq, boolean isDeleted);

    List<Cloth> findAllByMemberMemberSeqAndIsClothDeletedAndIsPrivate(int memberSeq, boolean isDeleted, boolean isPrivate);
}
