package com.ssafy.kkalong.domain.social.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.domain.social.dto.request.FashionSaveReq;
import com.ssafy.kkalong.domain.social.entity.Fashion;
import com.ssafy.kkalong.domain.social.service.SocialService;
import com.ssafy.kkalong.s3.S3Service;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RequiredArgsConstructor
@RequestMapping("/api/social")
@RestController
@Slf4j
public class SocialController {
    private final MemberService memberService;
    private final SocialService socialService;
    private final S3Service s3Service;

    @Operation(summary = "팔로우 하기")
    @GetMapping("/follow/{nickName}")
    public Api<Object> followMember( @PathVariable String nickName){

        Member member = memberService.getLoginUserInfo();
        Member nickNameMember = memberService.checkNickName(nickName);

        if(member==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST,"로그인된 회원 정보를 찾지 못했습니다.");
        }
        if (nickNameMember==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        return Api.OK(socialService.followMember(member,nickNameMember));

    }

    @Operation(summary = "팔로우, 팔로잉 리스트 조회")
    @GetMapping("/follow/list/{nickName}")
    public Api<Object> getFollowList( @PathVariable String nickName){

        Member member = memberService.checkNickName(nickName);

        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        return Api.OK(socialService.getFollowList(member));

    }

    @Operation(summary = "팔로우 취소")
    @PutMapping("/follow/{nickName}")
    public Api<Object> deleteFollow( @PathVariable String nickName){
        Member loginMember = memberService.getLoginUserInfo();
        Member member = memberService.checkNickName(nickName);

        if(loginMember==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST,"로그인된 회원 정보를 찾지 못했습니다.");
        }
        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }
        socialService.deleteFollow(member,loginMember);
        return Api.OK("팔로우가 취소 되었습니다.");
    }

    @Operation(summary = "코디사진 저장")
    @PostMapping(value = "/save" )
    public Api<Object> saveFashion( @RequestBody  FashionSaveReq request) {
        Member member = memberService.getLoginUserInfo();

        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }
        System.out.println(request.toString());
        if(request.getImgName()==null || request.getImgName().isEmpty()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "이미지 이름 받지 못했습니다.");
        }

        if(request.getFashionName()==null || request.getFashionName().isEmpty()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "코디 이름 받지 못했습니다.");
        }
        String imgUrl= s3Service.copyTempToFashion(request.getImgName());
        String fileName=request.getImgName().replace("temp_", "fashion_") + ".jpg";

        return Api.OK(socialService.saveFashion(member, request, imgUrl,fileName ));
    }

    @Operation(summary = "코디 사진 잠금 설정")
    @PutMapping("/fashion/{fashionSeq}")
    public Api<Object> changePrivateFashion( @PathVariable int fashionSeq){
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        socialService.changePrivateFashion(member.getMemberSeq(),fashionSeq);
        return Api.OK("잠금설정이 변경되었습니다.");
    }

    @Operation(summary = "저장한 코디 사진 목록 조회")
    @GetMapping("/list/fashion/{nickName}")
    public Api<Object> getListFashion(@PathVariable String nickName){
        Member loginMember = memberService.getLoginUserInfo();
        if (loginMember == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        Member member = memberService.checkNickName(nickName);
        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }
        if(loginMember.getMemberNickname().equals(nickName)){
            return Api.OK(socialService.getMyListFashion(member.getMemberSeq()));
        }
        else{
            return Api.OK(socialService.getListFashion(member.getMemberSeq()));
        }



    }

    @Operation(summary = "옷 사진 목록 조회")
    @GetMapping("/list/cloth/{nickName}")
    public Api<Object> getListCloth( @PathVariable String nickName){
        Member loginMember = memberService.getLoginUserInfo();
        if (loginMember == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }
        Member member = memberService.checkNickName(nickName);
        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        if(loginMember.getMemberNickname().equals(nickName)){
            return Api.OK(socialService.getMyListCloth(member.getMemberSeq()));
        }
        else{
            return Api.OK(socialService.getListCloth(member.getMemberSeq()));
        }
    }

    @Operation(summary = "사용자 프로필 조회")
    @GetMapping("/{nickName}")
    public Api<Object> getProfile( @PathVariable String nickName){
        Member loginMember = memberService.getLoginUserInfo();
        if (loginMember == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }
        Member member = memberService.checkNickName(nickName);
        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        if(loginMember.getMemberNickname().equals(nickName)){
            return Api.OK(socialService.getMyProfile(member));
        }
        else{
            return Api.OK(socialService.getListProfile(member));
        }
    }

    @Operation(summary = "팔로우 상태인지 체크(팔로우 중이면 : true)")
    @GetMapping("/follow/check/{nickName}")
    public Api<Object> checkFollow( @PathVariable String nickName){
        Member loginMember = memberService.getLoginUserInfo();
        if (loginMember == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }
        Member member = memberService.checkNickName(nickName);
        if (member==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,String.format("해당 닉네임[%s]을/를 가진 회원을 찾지 못했습니다.", nickName));
        }

        return Api.OK(socialService.checkFollow(loginMember, member));
    }

    @Operation(summary = "코디 상세보기")
    @GetMapping("/fashion/{fashionSeq}")
    public Api<Object> getfashion( @PathVariable int fashionSeq){
        Member loginMember = memberService.getLoginUserInfo();
        if (loginMember == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }
        Fashion fashion = socialService.getFashion(fashionSeq,loginMember.getMemberSeq());
        if (fashion==null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,"코디 사진 정보를 찾을 수 없습니다.");
        }
        if (fashion.getMember().getMemberSeq()!=loginMember.getMemberSeq() && fashion.isFashionPrivate()) {
            return Api.ERROR(ErrorCode.BAD_REQUEST,"비공개 사진이거나 코디 사진 주인이 아닙니다.");
        }
        return Api.OK(socialService.getFashionInfo(fashion));
    }



}
