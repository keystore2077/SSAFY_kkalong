package com.ssafy.kkalong.domain.photo.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.api.Result;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.domain.photo.dto.request.PhotoMixRequestReq;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoMixRequestRes;
import com.ssafy.kkalong.domain.photo.dto.response.PhotoRes;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.domain.photo.service.PhotoService;
import com.ssafy.kkalong.fastapi.FastApiService;
import com.ssafy.kkalong.fastapi.dto.FastApiRequestGeneralRes;
import com.ssafy.kkalong.fastapi.dto.RequestRembgRes;
import com.ssafy.kkalong.s3.S3Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.util.*;
import java.util.concurrent.CompletableFuture;

@RestController
@Slf4j
@RequestMapping("/api/photo")
public class PhotoController {
    @Autowired
    private S3Service s3Service;
    @Autowired
    private FastApiService fastApiService;
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
    public Api<Object> savePhotoOriginal(MultipartFile photoReq) {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        // 파일 유효성 검사
        if (photoReq == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "파일을 보내주십시오");
        }
        // 확장자 유효성 검사
        String extension = photoReq.getContentType();
        if (extension != null && !extension.equals("image/jpeg") && !extension.equals("image/jpg")){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효한 확장자가 아닙니다");
        }

        // key 생성
        // photo_소유자아이디_현재시간_무작위숫자6개
        String fileName = FileNameGenerator.generateFileNameNoExtension("photo", member.getMemberId());

        // 저장할 장소 지정
        String path = "photo/original/";

