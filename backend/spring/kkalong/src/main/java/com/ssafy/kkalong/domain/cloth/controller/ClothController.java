package com.ssafy.kkalong.domain.cloth.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.api.Result;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothSaveReq;
import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.service.ClothService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import com.ssafy.kkalong.domain.social.dto.request.FashionSaveReq;
import com.ssafy.kkalong.domain.sort.entity.Sort;
import com.ssafy.kkalong.domain.sort.service.SortService;
import com.ssafy.kkalong.fastapi.FastApiService;
import com.ssafy.kkalong.fastapi.dto.RequestRembgRes;
import com.ssafy.kkalong.s3.S3Service;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;

@RequiredArgsConstructor
@RequestMapping("/api/cloth")
@RestController
@Slf4j
public class ClothController {

    private final ClothService clothService;
    private final S3Service s3Service;
    private final MemberService memberService;
    private final ClosetService closetService;
    private final SortService sortService;
    private final FastApiService fastApiService;
    @Operation(summary = "옷 저장")
    @PostMapping(value = "" )
    public Api<Object> saveCloth(@RequestParam("mFile") MultipartFile file, @ModelAttribute ClothSaveReq request) {
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        System.out.println(request.toString());
        //sectionSeq 유효성 검사
        Section section = closetService.getSection(request.getSectionSeq());
        if (section == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷을 저장하려는 구역 정보를 찾지 못했습니다.");
        }
        else if (section.getCloset().getMember().getMemberId() != member.getMemberId()) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원은 옷을 저장하려는 구역의 주인이 아닙니다.");
        }

        //sortSeq 유효성 검사
        Sort sort = sortService.getSort(request.getSort());
        if (sort == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, String.format("[%s]은/는 유호하지 않는 옷 종류입니다. Top, Pants, Outer, Skirt, Dress, Etc 중에서 보내주세요.", request.getSort()));
        }

        String imgUrl="";
        String fileName="";
        if (!file.isEmpty()) {

            if ("jpg".equalsIgnoreCase(FilenameUtils.getExtension(file.getOriginalFilename()))) {
                //1.원본 사진 저장
                fileName= FileNameGenerator.generateFileNameNoExtension("cloth", member.getMemberId());

                String filePathOriginal = "cloth/original/" + fileName+".jpg";
                String filePathYesbg = "cloth/yes_bg/" + fileName+".jpg";
                String filePathNobg = "cloth/no_bg/" + fileName+".png";

                try {
                    s3Service.uploadFile(filePathOriginal, file);

                } catch (IOException e) {
                    return Api.ERROR(ErrorCode.BAD_REQUEST, "원본 사진 저장 중 오류가 발생하였습니다: ");
                }

                //rembg 호출
                Api<Object> rembgRes = fastApiService.requestRembg(member.getMemberId(), file);
                if (!Objects.equals(rembgRes.getResult().getResultCode(), Result.OK().getResultCode())){
                    return Api.ERROR(ErrorCode.SERVER_ERROR, "내부 처리중 문제가 발생했습니다.(Rembg)");
                }
                //rembg 결과 저장
                RequestRembgRes res;
                try{
                    res = (RequestRembgRes)rembgRes.getBody();
                    s3Service.uploadFile(filePathYesbg, res.getYesBg());
                    s3Service.uploadFile(filePathNobg, res.getNoBg());
                } catch (Exception e) {
                    return Api.ERROR(ErrorCode.SERVER_ERROR, "저장중중 문제가 발생했습니다.(Rembg)");
                }
                System.out.println("rembg 완료");

                imgUrl = s3Service.generatePresignedUrl(filePathNobg);
            }
            else {
                return Api.ERROR(ErrorCode.BAD_REQUEST, "jpg 파일 형식만 등록 가능합니다.");
            }
        } else {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "업로드된 파일이 없습니다.");
        }

        return Api.OK(clothService.saveCloth(member, section, sort, request, imgUrl,fileName ));
    }

//    @Operation(summary = "옷 상세정보")
//    @PostMapping(value = "/{clothSeq}" )
//    public Api<Object> getCloth(@PathVariable int clothSeq) {
//        Member member = memberService.getLoginUserInfo();
//        if (member == null) {
//            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
//        }
//
//        Cloth cloth =
//
//    }


}
