package com.ssafy.kkalong.domain.chat.repository;

import com.ssafy.kkalong.domain.chat.document.Chat;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.data.mongodb.repository.Tailable;
import reactor.core.publisher.Flux;

public interface ChatMongoRepository extends ReactiveMongoRepository<Chat, String> {
    @Tailable
    @Query("{'$or': [{'member1Seq': ?0, 'member2Seq': ?1}, {'member1Seq': ?1, 'member2Seq': ?0}]}")
    Flux<Chat> mFindByMembers(int member1Seq, int member2Seq);

    @Tailable
    @Query("{chatRoomSeq:?0}")
    Flux<Chat> mFindByRoomSeq(int chatRoomSeq);
}
