package com.ssafy.kkalong.domain.closet.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.domain.closet.dto.request.ClosetRequest;
import com.ssafy.kkalong.domain.closet.dto.response.ClosetResponse;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    @Operation(summary = "옷장 상세정보 및 소속구역 리스트 보기")
    public Api<Object> getClosetDetail(@PathVariable int closetSeq ){

        return Api.OK("옷장하나 조회");

    }


    @GetMapping("")
    @Operation(summary = "옷장 목록 보기")
    public Api<Object> getCloset(){
        Member member = memberService.getLoginUserInfo(); //멤버를 반환해주는거
        if(member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        Integer memberSeq = member.getMemberSeq();  //멤버의 일련번호 받아오는 과정

        List<Closet> closets = closetService.findClosetsByMemberSeq(memberSeq); //이게 클로셋 리스폰스
        List<ClosetResponse> result  = new ArrayList<>();       //클로젯의 리스트 반환해줄 리스트

        for(Closet closet : closets){
//            String url = closet.getClosetImgName();  //이부분 수정해야함 개행
            String url = "String";
            ClosetResponse closetResponse = ClosetResponse.builder()
                    .closetSeq(closet.getClosetSeq())       //옷장인덱스
                    .closetName(closet.getClosetName())     //옷장이름
                    .closetPictureUrl(url)      //옷장사진 url
                    .build();
            result.add(closetResponse);
        }
        return Api.OK(result);

    }

    @PostMapping("")
    @Operation(summary = "옷장 등록")
    public Api<Object> postCloset(@RequestBody Map<String, String> closet){
        return Api.OK("이건 서비스에서 return된 값");
    }

    // 옷장 삭제
    @PutMapping("/{closetSeq}")
    @Operation(summary = "옷장 삭제")
    public Api<Object> deleteCloset(@PathVariable int closetSeq ){
        return Api.OK("옷장 삭제");

    }

    // 옷장 정보 수정
    @PutMapping("")
    @Operation(summary = "옷장 정보 수정")
    public Api<Object> putCloset(@RequestBody ClosetRequest closetRename){
        return Api.OK("옷장 정보 수정");
    }

}
