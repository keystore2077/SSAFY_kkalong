package com.ssafy.kkalong.domain.chat.dto.response;

import com.ssafy.kkalong.domain.chat.entity.ChatRoom;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@Builder
public class ChatRoomRes {
    @Schema(description = "방 번호")
    private int chatRoomSeq;
    @Schema(description = "방 만든 사람의 Seq")
    private int memberSeq1;
    @Schema(description = "방에 초대된 사람의 Seq")
    private int memberSeq2;
    @Schema(description = "마지막 채팅 내용")
    private String chatRoomLatestLog;
    @Schema(description = "마지막 채팅 친 일시")
    private LocalDateTime chatRoomLatestDate;

    public static ChatRoomRes toRes(ChatRoom chatRoom){
        return ChatRoomRes.builder().chatRoomSeq(chatRoom.getChatRoomSeq())
                .memberSeq1(chatRoom.getMemberFir().getMemberSeq())
                .memberSeq2(chatRoom.getMemberSec().getMemberSeq())
                .chatRoomLatestLog(chatRoom.getChatRoomLatestLog())
                .chatRoomLatestDate(chatRoom.getChatRoomLatestDate())
                .build();
    }
}
