package com.ssafy.kkalong.domain.chat.entity;

import com.ssafy.kkalong.domain.member.entity.Member;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "chat_room")
public class ChatRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY, generator = "native")
    @Column(name = "chat_room_seq",nullable = false)
    @Schema(description = "채팅방 번호")
    private int chatRoomSeq;

    @ManyToOne
    @JoinColumn(name = "member_fir_seq", referencedColumnName = "member_seq", nullable = false)
    private Member memberFir;

    @ManyToOne
    @JoinColumn(name = "member_sec_seq", referencedColumnName = "member_seq", nullable = false)
    private Member memberSec;

    @Column(name = "chat_room_latest_log", nullable = false,length = 100)
    private String chatRoomLatestLog;

    @Column(name = "chat_room_latest_date", nullable = false)
    private LocalDateTime chatRoomLatestDate;
}
