package com.ssafy.kkalong.domain.cloth.service;

import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothSaveReq;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothUpdateReq;
import com.ssafy.kkalong.domain.cloth.dto.response.ClothGetRes;
import com.ssafy.kkalong.domain.cloth.dto.response.ClothSaveRes;
import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.entity.Tag;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.sort.entity.Sort;

import java.util.List;

public interface ClothService {
    ClothSaveRes saveCloth(Member member, Section section, Sort sort, ClothSaveReq request, String imgUrl, String fileName);
    void updateClothImgMasking(int clothSeq);
    Cloth getCloth(int clothSeq);
    List<Tag> getTagList(int clothSeq);
    List<ClothGetRes> getClothListBySort(Member member, Sort sort);
    Section getSection(int sectionSeq);
    List<ClothGetRes> getClothListBySection(Member member, Section section);
    Tag getTag(int tagSeq);
    List<ClothGetRes> getClothListByTag(Member member, Tag tag);
    ClothSaveRes updateCloth(Cloth cloth, ClothUpdateReq req);
    void deleteCloth(Cloth cloth );
    List<String> emptySectionCloth(Member member ,Section section );
    List<ClothGetRes> inputSectionCloth(List<Integer> clothSeqList, Section section);
    List<String> emptyClosetCloth(List<Section> sectionList);
    ClothGetRes lockCloth(Cloth cloth);
}
