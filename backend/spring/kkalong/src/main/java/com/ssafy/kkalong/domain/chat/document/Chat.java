package com.ssafy.kkalong.domain.chat.document;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Document(collection = "chat")
public class Chat {
    @Id
    private String id; // MongoDB에서 사용하는 고유한 ID

    @Indexed
    @Field("chat_room_seq")
    private int chatRoomSeq; // 방번호

    @Field("member1Seq")
    private int member1Seq; // 참가자 정보1

    @Field("member2Seq")
    private int member2Seq; // 참가자 정보2

    @Field("speaker")
    private int speaker; // 발화자(ms의 1번인지 2번인지)

    @Field("log")
    private String log; // 말한 내용

    @Field("datetime")
    private LocalDateTime datetime; // 말한 일시
}
