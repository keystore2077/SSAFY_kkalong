package com.ssafy.kkalong.domain.chat.repository;


import com.ssafy.kkalong.domain.chat.entity.ChatRoom;
import com.ssafy.kkalong.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ChatRepository  extends JpaRepository<ChatRoom,Integer> {
    Optional<ChatRoom> findByMemberFirMemberSeqAndMemberSecMemberSeq(int memberSeq1, int memberSeq2);

    Optional<List<ChatRoom>> findAllByMemberFir(Member member);

    Optional<List<ChatRoom>> findAllByMemberSec(Member member);

    Optional<ChatRoom> findByChatRoomSeq(Integer roomSeq);
}
