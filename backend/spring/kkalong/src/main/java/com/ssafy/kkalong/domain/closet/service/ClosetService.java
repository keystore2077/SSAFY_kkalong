package com.ssafy.kkalong.domain.closet.service;

import com.ssafy.kkalong.domain.closet.dto.request.ClosetCreateRequest;
import com.ssafy.kkalong.domain.closet.dto.request.SectionCreateRequestItem;
import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.repository.ClosetRepository;
import com.ssafy.kkalong.domain.closet.repository.SectionRepository;
import com.ssafy.kkalong.domain.member.entity.Member;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

//컨트롤러 비지니스 로직

@RequiredArgsConstructor
@Service
public class ClosetService {

    @Autowired
    private ClosetRepository closetRepository;
    @Autowired
    private SectionRepository sectionRepository;



    public List<Closet> findClosetsByMemberSeq(int memberSeq) {
        return closetRepository.findAllByMemberMemberSeq(memberSeq);       //멤버시퀀스를주면 멤버시퀀스 값을가지고있는 클로젯리스트 반환

    }
    public Closet findCloset(int closetSeq){
        return closetRepository.findByClosetSeqAndIsClosetDeleted(closetSeq, false).get();
    }
    public List<Section> findSection(int closetSeq){
        return sectionRepository.findAllByClosetClosetSeqAndIsSectionDeleted(closetSeq,false);
    }

    public Closet createCloset(ClosetCreateRequest request, Member member) {
        Closet newCloset = new Closet();
        newCloset.setClosetName(request.getClosetName());
        newCloset.setClosetImgName(request.getClosetImageName());
        newCloset.setMember(member);

        // DB에 저장하고, 저장된 엔티티 반환
        return closetRepository.save(newCloset);
    }

    public List<Section> createSection(List<SectionCreateRequestItem> requests, Closet newCloset) {
        List<Section> sectionsToSave = new ArrayList<>();

        for (SectionCreateRequestItem request : requests) {
            Section section = new Section();
            section.setSectionName(request.getSectionName());
            section.setCloset(newCloset);
            section.setSort(request.getSort());

            sectionsToSave.add(section);


        }
        return sectionRepository.saveAll(sectionsToSave);
    }
}



//    public List<Closet> createMultipleClosets(List<ClosetCreateRequest> requests) {
//        List<Closet> closetsToSave = new ArrayList<>();
//
//        for (ClosetCreateRequest request : requests) {
//            Closet closet = new Closet();
//            closet.setClosetName(request.getClosetName());
//            closet.setMemberSeq(request.getMemberSeq()); // 예시로 추가된 필드
//            // 추가적으로 필요한 데이터 설정
//            // ...
//            closetsToSave.add(closet);
//        }



//    public Closet createCloset(ClosetCreateRequest request) {
//        // 1. 엔티티 생성 및 데이터 설정
//        Closet newCloset = new Closet();
//        newCloset.setClosetName(request.getClosetName());
//        // 2. 옷장 사진 처리
//        // 사진을 처리하는 로직을 추가합니다. 예를 들어 파일을 저장하고,
//        // 저장된 파일의 경로나 이름을 Closet 엔티티에 설정할 수 있습니다.
//        // FileNameGenerator를 사용하여 파일 이름을 생성하고, 파일을 저장할 수 있습니다.
//        if (request.getClosetPicture() != null && !request.getClosetPicture().isEmpty()) {
//            String generatedFileName = FileNameGenerator.generateFileName(request.getClosetPicture());
//            // 파일 저장 로직 수행 (실제 파일을 서버에 저장하는 코드 작성)
//            // 파일 저장 후 파일명 또는 경로를 Closet 엔티티에 설정
//        }
//
//        // 3. 섹션 데이터 처리
//        // 요청에서 받은 섹션 이름 목록으로 섹션 엔티티들을 생성하고, 옷장 엔티티에 연결합니다.
//        for (String sectionName : request.getClosetSectionNameList()) {
//            Section section = new Section();
//            section.setName(sectionName);
//            section.setCloset(newCloset); // 섹션을 옷장에 연결
//            // ... 섹션에 필요한 추가 데이터 설정
//            newCloset.addSection(section); // 옷장에 섹션 추가
//        }
//
//        // 4. 옷장 저장
//        // 옷장과 연결된 섹션들을 데이터베이스에 저장
//        // CascadeType.ALL 등을 사용하여 옷장을 저장할 때 섹션들도 함께 저장되도록 설정할 수 있습니다.
//        return closetRepository.save(newCloset);
//    }

