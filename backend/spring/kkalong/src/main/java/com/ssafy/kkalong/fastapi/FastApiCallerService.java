package com.ssafy.kkalong.fastapi;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.api.Result;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.domain.photo.service.PhotoService;
import com.ssafy.kkalong.fastapi.dto.FastApiRequestGeneralRes;
import com.ssafy.kkalong.s3.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class FastApiCallerService {
    @Autowired
    private FastApiService fastApiService;

    @Autowired
    private S3Service s3Service;

    @Autowired
    private PhotoService photoService;

    @Async
    public void callOpenpose(Member member, Photo photo){
        System.out.println("callOpenpose called...");
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

    @Async
    public void callCihp(Member member, Photo photo){
        System.out.println("callCihp called...");
        System.out.println("요청 경로: photo/yes_bg/" + photo.getPhotoImgName() + ".jpg");
        // s3에서 파일 가져오기
        byte[] byteFile = s3Service.downloadFile("photo/yes_bg/" + photo.getPhotoImgName() + ".jpg");

        Api<Object> cihpRes = fastApiService.requestCihp(member.getMemberId(), byteFile);
        if (!Objects.equals(cihpRes.getResult().getResultCode(), Result.OK().getResultCode())){
            System.out.println("내부 처리중 문제가 발생했습니다.(cihp)");
        }
        // cihp 결과 저장
        try{
            FastApiRequestGeneralRes cihpResBody = (FastApiRequestGeneralRes)cihpRes.getBody();
            System.out.println("저장 경로: photo/masking/" + cihpResBody.getImgName() + ".png");
            s3Service.uploadFile("photo/masking/" + cihpResBody.getImgName() + ".png", cihpResBody.getImg());
        } catch (Exception e) {
            System.out.println("저장중 문제가 발생했습니다.(cihp)");
        }
        // DB 업데이트
        photoService.updatePhotoImgMasking(photo.getPhotoSeq());

        System.out.println("cihp 완료");
    }
}
