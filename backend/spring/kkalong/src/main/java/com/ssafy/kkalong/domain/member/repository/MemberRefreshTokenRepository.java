package com.ssafy.kkalong.domain.member.repository;

import com.ssafy.kkalong.domain.member.entity.MemberRefreshToken;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface MemberRefreshTokenRepository extends CrudRepository<MemberRefreshToken, String> {
    Optional<MemberRefreshToken> findByAccessToken(String accessToken);
}
