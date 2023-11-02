package com.ssafy.kkalong.domain.closet.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.domain.closet.dto.request.ClosetRequest;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api/closet")
public class ClosetController {
//    http://localhost:8761/api/closet
    @Autowired
    private ClosetService closetService;

    @Autowired
    private MemberService memberService;


    //옷장 상세정보 및 소속구역 리스트 보기
    @GetMapping("/{closetSeq}")
    public Api<Object> closetSeq(@PathVariable int closetSeq ){
        Member member = memberService.getLoginUserInfo(); //멤버를 반환해주는거
        Integer memberSeq = member.getMemberSeq();  //멤버의 일련번호 받아오는 과정

        List<Closet> closets = closetService.findClosetsByMemberSeq(memberSeq);

        return Api.OK(closets);

    }

    //옷장 목록 보기
    @GetMapping("")
    public Api<Object> getCloset(){

        return Api.OK("모든옷장 조회");
    }

    // 옷장 등록   서비스에서는 closet이라는 값을 넘겨야함
    @PostMapping("")
    public Api<Object> postCloset(@RequestBody Map<String, String> closet){
        return Api.OK("이건 서비스에서 return된 값");
    }

    // 옷장 삭제
    @PutMapping("/{closetSeq}")
    public Api<Object> deleteCloset(@PathVariable int closetSeq ){
        return Api.OK("옷장 삭제");

    }

    // 옷장 정보 수정
    @PutMapping("")
    public Api<Object> putCloset(@RequestBody ClosetRequest closetRename){
        return Api.OK("옷장 정보 수정");
    }

}
