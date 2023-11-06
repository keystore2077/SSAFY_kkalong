package com.ssafy.kkalong.domain.social.service;

import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.social.dto.request.FashionSaveReq;
import com.ssafy.kkalong.domain.social.dto.response.FashionRes;
import com.ssafy.kkalong.domain.social.dto.response.FashionSaveRes;
import com.ssafy.kkalong.domain.social.dto.response.FollowListRes;
import com.ssafy.kkalong.domain.social.dto.response.FollowRes;
import com.ssafy.kkalong.domain.social.entity.Fashion;
import com.ssafy.kkalong.domain.social.entity.Follow;
import com.ssafy.kkalong.domain.social.entity.FollowKey;
import com.ssafy.kkalong.domain.social.repository.FashionRepository;
import com.ssafy.kkalong.domain.social.repository.FollowRepository;
import com.ssafy.kkalong.s3.S3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class SocialService {
    private final FollowRepository followRepository;
    private final FashionRepository fashionRepository;

    private final S3Service s3Service;

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

    public void deleteFollow(Member followingMember, Member followerMember){
        int followingSeq = followingMember.getMemberSeq();
        int followerSeq = followerMember.getMemberSeq();
        Optional<Follow> optionalValue = followRepository.findByFollowingMemberMemberSeqAndFollowerMemberMemberSeqAndIsFollowDeleted(followingSeq,followerSeq, false);
        optionalValue.ifPresentOrElse(
                value -> {
                    // Optional이 비어있지 않을 때 로직 수행
                    Follow follow =  optionalValue.get();
                    follow.setFollowDelDate(LocalDateTime.now());
                    follow.setFollowDeleted(true);
                    followRepository.save(follow);
                },
                () -> {
                    throw new NoSuchElementException("팔로우 내역을 찾을 수 없습니다.");
                }
        );
    }

    public FashionSaveRes saveFashion(Member member, FashionSaveReq request,String imgUrl,String fileName) {
        Fashion fashion = Fashion.builder()
                .fashionName(request.getFashionName())
                .fashionImgName(fileName)
                .isAi(request.isAi())
                .isFashionPrivate(request.isFashionPrivate())
                .fashionRegDate(LocalDateTime.now())
                .member(member)
                .build();

        return FashionSaveRes.toRes(fashionRepository.save(fashion),imgUrl);
    }

    public void changePrivateFashion(int memberSeq, int fashionSeq){

        Optional<Fashion> optionalValue = fashionRepository.findByFashionSeqAndMemberMemberSeqAndIsFashionDeleted(fashionSeq, memberSeq,false);
        optionalValue.ifPresentOrElse(value -> {
                    // Optional이 비어있지 않을 때 로직 수행
                    boolean prePrivate = value.isFashionPrivate();
                    value.setFashionPrivate(!prePrivate);
                    fashionRepository.save(value);
                },
                () -> {
                    throw new NoSuchElementException("사진을 찾을 수 없습니다.");
                }
        );
    }

    public List<FashionRes> getListFashion(int memberSeq){
        List<FashionRes>result = new ArrayList<>();
        List<Fashion> fashionList = fashionRepository.findAllByMemberMemberSeqAndIsFashionDeleted(memberSeq,false);
        for(Fashion fashion : fashionList){
            String imgUrl = s3Service.generatePresignedUrl("fashion/" + fashion.getFashionImgName());
            FashionRes fashionRes = FashionRes.toRes(fashion,imgUrl );
            result.add(fashionRes);
        }
        return result;
    }

}
