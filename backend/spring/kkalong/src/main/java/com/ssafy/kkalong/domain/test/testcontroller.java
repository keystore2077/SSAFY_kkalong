package com.ssafy.kkalong.domain.test;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.s3.S3Service;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileOutputStream;
import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/test")
public class testcontroller {
    @Autowired
    private S3Service s3Service;

    @Operation(summary = "test")
    @GetMapping("/test1")
    public Api<Object> testsever(){

        return Api.OK("test 성공");
    }

    @Operation(summary = "test 용")
    @GetMapping("/test2")
    public Api<Object> testsever2(){

        return Api.OK("test2 성공");
    }

    @PostMapping("/s3/test1")
    public Api<Object> testsever3(@RequestBody MultipartFile mFile){
        System.out.println("test1 called");
        String key = FileNameGenerator.generateFileName("photo/original/photo", "tester", "jpg");
        String res = null;
        try {
            res = s3Service.uploadFile(key, mFile);
        } catch (IOException e) {
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "업로드 실패");
        }
        return Api.OK(res);
    }

    @PostMapping("/s3/test2")
    public Api<Object> testsever4(){
        System.out.println(("test2 called"));
        byte[] byteCode = null;
        try{
            byteCode = s3Service.downloadFile("photo/original/photo_tester_231102_225259_947295.jpg");
            if (byteCode == null){
                return Api.ERROR(ErrorCode.SERVER_ERROR, "다운로드 실패");
            }
            FileOutputStream fos = new FileOutputStream("tester.jpg");
            fos.write(byteCode);
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        }

        return Api.OK("test2 성공");
    }

    @GetMapping("/s3/test3")
    public Api<Object> testsever5(@RequestParam String key){
        System.out.println("test3 called");
        try{
            return Api.OK(s3Service.generatePresignedUrl(key));
        } catch (Exception e){
            e.printStackTrace();
            return Api.ERROR((ErrorCode.BAD_REQUEST), "파일을 찾을 수 없습니다");
        }
    }
}
