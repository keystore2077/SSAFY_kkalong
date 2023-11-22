package com.ssafy.kkalong.domain.chat.document;

import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Data
@Document(collection = "chat")
public class Chat {
    @Id
    private String id; // MongoDB에서 사용하는 고유한 ID

    private int chatRoomSeq; // 방번호

    private int member1Seq; // 참가자 정보1

    private int member2Seq; // 참가자 정보2

    private int speaker; // 발화자(ms의 1번인지 2번인지)

    private String log; // 말한 내용

    private LocalDateTime datetime; // 말한 일시
}
