package com.ssafy.kkalong.domain.member.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.domain.member.dto.request.SignInReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
import com.ssafy.kkalong.domain.member.dto.response.MemberInfoRes;
import com.ssafy.kkalong.domain.member.dto.response.SignInRes;
import com.ssafy.kkalong.domain.member.dto.response.SignUpRes;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.security.TokenProvider;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/api/member")
@RestController
@Slf4j
public class MemberController {

    private final MemberService memberService;
    private final TokenProvider tokenProvider;

    @Operation(summary = "회원가입")
    @PostMapping("/sign-up")
    public Api<Object> signUp(@RequestBody SignUpReq request){
        //닉네임 체크
        String nickName = request.getMemberNickname();
        String nickNameRegex = "^[a-zA-Z가-힣0-9]{2,10}$";
        if(!nickName.matches(nickNameRegex)){
            return Api.ERROR(ErrorCode.BAD_REQUEST, String.format("[nickName]닉네임은 유요하지 않습니다. 영어와 한글, 숫자만 가능하고 최소 2자에서 10자로 작성해주세요", nickName));
        }

        String memberId = request.getMemberId();
        String IdRegex = "^(?=.*[a-zA-Z])[a-zA-Z0-9]{5,20}$";

        if(!memberId.matches(IdRegex)){
            return Api.ERROR(ErrorCode.BAD_REQUEST, String.format("[memberId]아이디는 유요하지 않습니다. 영어와 한글, 숫자만 가능하고 최소 2자에서 10자로 작성해주세요", memberId));
        }


        //아이디
        //비밀 번호
        //이메일
        //전화번호
        //성별
        //생년
        return Api.OK(memberService.registMember(request));
    }
    @Operation(summary = "회원 로그인")
    @PostMapping("/login")
    public Api<Object> signIn(@RequestBody SignInReq request ){
        return Api.OK(memberService.signIn(request));
    }

    @Operation(summary = "회원 정보 조회")
    @GetMapping("")
    public Api<Object> getmember( ){
        return Api.OK(MemberInfoRes.toRes(memberService.getLoginUserInfo()));
    }

    @Operation(summary = "아이디 중복확인 : 중복이면 false")
    @GetMapping("/id/{memberId}")
    public Api<Object> checkId(@PathVariable String memberId){
        return Api.OK(memberService.checkId(memberId));
    }

    @Operation(summary = "닉네임 중복확인 : 중복이면 false")
    @GetMapping("/nickname/{nickName}")
    public Api<Object> checkNickName(@PathVariable String nickName){
        return Api.OK(memberService.checkNickName(nickName));
    }



//    @Operation(summary = "Access Token 재발급")
//    @GetMapping("/verifyToken")
//    public Api<String> verifyToken(@RequestHeader("Authorization") String auth){
//        var result = tokenProvider.validateTokenAndGetSubject(auth);
//        return Api.OK(result);
//    }

}
