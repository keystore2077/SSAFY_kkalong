package com.ssafy.kkalong.domain.cloth.service;

import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.repository.SectionRepository;
import com.ssafy.kkalong.domain.cloth.dto.request.ClothSaveReq;
import com.ssafy.kkalong.domain.cloth.dto.response.ClothGetRes;
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
import com.ssafy.kkalong.s3.S3Service;
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
    private final S3Service s3Service;
    private final SectionRepository sectionRepository;

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

   public Cloth getCloth(int clothSeq){
        return clothRepository.findByClothSeqAndIsClothDeleted(clothSeq,false).orElse(null);
   }


    public List<Tag>  getTagList(int clothSeq){
        return tagRelaionRepository.findAllByClothClothSeq(clothSeq).stream()
                .map(v->{
                    return v.getTag();
                })
                .toList();
    }

    public List<ClothGetRes> getClothListBySort(Member member,Sort sort){

        return clothRepository.findAllByMemberAndSortAndIsClothDeleted(member,sort,false).stream()
                .map(cloth->{
                    String filePathNobg = "cloth/no_bg/" + cloth.getClothImgName() +".png";
                    String imgUrl = s3Service.generatePresignedUrl(filePathNobg);
                    return ClothGetRes.toRes(cloth, imgUrl);
                })
                .toList();

    }

    public Section getSection(int sectionSeq){
        return sectionRepository.findById(sectionSeq).orElse(null);
    }

    public List<ClothGetRes> getClothListBySection(Member member,Section section){

        return clothRepository.findAllByMemberAndSectionAndIsClothDeleted(member,section,false).stream()
                .map(cloth->{
                    String filePathNobg = "cloth/no_bg/" + cloth.getClothImgName() +".png";
                    String imgUrl = s3Service.generatePresignedUrl(filePathNobg);
                    return ClothGetRes.toRes(cloth, imgUrl);
                })
                .toList();
    }

    public Tag getTag(int tagSeq){
        return tagRepository.findById(tagSeq).orElse(null);
    }

    public List<ClothGetRes> getClothListByTag(Member member,Tag tag){

        return clothRepository.findClothsByMemberAndTag(member.getMemberSeq(),tag.getTagSeq()).stream()
                .map(cloth->{
                    String filePathNobg = "cloth/no_bg/" + cloth.getClothImgName() +".png";
                    String imgUrl = s3Service.generatePresignedUrl(filePathNobg);
                    return ClothGetRes.toRes(cloth, imgUrl);
                })
                .toList();
    }
}
