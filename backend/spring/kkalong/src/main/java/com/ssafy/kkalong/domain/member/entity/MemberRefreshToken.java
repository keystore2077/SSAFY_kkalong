package com.ssafy.kkalong.domain.member.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.index.Indexed;

@AllArgsConstructor
@Getter
@RedisHash(value = "jwtToken", timeToLive = 60*60*24*3)
public class MemberRefreshToken {

    @Id
    private String id;

    private String refreshToken;

    @Indexed
    private String accessToken;

}
