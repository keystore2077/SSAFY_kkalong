package com.ssafy.kkalong.domain.chat.document;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@NoArgsConstructor
@Getter
@Document(collection = "chat_rooms")
public class ChatRoomDocument {
    @Id
    @Field("id")
    private String id; // MongoDB에서 사용하는 고유한 ID

    @Indexed
    @Field("room_seq")
    private int roomSeq; // 방번호

    @Field("ms")
    private Map<String, Integer> ms; // 참가자 정보

    @Field("chat_log")
    private List<ChatLog> chatLog; // 채팅 내역

    @Document
    @AllArgsConstructor
    public static class ChatLog {

        @Field("speaker")
        private int speaker; // 발화자(ms의 1번인지 2번인지)

        @Field("log")
        private String log; // 말한 내용

        @Field("datetime")
        private LocalDateTime datetime; // 말한 일시
    }
}
