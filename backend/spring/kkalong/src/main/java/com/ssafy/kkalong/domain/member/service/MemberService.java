package com.ssafy.kkalong.domain.member.service;

import com.ssafy.kkalong.domain.member.dto.request.SignInReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
import com.ssafy.kkalong.domain.member.dto.response.MemberInfoRes;
import com.ssafy.kkalong.domain.member.dto.response.MemberUpdateRes;
import com.ssafy.kkalong.domain.member.dto.response.SignInRes;
import com.ssafy.kkalong.domain.member.dto.response.SignUpRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.repository.MemberRepository;
import com.ssafy.kkalong.security.TokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final MemberRepository memberRepository;
    private final TokenProvider tokenProvider;
    private final PasswordEncoder encoder;	// 추가

    private final String USER_HASH_KEY = "user";
    private final long USER_TTL_SECONDS = 3600;
    private final RedisTemplate<String, String> redisTemplate;

    //회원 가입
    @Transactional
    public SignUpRes registMember(SignUpReq request) {
        System.out.println("service1");
        Member member = memberRepository.save(Member.toEntity(request, encoder));
        System.out.println("service2");
        try {
            memberRepository.flush();
        } catch (DataIntegrityViolationException e) {
            throw new IllegalArgumentException("이미 사용중인 아이디입니다.");
        }
        System.out.println("service3");
        return SignUpRes.toRes(member);
    }


    //로그인
    @Transactional(readOnly = true)
    public SignInRes signIn(SignInReq request) {
        Member member = memberRepository.findByMemberIdAndIsMemberDeleted(request.getMemberId(), false)
                .filter(it -> encoder.matches(request.getMemberPw(), it.getMemberPw()))	// 암호화된 비밀번호와 비교하도록 수정
                .orElseThrow(() -> new IllegalArgumentException("아이디 또는 비밀번호가 일치하지 않습니다."));
        String accessToken = tokenProvider.createAccessToken(member.getMemberId());
        String refreshToken = tokenProvider.createRefreshToken();
        return new SignInRes(member.getMemberId(), member.getMemberNickname(), accessToken, refreshToken);
    }

    //로그인된 회원 조회
    public Member getLoginUserInfo(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User)auth.getPrincipal();
        String memberId = user.getUsername();
        if (memberId.equals("123")){throw new NoSuchElementException("존재하지 않는 회원입니다.");}
        return memberRepository.findByMemberIdAndIsMemberDeleted(memberId, false)
                .orElseThrow(() -> new NoSuchElementException("존재하지 않는 회원입니다."));
    }

    public boolean checkId(String memberId){
        return !memberRepository.findByMemberIdAndIsMemberDeleted(memberId, false).isPresent();

    }

    public boolean checkNickName(String nickName){
        return !memberRepository.findByMemberNicknameAndIsMemberDeleted(nickName, false).isPresent();

    }




}
