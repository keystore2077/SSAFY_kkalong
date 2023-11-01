package com.ssafy.kkalong.domain.closet.controller;

import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api/closet")
public class ClosetController {
//    http://localhost:8761/api/closet

    //옷장 상세정보 및 소속구역 리스트 보기
    @GetMapping("/{closetSeq}")
    public String closetSeq(@PathVariable int closetSeq ){
        System.out.println("sdf");
        return closetSeq+"";
    }

    //옷장 목록 보기
    @GetMapping("")
    public String getCloset(){
        return "모든 옷장조회";
    }

    // 옷장 등록   서비스에서는 closet이라는 값을 넘겨야함
    @PostMapping("")
    public String postCloset(@RequestBody Map<String, String> closet){
        return "이건 서비스에서 return된 값";
    }

    // 옷장 삭제
    @PutMapping("/{closetID}")
    public String deleteCloset(@PathVariable int closetID){
        return "옷장 삭제";
    }

    // 옷장 정보 수정
    @PutMapping("")
    public String putCloset(){
        return "옷장 정보 수정";
    }

}
