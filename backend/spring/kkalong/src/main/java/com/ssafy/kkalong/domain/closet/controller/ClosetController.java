package com.ssafy.kkalong.domain.closet.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.domain.closet.dto.request.ClosetRequest;
import com.ssafy.kkalong.domain.closet.dto.response.ClosetResponse;
import com.ssafy.kkalong.domain.closet.dto.response.SectionResponse;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
//    @Autowired
//    private S3Service s3Service;

    //옷장 상세정보 및 소속구역 리스트 보기
    @GetMapping("/{closetSeq}")
    @Operation(summary = "옷장 상세정보 및 소속구역 리스트 보기")
    public Api<Object> getClosetDetail(@PathVariable int closetSeq ){
        //0.회원확인
        Member member = memberService.getLoginUserInfo();
        if(member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        //1.유효성검사를하기(옷장이있는지 확인하기)
        Closet closet = closetService.findCloset(closetSeq);
        if(closet == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지않은 옷장일련번호입니다!");
        }

        //2.찾은옷장이랑 옷장 주인이 맞는지,로그인된 회원이랑 옷장주인이 맞는지 확인하기
        int memberSeq = member.getMemberSeq();
        if (memberSeq != closet.getMember().getMemberSeq()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된회원이 옷장 소유주와 다릅니다!");
        }

        //3.리스트(섹션)가지고오기
        List<Section> sections = closetService.findSection(closetSeq);
        List<SectionResponse> result  = new ArrayList<>();
        for(Section section: sections){
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
    public Api<Object> getCloset(){
        Member member = memberService.getLoginUserInfo(); //멤버를 반환해주는거(서비스에서 작성된것)
        if(member == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
        }
        int memberSeq = member.getMemberSeq();  //멤버의 일련번호 받아오는 과정

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
    //회원확인하기
    //옷장이름저장
    //2.gpu서버에 사진변환 요청 keep
    //3.byte타입 array  이타입으로 반환byte[] 된걸 s3저장하고
    //db에 옷장저장, 그옷장에 해당 섹션저장
    //api ok반환

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


    @PostMapping("/rembg_req")
    @Operation(summary = "옷장 등록전 사진 배경제거")
    public Api<Object> postRembgReq(@RequestParam("file")MultipartFile file){
        //1.사진 유효성검사 (null,jpg,png)
        if (file.isEmpty() || (!file.getContentType().equalsIgnoreCase("image/jpg") &&
                !file.getContentType().equalsIgnoreCase("image/png"))) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "Invalid file type or empty file.");
        }
            // 2.gpu에 사진 변환 요청(누끼변환 요청
            // 미구현 기능임

//             3.변환한 파일 이름생성하는 로직 만들기
//              경로            도메인 아이디
//             photo/original/photo_tester_231103_135501_428746.jpg 이름생성 예시

            //member 유효성 검사 하기  완료
            Member member = memberService.getLoginUserInfo();
            if(member == null){
                return Api.ERROR(ErrorCode.BAD_REQUEST, "회원이아닙니다!");
            }

            String transformedImageName = FileNameGenerator.generateFileName("closet/original/", memberId, "jpg");

            // 4. 완료응답이오면
            // 5. S3서비스한테 있는 generatePresignedUrl 이 메서드한테 앞에서 생성한 파일이름 그거를 달라고 요청을하기
//            URL downloadUrl = s3Service.generatePresignedUrl("경로와 파일 이름과 확장자명까지 함꼐 보내주세요");

            // 6. 그걸 프론트에 보내기
//            return Api.OK(downloadUrl.toString());
                return Api.OK("https://kkalong.s3.ap-northeast-2.amazonaws.com/photo/original/photo_tester_231102_225259_947295.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231103T045441Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=AKIA5RRQZSI64T25QVH5%2F20231103%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=58ef1731664de948064f31bb8156457d81b0a03ccb61f60a1ba913528d48af84");

    }

}
