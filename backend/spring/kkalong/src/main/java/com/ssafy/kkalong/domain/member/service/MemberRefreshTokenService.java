package com.ssafy.kkalong.domain.member.service;

import com.ssafy.kkalong.domain.member.entity.MemberRefreshToken;
import com.ssafy.kkalong.domain.member.repository.MemberRefreshTokenRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberRefreshTokenService {
    private final MemberRefreshTokenRepository memberRefreshTokenRepository;

    @Transactional
    public void saveTokenInfo(Long employeeId, String refreshToken, String accessToken) {
        memberRefreshTokenRepository.save(new MemberRefreshToken(String.valueOf(employeeId), refreshToken, accessToken));
    }

    @Transactional
    public void removeRefreshToken(String accessToken) {
        memberRefreshTokenRepository.findByAccessToken(accessToken)
                .ifPresent(refreshToken -> memberRefreshTokenRepository.delete(refreshToken));
    }
}
