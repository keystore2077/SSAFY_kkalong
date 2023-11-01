package com.ssafy.kkalong.security;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.kkalong.common.error.TokenErrorCode;
import com.ssafy.kkalong.common.exception.ApiException;
import com.ssafy.kkalong.domain.member.repository.MemberRepository;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import jakarta.transaction.Transactional;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.concurrent.TimeUnit;

/*
TODO: 회원의 리프레시 토큰을 관리할 엔티티
       리프레시 토큰을 생성하는 메소드
       로그인 API 응답에 리프레시 토큰 추가
       리프레시 토큰을 통해 액세스 토큰을 갱신
       리프레시 토큰 검증 및 새로운 액세스 토큰 발급

 */

@Service
@Getter
@Slf4j
public class TokenProvider {


        private final MemberRepository memberRepository;

        private final String secretKey;
        private final long expirationMinutes;
        private final long refreshExpirationHours;
        private final String issuer;
        private final long reissueLimit;
        private final ObjectMapper objectMapper = new ObjectMapper();
        private final RedisTemplate<String, String> redisTemplate;

        public TokenProvider(
                @Value("${jwt.secret-key}") String secretKey,
                @Value("${jwt.expiration-minutes}") long expirationMinutes,
                @Value("${jwt.refresh-expiration-hours}") long refreshExpirationHours,
                @Value("${jwt.issuer}") String issuer,
                MemberRepository memberRepository,
                RedisTemplate<String, String> redisTemplate){
                this.secretKey = secretKey;
                this.expirationMinutes = expirationMinutes;
                this.refreshExpirationHours = refreshExpirationHours;
                this.issuer = issuer;
                this.redisTemplate = redisTemplate;
                this.reissueLimit = refreshExpirationHours * 60 / expirationMinutes;
                this.memberRepository = memberRepository;
        }
        public String createAccessToken(String memberId){
                return Jwts.builder()
                    .signWith(new SecretKeySpec(secretKey.getBytes(), SignatureAlgorithm.HS512.getJcaName()))
                    .setSubject(memberId)
                    .setIssuer(issuer)
                    .setIssuedAt(Timestamp.valueOf(LocalDateTime.now()))
                    .setExpiration(Date.from(Instant.now().plus(expirationMinutes, ChronoUnit.HOURS)))
                    .compact();
        }

        public String createRefreshToken(){
                Date now = new Date();
                long refreshExpirationMillis = refreshExpirationHours * 60 * 60 * 1000;
                Date expireDate = new Date(now.getTime() + refreshExpirationHours);

                String refreshToken = Jwts.builder()
                        .signWith(new SecretKeySpec(secretKey.getBytes(),SignatureAlgorithm.HS512.getJcaName()))
                        .setIssuer(issuer)
                        .setIssuedAt(Timestamp.valueOf(LocalDateTime.now()))
                        .setExpiration(Date.from(Instant.now().plus(refreshExpirationHours, ChronoUnit.HOURS)))
                        .compact();
                redisTemplate.opsForValue().set(String.valueOf(Jwts.builder().setIssuer(issuer)),refreshToken,refreshExpirationMillis, TimeUnit.MILLISECONDS);
                return refreshToken;
        }
        private Jws<Claims> validateAndParserToken(String auth){
                var key = Keys.hmacShaKeyFor(secretKey.getBytes());
                var parser = Jwts.parserBuilder()
                        .setSigningKey(secretKey.getBytes())
                        .build();

                try {
                        var result = parser.parseClaimsJws(auth);
                        return result;
                } catch (Exception e){
                        if(e instanceof SignatureException) {
                                throw new ApiException(TokenErrorCode.INVALID_TOKEN);
                        } else if (e instanceof ExpiredJwtException) {
                                throw new ApiException(TokenErrorCode.EXPIRED_TOKEN);
                        } else {
                                throw new ApiException(TokenErrorCode.TOKEN_EXCEPTION);
                        }
                }
        }
        public String validateTokenAndGetSubject(String token){
                return validateAndParserToken(token)
                        .getBody()
                        .getSubject();
        }
//        @Transactional
//        public String recreateAccessToken(String oldAccessToken) throws JsonProcessingException {
//                String subject = decodeJwtPayloadSubject(oldAccessToken);
//                Optional<MemberRefreshTokenRepository> userRefreshTokenOptional = memberRefreshTokenRepository.findByUserIdAndReissueCountLessThan(UUID.fromString(subject.split(":")[0]), reissueLimit);
//
//                if (userRefreshTokenOptional.isPresent()) {
//                        MemberRefreshToken userRefreshToken = (MemberRefreshToken) userRefreshTokenOptional.get();
//                        userRefreshToken.increaseReissueCount();
//                } else {
//                        throw new ExpiredJwtException(null, null, "Refresh Token expire");
//                }
//                return createAccessToken(subject);
//        }
//
//
//
//        @Transactional
//        public void validateRefreshToken(String refreshToken, String oldAccessToken) throws  JsonProcessingException{
//                validateAndParserToken(refreshToken);
//                String userId = decodeJwtPayloadSubject(oldAccessToken).split(":")[0];
//                memberRefreshTokenRepository.findByUserIdAndReissueCountLessThan(UUID.fromString(userId),reissueLimit)
//                        .orElseThrow(() -> new ExpiredJwtException(null,null,"Refresh Token expire"));
//        }
//
//        private String decodeJwtPayloadSubject(String oldAccessToken) throws JsonProcessingException {
//                return objectMapper.readValue(
//                        new String(Base64.getDecoder().decode(oldAccessToken.split("\\.")[1]), StandardCharsets.UTF_8),
//                        Map.class
//                ).get("sub").toString();
//        }


}
