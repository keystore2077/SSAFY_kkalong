package com.ssafy.kkalong.domain.closet.repository;

import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ClosetRepository extends JpaRepository<Closet, Integer> {
    List<Closet> findByMemberMemberSeq(Integer memberSeq);


}
