package com.ssafy.kkalong.domain.closet.service;

import com.ssafy.kkalong.domain.closet.dto.request.ClosetCreateRequest;
import com.ssafy.kkalong.domain.closet.dto.request.SectionCreateRequestItem;
import com.ssafy.kkalong.domain.closet.dto.request.SectionUpdateRequest;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.member.entity.Member;
import java.util.List;

//컨트롤러 비지니스 로직
//closetservice
public interface ClosetService {
    public List<Closet> findClosetsByMemberSeq(int memberSeq);

    public Closet findCloset(int closetSeq);

    public List<Section> findSection(int closetSeq);

    public Closet createCloset(ClosetCreateRequest request, Member member, String filename);

    public List<Section> createSection(List<SectionCreateRequestItem> requests, Closet newCloset);

    //db에 저장할 정보들 저장할라고 하는거임
    public Closet updateCloset(Closet closet);

    //섹션 수정
    public List<Section> updateSection(List<SectionUpdateRequest> sectionUpdateRequests,Closet closet);

    public void deleteSection(List<Integer> closetSectionDeleteList,Closet closet,Member member);

    public Closet testcloset(ClosetCreateRequest request, Member member, String closetImageName);


    public Section getSection(int sectionSeg);

    public void deleteCloset(Closet closet);
}




