package com.ssafy.kkalong.domain.closet.service;

import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.entity.Section;
import com.ssafy.kkalong.domain.closet.repository.ClosetRepository;
import com.ssafy.kkalong.domain.closet.repository.SectionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}