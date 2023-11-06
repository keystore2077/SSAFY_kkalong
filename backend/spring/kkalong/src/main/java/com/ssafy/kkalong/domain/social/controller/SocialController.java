package com.ssafy.kkalong.domain.social.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.domain.member.dto.response.MemberInfoRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.domain.social.service.SocialService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/api/social")
@RestController
@Slf4j
public class SocialController {
    private final MemberService memberService;
    private final SocialService socialService;

    @Operation(summary = "팔로우 하기")
    @GetMapping("/follow/{nickName}")
    public Api<Object> followMember( @PathVariable String nickName){

        Member followingMember = memberService.getLoginUserInfo();//구독자
        Member followerMember = memberService.checkNickName(nickName);//유튜버

        if(followingMember==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST,"로그인된 회원 정보를 찾지 못했습니다.");
        }
        if (followerMember==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        return Api.OK(socialService.followMember(followingMember,followerMember));

    }

    @Operation(summary = "팔로우, 팔로잉 리스트 조회")
    @GetMapping("/follow/list/{nickName}")
    public Api<Object> getFollowList( @PathVariable String nickName){

        Member member = memberService.checkNickName(nickName);//유튜버

        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        return Api.OK(socialService.getFollowList(member));

    }

    @Operation(summary = "팔로우 취소")
    @PutMapping("/follow/{nickName}")
    public Api<Object> deleteFollow( @PathVariable String nickName){
        Member followingMember = memberService.getLoginUserInfo();//구독자
        Member followerMember = memberService.checkNickName(nickName);//유튜버

        if(followingMember==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST,"로그인된 회원 정보를 찾지 못했습니다.");
        }
        if (followerMember==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }
        socialService.deleteFollow(followingMember,followerMember);
        return Api.OK("팔로우가 취소 되었습니다.");
    }
}
