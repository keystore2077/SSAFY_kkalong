package com.ssafy.kkalong.domain.cloth.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.api.Result;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.service.ClosetService;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothSaveReq;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothUpdateReq;
import com.ssafy.kkalong.domain.cloth.dto.response.ClothSaveRes;
import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.entity.Tag;
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
import java.util.List;
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

        //sectionSeq 유효성 검사
        Section section = closetService.getSection(request.getSectionSeq());
        if (section == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷을 저장하려는 구역 정보를 찾지 못했습니다.");
        }
        else if (section.getCloset().getMember().getMemberId() != member.getMemberId()) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원은 옷을 저장하려는 구역의 주인이 아닙니다.");
        }

        //sortSeq 유효성 검사
        Sort sort = sortService.getClothSort(request.getSort());
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

    @Operation(summary = "옷 상세정보")
    @GetMapping(value = "/{clothSeq}" )
    public Api<Object> getCloth(@PathVariable int clothSeq) {
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        Cloth cloth =clothService.getCloth(clothSeq);
        if(cloth ==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷 정보를 찾지 못했습니다.");
        }
        if(cloth.getMember().getMemberId()!=member.getMemberId() && cloth.isPrivate()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "비공개 옷 이거나 조회하고자 하는 회원이 옷 주인이 아닙니다.");
        }
        List<Tag> tagList = clothService.getTagList(clothSeq);

        String filePathNobg = "cloth/no_bg/" + cloth.getClothImgName() +".png";
        String imgUrl = s3Service.generatePresignedUrl(filePathNobg);
        ClothSaveRes clothSaveRes = ClothSaveRes.toRes(cloth,imgUrl,tagList);
        return Api.OK(clothSaveRes);
    }

    @Operation(summary = "옷 종류로 조회")
    @GetMapping(value = "/sort/{sortName}" )
    public Api<Object> getClothListBySort(@PathVariable String sortName) {

        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        //sortSeq 유효성 검사
        Sort sort = sortService.getClothSort(sortName);
        if (sort == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, String.format("[%s]은/는 유호하지 않는 옷 종류입니다. Top, Pants, Outer, Skirt, Dress, Etc 중에서 보내주세요.", sortName));
        }

        return Api.OK(clothService.getClothListBySort(member, sort));
    }

    @Operation(summary = "해당 옷장 구역 내 옷 목록 조회")
    @GetMapping(value = "/section/{sectionSeq}" )
    public Api<Object> getClothListBySection(@PathVariable int sectionSeq) {

        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        //sortSeq 유효성 검사
        Section section = clothService.getSection(sectionSeq);
        if (section == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷장 구역 정보를 찾을 수 없습니다.");
        }

        if(section.getCloset().getMember().getMemberId()!=member.getMemberId()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "조회하고자 하는 회원이 옷장 구역의 주인이 아닙니다.");
        }

        return Api.OK(clothService.getClothListBySection(member, section));
    }

    @Operation(summary = "해당 해시태그 옷 목록 조회")
    @GetMapping(value = "/tag/{tagSeq}" )
    public Api<Object> getClothListByTag(@PathVariable int tagSeq) {

        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        //sortSeq 유효성 검사
        Tag tag = clothService.getTag(tagSeq);
        if (tag == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "태그 정보를 찾을 수 없습니다.");
        }
        return Api.OK(clothService.getClothListByTag(member, tag));
    }

    @Operation(summary = "옷 정보수정")
    @PutMapping(value = "/" )
    public Api<Object> updateCloth(@RequestParam("mFile") MultipartFile file, @ModelAttribute ClothUpdateReq request) {

        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원 정보를 찾지 못했습니다.");
        }

        Cloth cloth =clothService.getCloth(request.getClothSeq());
        if(cloth ==null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷 정보를 찾지 못했습니다.");
        }

        //sectionSeq 유효성 검사
        Section section = closetService.getSection(request.getSectionSeq());
        if (section == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "옷을 저장하려는 구역 정보를 찾지 못했습니다.");
        }
        else if (section.getCloset().getMember().getMemberId() != member.getMemberId()) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "로그인된 회원은 옷을 저장하려는 구역의 주인이 아닙니다.");
        }
        //Section 변경 사항 저장
        if (cloth.getSection().getSectionSeq() != request.getSectionSeq()) {
            cloth.setSection(section);
        }

        //sortSeq 유효성 검사
        Sort sort = sortService.getClothSort(request.getSort());
        if (sort == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, String.format("[%s]은/는 유호하지 않는 옷 종류입니다. Top, Pants, Outer, Skirt, Dress, Etc 중에서 보내주세요.", request.getSort()));
        }
        //sort 변경 사항 저장
        if (cloth.getSort().getSortSeq() != sort.getSortSeq()) {
            cloth.setSort(sort);
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
        }else{
            fileName=cloth.getClothImgName();
            String filePathNobg = "cloth/no_bg/" + fileName+".png";
            imgUrl=s3Service.generatePresignedUrl(filePathNobg);
        }

        // 옷장 이름 변경 사항 저장
        if (!cloth.getClothName().equals(request.getClothName())) {
            cloth.setClothName(request.getClothName());
        }

        // 공개 여부 변경 사항 저장
        if (cloth.isPrivate() != request.isPrivate()) {
            cloth.setPrivate(request.isPrivate());
        }

        return Api.OK(clothService.updateCloth(cloth, request));
    }


}
