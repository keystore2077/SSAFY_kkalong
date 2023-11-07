package com.ssafy.kkalong.domain.cloth.service;

import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothSaveReq;
import com.ssafy.kkalong.domain.cloth.dto.response.ClothSaveRes;
import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.entity.Tag;
import com.ssafy.kkalong.domain.cloth.entity.TagRelation;
import com.ssafy.kkalong.domain.cloth.entity.TagRelationKey;
import com.ssafy.kkalong.domain.cloth.repository.ClothRepository;
import com.ssafy.kkalong.domain.cloth.repository.TagRelaionRepository;
import com.ssafy.kkalong.domain.cloth.repository.TagRepository;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.sort.entity.Sort;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ClothService {
    private final ClothRepository clothRepository;
    private final TagRepository tagRepository;
    private final TagRelaionRepository tagRelaionRepository;

    public ClothSaveRes saveCloth(Member member, Section section, Sort sort, ClothSaveReq request, String imgUrl, String fileName){
        //옷 저장
        Cloth cloth = Cloth.builder()
                .section(section)
                .sort(sort)
                .member(member)
                .clothName(request.getClothName())
                .clothImgName(fileName)
                .clothImgNoBg(true)
                .clothImgYesBg(true)
                .clothImgMasking(false)
                .isPrivate(request.isPrivate())
                .clothRegDate(LocalDateTime.now())
                .build();

        Cloth clothSave = clothRepository.save(cloth);
        
        List<Tag> tagList = new ArrayList<>();
        //태그 저장
        for (String tagName : request.getTagList()){
            Tag tag = tagRepository.findByTag(tagName).orElse(null);
            if(tag==null){
                tag = tagRepository.save(new Tag(tagName));
            }
            //옷태그 관계 저장
            TagRelationKey tagRelationKey = TagRelationKey.builder()
                    .clothSeq(clothSave.getClothSeq())
                    .tagSeq(tag.getTagSeq())
                    .build();
            TagRelation tagRelation = TagRelation.builder()
                    .tagRelationKey(tagRelationKey)
                    .cloth(clothSave)
                    .tag(tag)
                    .build();
            tagRelaionRepository.save(tagRelation);

            tagList.add(tag);
        }
        return ClothSaveRes.toRes(clothSave, imgUrl, tagList);
    }
}