        // S3서버에 사진을 저장
        try {
            String res = s3Service.uploadFile(path + fileName + ".jpg", photoReq);
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.SERVER_ERROR, "업로드 실패");
        }
        //rembg 호출
        Api<Object> rembgRes = fastApiService.requestRembg(member.getMemberId(), photoReq);
        if (!Objects.equals(rembgRes.getResult().getResultCode(), Result.OK().getResultCode())){
            return Api.ERROR(ErrorCode.SERVER_ERROR, "내부 처리중 문제가 발생 했습니다.(Rembg)");
        }
        //rembg 결과 저장
        RequestRembgRes res;
        try{
            res = (RequestRembgRes)rembgRes.getBody();
            s3Service.uploadFile("photo/yes_bg/" + res.getYesBgName() + ".jpg", res.getYesBg());
            s3Service.uploadFile("photo/no_bg/" + res.getNoBgName() + ".png", res.getNoBg());
        } catch (Exception e) {
            return Api.ERROR(ErrorCode.SERVER_ERROR, "저장 중 문제가 발생 했습니다.(Rembg)");
        }
        System.out.println("rembg 완료");


        Photo photo = new Photo();
        photo.setMember(member);
        photo.setPhotoImgName(fileName);
        photo.setPhotoImgYesBg(true);
        photo.setPhotoImgNoBg(true);
        photo.setPhotoImgMasking(true);
        photo.setPhotoImgOpenpose(false);
        photo.setPhotoJsonOpenpose(false);

        // DB에 저장
        Photo photoResult = photoService.savePhoto(photo);

        try{
            return Api.OK("성공");
        } finally {
            callPreprocessing(member, photoResult).join();
        }
    }

    // 1. 사용자 인증 정보를 확인한다
    // 2. DB에서 사용자의 모든 사진 정보를 가져온다
    // 3. 사진별로 s3에서 사진용 url을 받아온다
    // 4. 반환한다
    @GetMapping("")
    @Operation(summary = "AI용 내 사진 리스트 조회")
    public Api<Object> getPhotoList() {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        // DB에서 사용자의 모든 삭제되지 않은 사진 정보 가져오기
        List<Photo> photoList = photoService.getPhotoList(member);

        // s3에서 사진별 url 가져오기
        List<PhotoRes> photoResList = new ArrayList<>();
        for(Photo p : photoList){
            String url = s3Service.generatePresignedUrl("photo/no_bg/" + p.getPhotoImgName() + ".png");
            PhotoRes pRes = PhotoRes.toRes(p, url);
            photoResList.add(pRes);
        }

        return Api.OK(photoResList);
    }

    // 1. 사용자의 인증 정보를 확인한다
    // 2. DB에서 해당 사진의 데이터를 가져온다.
    // 3. s3에서 사진의 url을 받아온다
    // 4. 반환한다.
    @GetMapping("/{photoSeq}")
    @Operation(summary = "AI용 특정 사진 조회")
    public Api<Object> getPhotoListBySeq(@PathVariable int photoSeq) {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        Photo photo = photoService.getPhotoBySeq(photoSeq);
        String url = s3Service.generatePresignedUrl("photo/no_bg/" + photo.getPhotoImgName() + ".png");
        PhotoRes photoRes = PhotoRes.toRes(photo, url);

        return Api.OK(photoRes);
    }

    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 해당 사진을 삭제됨을 1로 한다.
    // 3. 성공을 반환한다.
    @PutMapping("/{photoSeq}")
    @Operation(summary = "AI용 내 사진 삭제")
    public Api<Object> deletePhotoBySeq(@PathVariable int photoSeq) {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }
        // 사진 존재 유무 확인
        Photo photo = photoService.getPhotoBySeq(photoSeq);
        if (photo == null || photo.getMember().getMemberSeq() != member.getMemberSeq()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사진 정보입니다");
        }

        // 사진 삭제 요청
        if (!photoService.deletePhotoBySeq(photo)){
            return Api.ERROR(ErrorCode.DENIED_ERROR, "요청이 거부 되었습니다");
        }

        return Api.OK("성공");
    }

    // 1. 사용자의 인증정보를 확인한다.
    // 2. DB에서 전처리 여부를 확인한다.
    // 2.1. 전처리가 되어 있지 않다면 전처리 api를 호출하고 실패를 반환한다.
    // 3. viton를 호출한다.
    // 4. viton이 완료 되면 성공을 반환한다.
    @PostMapping("/mix")
    @Operation(summary = "합성 요청")
    public Api<Object> PhotoMixRequest(PhotoMixRequestReq req) {
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }
        // DB에서 전처리 여부 가져오기


        return Api.OK(new PhotoMixRequestRes());
    }

    private CompletableFuture<Void> callPreprocessing(Member member, Photo photo) {
        return CompletableFuture.allOf(
                callCihpAsync(member, photo),
                callOpenposeAsync(member, photo)
        );
    }

    private CompletableFuture<Void> callCihpAsync(Member member, Photo photo) {
        return CompletableFuture.runAsync(() -> {
            // cihp 호출
            callCihp(member, photo);
        });
    }

    private CompletableFuture<Void> callOpenposeAsync(Member member, Photo photo) {
        return CompletableFuture.runAsync(() -> {
            // Openpose 호출
            callOpenpose(member, photo);
        });
    }

    private void callOpenpose(Member member, Photo photo){
        // Openpose는 독자적인 과정을 거치므로 결과 저장 과정이 필요 없음
        try{
            Api<Object> openposeRes = fastApiService.requestOpenpose(member, photo);
            if (!openposeRes.getResult().equals(Result.OK())){
                System.out.println("내부 처리중 문제가 발생했습니다.(Openpose)");
            }
        } catch (Exception e) {
            System.out.println("저장중 문제가 발생했습니다.(Openpose)");
        }
    }

    private void callCihp(Member member, Photo photo){
        // s3에서 파일 가져오기
        byte[] byteFile = s3Service.downloadFile("photo/yes_bg/" + photo.getPhotoImgName() + ".jpg");

        Api<Object> cihpRes = fastApiService.requestCihp(member.getMemberId(), byteFile);
        if (!Objects.equals(cihpRes.getResult().getResultCode(), Result.OK().getResultCode())){
            System.out.println("내부 처리중 문제가 발생했습니다.(cihp)");
        }
        // cihp 결과 저장
        try{
            FastApiRequestGeneralRes cihpResBody = (FastApiRequestGeneralRes)cihpRes.getBody();
            s3Service.uploadFile("photo/masking/" + cihpResBody.getImgName() + ".png", cihpResBody.getImg());
        } catch (Exception e) {
            System.out.println("저장중 문제가 발생했습니다.(cihp)");
        }
        // DB 업데이트
        photoService.updatePhotoImgMasking(photo.getPhotoSeq());

        System.out.println("cihp 완료");
    }
}
