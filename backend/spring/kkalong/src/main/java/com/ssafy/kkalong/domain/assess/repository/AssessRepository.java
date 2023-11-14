package com.ssafy.kkalong.domain.assess.repository;

import com.ssafy.kkalong.domain.assess.entity.Assess;
import com.ssafy.kkalong.domain.assess.entity.AssessKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface AssessRepository  extends JpaRepository<Assess, AssessKey> {
    List<Assess> findByMemberMemberSeq(int memberSeq);
    Optional<Assess>findByAssessKey(AssessKey assessKey);
    @Query("SELECT a FROM Assess a WHERE a.fashion.fashionSeq = :fashionSeq AND a.isLike = :isLike")
    List<Assess> findByFashionFashionSeqAndIsLike(@Param("fashionSeq") int fashionSeq, @Param("isLike") boolean isLike);


}
