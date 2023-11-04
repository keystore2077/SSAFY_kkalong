package com.ssafy.kkalong.domain.social.repository;

import com.ssafy.kkalong.domain.social.entity.Follow;
import com.ssafy.kkalong.domain.social.entity.FollowKey;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface  FollowRepository extends JpaRepository <Follow, FollowKey> {
    //Optional<Follow> findByFollowingMemberSeqAndFollowerMemberSeq(int followerId, int followeeId);
    List<Follow> findAllByFollowingMemberMemberSeqAndIsFollowDeleted(int followeeId, boolean isDeleted);
    List<Follow> findAllByFollowerMemberMemberSeqAndIsFollowDeleted(int followeeId, boolean isDeleted);

}
