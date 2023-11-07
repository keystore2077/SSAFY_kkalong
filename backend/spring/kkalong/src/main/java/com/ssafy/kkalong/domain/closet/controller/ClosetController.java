package com.ssafy.kkalong.domain.closet.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.closet.dto.request.ClosetCreateRequest;
import com.ssafy.kkalong.domain.closet.dto.request.ClosetRequest;
import com.ssafy.kkalong.domain.closet.dto.response.ClosetRembgResponse;
import com.ssafy.kkalong.domain.closet.dto.response.ClosetResponse;
import com.ssafy.kkalong.domain.closet.dto.response.SectionResponse;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.s3.S3Service;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/api/closet")
public class ClosetController {
    //    http://localhost:8761/api/closet
    @Autowired
    private ClosetService closetService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private S3Service s3Service;

    //옷장 상세정보 및 소속구역 리스트 보기
    @GetMapping("/{closetSeq}")
    @Operation(summary = "옷장 상세정보 및 소속구역 리스트 보기")
    public Api<Object> getClosetDetail(@PathVariable int closetSeq) {
        //0.회원확인
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        //1.유효성검사를하기(옷장이있는지 확인하기)
        Closet closet = closetService.findCloset(closetSeq);
        if (closet == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지않은 옷장일련번호입니다!");
        }

        //2.찾은옷장이랑 옷장 주인이 맞는지,로그인된 회원이랑 옷장주인이 맞는지 확인하기
        int memberSeq = member.getMemberSeq();
        if (memberSeq != closet.getMember().getMemberSeq()) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된회원이 옷장 소유주와 다릅니다!");
        }

        //3.리스트(섹션)가지고오기
        List<Section> sections = closetService.findSection(closetSeq);
        List<SectionResponse> result = new ArrayList<>();
        for (Section section : sections) {
            SectionResponse sectionResponse = SectionResponse.builder()
                    .sectionSeq(section.getSectionSeq())
                    .sectionName(section.getSectionName())
                    .sortSeq(section.getSort().getSortSeq())
                    .sort(section.getSort().getSort())
                    .build();
            result.add(sectionResponse);

        }
        return Api.OK(result);

    }


    @GetMapping("")
    @Operation(summary = "옷장 목록 보기")
    public Api<Object> getCloset() {
        Member member = memberService.getLoginUserInfo(); //멤버를 반환해주는거(서비스에서 작성된것)
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        int memberSeq = member.getMemberSeq();  //멤버의 일련번호 받아오는 과정

        List<Closet> closets = closetService.findClosetsByMemberSeq(memberSeq); //이게 클로셋 리스폰스
        List<ClosetResponse> result = new ArrayList<>();       //클로젯의 리스트 반환해줄 리스트

        for (Closet closet : closets) {
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
    public Api<Object> postCloset(@RequestBody ClosetCreateRequest closetCreateRequest) {
        //1.회원확인하기
        Member member = memberService.getLoginUserInfo(); //멤버를 반환해주는거(서비스에서 작성된것)
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        int memberSeq = member.getMemberSeq();  //멤버의 일련번호 받아오는 과정
        Closet newCloset = closetService.createCloset(closetCreateRequest, member); //closetSeq 를 저장 할라고
        closetService.createSection(closetCreateRequest.getClosetSectionList(), newCloset);

        return Api.OK("이건 서비스에서 return된 값");
    }

    //2.db에다가 옷장을 추가하고 옷장의 오토 인크리먼트가 된 pk를 가져와야함

    //3.byte타입 array  이타입으로 반환byte[] 된걸 s3저장하고
    //db에 옷장저장, 그옷장에 해당 섹션저장
    //api ok반환




    @PostMapping("/rembg_req")
    @Operation(summary = "옷장 등록전 사진 배경제거")
    public Api<Object> postRembgReq(@RequestBody MultipartFile file) {
        //1.사진 유효성검사 (null,jpg,png)
        if (file.isEmpty() || (!file.getContentType().equalsIgnoreCase("image/jpg") &&
                !file.getContentType().equalsIgnoreCase("image/png"))) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "Invalid file type or empty file.");
        }
        // 2.gpu에 사진 변환 요청(누끼변환 요청)
        
        // 여기서붙터
        File convFile = new File(Objects.requireNonNull(file.getOriginalFilename()));
        // 임시 파일을 삭제하도록 설정합니다. 프로그램 종료 시 삭제됩니다.
        convFile.deleteOnExit();
        // MultipartFile의 내용을 임시 파일로 복사합니다.
        try {
            file.transferTo(convFile);
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "파이썬 맛감!");
        }
        //여기까지는 임시코드. FastApiService 기능 완성하면 바꿀것

        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        //파일 이름 생성 로직을 호출
        String transformedImageName = FileNameGenerator.generateFileName("closet/original/", member.getMemberId(), "jpg");

        // 4. 완료응답이오면
        // 5. S3서비스한테 있는 generatePresignedUrl 이 메서드한테 앞에서 생성한 파일이름 그거를 달라고 요청을하기
//            String downloadUrl = s3Service.generatePresignedUrl("경로와 파일 이름과 확장자명까지 함꼐 보내주세요");
        // 아래 경로는 임시입니다
        String downloadUrl = s3Service.generatePresignedUrl("photo/original/photo_tester_231103_145931_789464.jpg");

        // 6. 그걸 프론트에 보내기
        return Api.OK(new ClosetRembgResponse(transformedImageName,downloadUrl));

    }

    // 옷장 삭제
    @PutMapping("/{closetSeq}")
    @Operation(summary = "옷장 삭제")
    public Api<Object> deleteCloset(@PathVariable int closetSeq) {
        return Api.OK("옷장 삭제");

    }

    // 옷장 정보 수정
    @PutMapping("")
    @Operation(summary = "옷장 정보 수정")
    public Api<Object> putCloset(@RequestBody ClosetRequest closetRename) {
        return Api.OK("옷장 정보 수정");
    }

}
