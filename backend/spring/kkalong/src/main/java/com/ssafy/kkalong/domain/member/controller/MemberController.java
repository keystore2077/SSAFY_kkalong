package com.ssafy.kkalong.domain.member.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.domain.member.dto.request.SignInReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
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
        return Api.OK(memberService.getUserInfo());
    }

//    @Operation(summary = "Access Token 재발급")
//    @GetMapping("/verifyToken")
//    public Api<String> verifyToken(@RequestHeader("Authorization") String auth){
//        var result = tokenProvider.validateTokenAndGetSubject(auth);
//        return Api.OK(result);
//    }

}
