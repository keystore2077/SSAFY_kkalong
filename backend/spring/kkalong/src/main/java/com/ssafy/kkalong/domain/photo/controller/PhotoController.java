package com.ssafy.kkalong.domain.photo.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.domain.photo.dto.request.PhotoMixRequestReq;
import com.ssafy.kkalong.domain.photo.dto.request.SavePhotoOriginalReq;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoMixRequestRes;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoRes;
import com.ssafy.kkalong.domain.photo.service.PhotoService;
import com.ssafy.kkalong.s3.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.util.StringUtils;
import io.swagger.v3.oas.annotations.Operation;


import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/api/photo")
public class PhotoController {
    @Autowired
    private S3Service s3Service;
    @Autowired
    private MemberService memberService;
    @Autowired
    private PhotoService photoService;

    // 1. 사용자 인증 정보를 확인한다.
    // 2. 사진을 저장한다.
    // 3. Rembg를 호출한다.
    // 4. 성공을 반환한다.
    @PostMapping("")
    @Operation(summary = "AI용 원본 사진 저장")
    public Api<Object> savePhotoOriginal(@RequestBody SavePhotoOriginalReq photo) {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        // 파일 유효성 검사
        if (photo == null || photo.getFile() == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "파일을 보내주십시오");
        }
        // 확장자 유효성 검사
        String extension = photo.getFile().getContentType();;
        if (extension != null && !extension.equals("jpg") && !extension.equals("png")){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효한 확장자가 아닙니다");
        }

        // key 생성
        // photo_소유자아이디_현재시간_무작위숫자6개
        String fileName = FileNameGenerator.generateFileName("photo", member.getMemberId(), "jpg");

        // 저장할 장소 지정
        String path = "photo/original/";

        // S3서버에 사진을 저장
        try {
            String res = s3Service.uploadFile(path + fileName, photo.getFile());
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.SERVER_ERROR, "업로드 실패");
        }
        return Api.OK("성공");
    }

    // 1. 사용자 인증 정보를 확인한다
    // 2. DB에서 사용자의 모든 사진 정보를 가져온다
    // 3. 사진별로 s3에서 사진용 url을 받아온다
    // 4. 반환한다
    @GetMapping("")
    @Operation(summary = "AI용 내 사진 리스트 조회")
    public Api<Object> getPhotoList() {
        return Api.OK(new ArrayList<PhotoRes>());
    }

    // 1. 사용자의 인증 정보를 확인한다
    // 2. DB에서 해당 사진의 데이터를 가져온다.
    // 3. s3에서 사진의 url을 받아온다
    // 4. 반환한다.
    @GetMapping("/{photoSeq}")
    @Operation(summary = "AI용 특정 사진 조회")
    public Api<Object> getPhotoListBySeq(@PathVariable int photoSeq) {
        return Api.OK(new PhotoRes());
    }

    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 해당 사진을 삭제됨을 1로 한다.
    // 3. 성공을 반환한다.
    @PutMapping("/{photoSeq}")
    @Operation(summary = "AI용 내 사진 삭제")
    public Api<Object> deletePhotoBySeq(@PathVariable int photoSeq) {
        return Api.OK("성공");
    }

    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 전처리 여부를 확인한다.
    // 2.1. 전처리가 되어 있지 않다면 전처리 api를 호출하고 실패를 반환한다.
    // 3. viton를 호출한다.
    // 4. viton이 완료 되면 성공을 반환한다.
    @PostMapping("/mix")
    @Operation(summary = "합성 요청")
    public Api<Object> PhotoMixRequest(@RequestBody PhotoMixRequestReq req) {
        return Api.OK(new PhotoMixRequestRes());
    }
}
