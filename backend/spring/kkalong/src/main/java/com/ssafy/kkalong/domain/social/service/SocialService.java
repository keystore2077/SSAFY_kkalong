package com.ssafy.kkalong.domain.social.service;

import com.ssafy.kkalong.domain.cloth.dto.response.ClothRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.social.dto.request.FashionSaveReq;
import com.ssafy.kkalong.domain.social.dto.response.*;
import com.ssafy.kkalong.domain.social.entity.Fashion;

import java.util.List;

public interface SocialService {
    FollowRes followMember(Member member, Member nickNameMember);

    FollowListRes getFollowList(Member member);

    void deleteFollow(Member followingMember, Member followerMember);

    FashionSaveRes saveFashion(Member member, FashionSaveReq request, String imgUrl, String fileName);

    void changePrivateFashion(int memberSeq, int fashionSeq);

    List<FashionRes> getMyListFashion(int memberSeq);

    List<FashionRes> getListFashion(int memberSeq);

    MyClothRes getMyListCloth(int memberSeq);

    List<ClothRes> getListCloth(int memberSeq);

    MyProfileRes getMyProfile(Member member);

    ProfileRes getListProfile(Member member);

    boolean checkFollow(Member loginMember, Member member);

    Fashion getFashionBySeq(int fashionSeq);

    FashionInfoRes getFashionInfo(Fashion fashion);
}
