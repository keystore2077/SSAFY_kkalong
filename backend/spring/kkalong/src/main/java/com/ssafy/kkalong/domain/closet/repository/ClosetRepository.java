package com.ssafy.kkalong.domain.closet.repository;

import com.ssafy.kkalong.domain.closet.entity.Closet;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
//db연동

public interface ClosetRepository extends JpaRepository<Closet, Integer> {
    List<Closet> findAllByMemberMemberSeq(int member);

    Optional<Closet> findByClosetSeqAndIsClosetDeleted(int closetSeq, boolean isDeleted);
}
