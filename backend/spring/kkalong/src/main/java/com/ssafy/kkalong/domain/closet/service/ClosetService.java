package com.ssafy.kkalong.domain.closet.service;

import com.ssafy.kkalong.domain.closet.entity.Closet;
import com.ssafy.kkalong.domain.closet.repository.ClosetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClosetService {
    @Autowired
    private ClosetRepository closetRepository;

    public List<Closet> findClosetsByMemberSeq(Integer memberSeq) {
        return closetRepository.findAllByMemberMemberSeq(memberSeq);       //멤버시퀀스를주면 멤버시퀀스 값을가지고있는 클로젯리스트 반환
    }
}