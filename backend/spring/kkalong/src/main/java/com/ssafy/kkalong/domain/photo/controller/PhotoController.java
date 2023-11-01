package com.ssafy.kkalong.domain.photo.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.domain.photo.dto.request.PhotoMixRequestReq;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoMixRequestRes;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoRes;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoGeneralRes;
import com.ssafy.kkalong.domain.photo.service.PhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/photo")
public class PhotoController {
    @Autowired
    private PhotoService photoService;

    // AI용 원본 사진 저장
    // 1. 사용자 인증 정보를 확인한다.
    // 2. 사진을 저장한다.
    // 3. Rembg를 호출한다.
    // 4. 성공을 반환한다.
    @PostMapping("")
    public Api<PhotoGeneralRes> savePhotoOriginal(){
//        return new PhotoGeneralRes("성공");
        return new Api<>();
    }

    // AI용 내 사진 리스트 조회
    // 1. 사용자 인증 정보를 확인한다
    // 2. DB에서 사용자의 모든 사진 정보를 가져온다
    // 3. 사진별로 s3에서 사진용 url을 받아온다
    // 4. 반환한다
    @GetMapping("")
    public List<PhotoRes> getPhotoList(){
        return new ArrayList<PhotoRes>();
    }

    // AI용 특정 사진 조회
    // 1. 사용자의 인증 정보를 확인한다
    // 2. DB에서 해당 사진의 데이터를 가져온다.
    // 3. s3에서 사진의 url을 받아온다
    // 4. 반환한다.
    @GetMapping("/{photoSeq}")
    public PhotoRes getPhotoListBySeq(@PathVariable int photoSeq){
        return new PhotoRes();
    }

    // AI용 내 사진 삭제
    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 해당 사진을 삭제됨을 1로 한다.
    // 3. 성공을 반환한다.
    @PutMapping("/{photoSeq}")
    public PhotoGeneralRes deletePhotoBySeq(@PathVariable int photoSeq){
        return new PhotoGeneralRes("성공");
    }

    // 합성 요청
    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 전처리 여부를 확인한다.
    // 2.1. 전처리가 되어 있지 않다면 전처리 api를 호출하고 실패를 반환한다.
    // 3. viton를 호출한다.
    // 4. viton이 완료 되면 성공을 반환한다.
    @PostMapping("/mix")
    public PhotoMixRequestRes PhotoMixRequest(@RequestBody PhotoMixRequestReq req){
        return new PhotoMixRequestRes();
    }
}
