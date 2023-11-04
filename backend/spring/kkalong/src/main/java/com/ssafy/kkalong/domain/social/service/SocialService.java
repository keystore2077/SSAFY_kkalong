package com.ssafy.kkalong.domain.social.service;

import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.social.dto.response.FollowListRes;
import com.ssafy.kkalong.domain.social.dto.response.FollowRes;
import com.ssafy.kkalong.domain.social.entity.Follow;
import com.ssafy.kkalong.domain.social.entity.FollowKey;
import com.ssafy.kkalong.domain.social.repository.FollowRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class SocialService {
    private final FollowRepository followRepository;

    public FollowRes followMember(Member followingMember, Member followerMember){
        FollowKey followKey =FollowKey.builder()
                .followingMemberSeq(followingMember.getMemberSeq())
                .followerMemberSeq(followerMember.getMemberSeq())
                .build();

        Follow follow = Follow.builder()
                .followId(followKey)
                .regDate(LocalDateTime.now())
                .followingMember(followingMember)
                .followerMember(followerMember)
                .build();

        return FollowRes.toRes(followRepository.save(follow));

    }

    public FollowListRes getFollowList(Member member){
        //찾을 려는 회원을 구독한 회원 닉네임 리스트
        List<String> followingList = new ArrayList<>();
        List<Follow> following = followRepository.findAllByFollowerMemberMemberSeqAndIsFollowDeleted(member.getMemberSeq(),false);

        for(Follow follow : following){
            followingList.add(follow.getFollowingMember().getMemberNickname());
        }

        //찾을 려는 회원이 구독한 회원 닉네임 리스트
        List<String> followerList = new ArrayList<>();
        List<Follow> follower = followRepository.findAllByFollowingMemberMemberSeqAndIsFollowDeleted(member.getMemberSeq(),false);
        for(Follow follow : follower){
            followerList.add(follow.getFollowerMember().getMemberNickname());
        }

        return FollowListRes.builder()
                .ownerMemberNickName(member.getMemberNickname())
                .followingList(followingList)
                .followerList(followerList)
                .build();

    }
}
