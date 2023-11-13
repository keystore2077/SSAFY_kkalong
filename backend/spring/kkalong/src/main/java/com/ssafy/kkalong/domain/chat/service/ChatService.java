package com.ssafy.kkalong.domain.chat.service;

import com.ssafy.kkalong.domain.chat.dto.response.ChatRoomRes;
import com.ssafy.kkalong.domain.chat.entity.ChatRoom;
import com.ssafy.kkalong.domain.chat.repository.ChatRepository;
import com.ssafy.kkalong.domain.member.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ChatService {
    @Autowired
    private ChatRepository chatRepository;

    public ChatRoom getChatRoomByParticipant(int memberSeq1, int memberSeq2) {
        ChatRoom foundChatRoom = chatRepository.findAllByMemberFirMemberSeqAndMemberSecMemberSeq(memberSeq1, memberSeq2).orElse(null);
        if (foundChatRoom != null){
            return foundChatRoom;
        }
        return foundChatRoom = chatRepository.findAllByMemberFirMemberSeqAndMemberSecMemberSeq(memberSeq2, memberSeq1)
                .orElse(null);

    }

    public ChatRoomRes createRoom(Member member, Member chatTarget) {
        ChatRoom chatRoom = ChatRoom.builder().memberFir(member)
                .memberSec(chatTarget)
                .chatRoomLatestLog("")
                .chatRoomLatestDate(LocalDateTime.now())
                .build();
        ChatRoom result = chatRepository.save(chatRoom);

        return ChatRoomRes.toRes(result);
    }

    public List<ChatRoomRes> findAllRoomByMemberSeq(Member member) {
        List<ChatRoomRes> chatRoomList = new ArrayList<>();
        List<ChatRoom> result1 = chatRepository.findAllByMemberFir(member).orElse(null);
        if (result1 != null){
            for(ChatRoom room : result1){
                chatRoomList.add(ChatRoomRes.toRes(room));
            }
        }

        List<ChatRoom> result2 = chatRepository.findAllByMemberSec(member).orElse(null);
        if (result2 != null){
            for(ChatRoom room : result2){
                chatRoomList.add(ChatRoomRes.toRes(room));
            }
        }

        return chatRoomList;
    }
}
