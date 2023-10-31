package com.ssafy.kkalong.domain.member.service;

import com.ssafy.kkalong.domain.member.dto.request.SignInReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
import com.ssafy.kkalong.domain.member.dto.response.SignInRes;
import com.ssafy.kkalong.domain.member.dto.response.SignUpRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.entity.MemberRefreshToken;
import com.ssafy.kkalong.domain.member.repository.MemberRefreshTokenRepository;
import com.ssafy.kkalong.domain.member.repository.MemberRepository;
import com.ssafy.kkalong.security.TokenProvider;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final MemberRepository memberRepository;
    private final TokenProvider tokenProvider;
    private final PasswordEncoder encoder;	// 추가

    @Transactional
    public SignUpRes registMember(SignUpReq request) {
        Member member = memberRepository.save(Member.toEntity(request, encoder));
        try {
            memberRepository.flush();
        } catch (DataIntegrityViolationException e) {
            throw new IllegalArgumentException("이미 사용중인 아이디입니다.");
        }
        return SignUpRes.toRes(member);
    }

    @Transactional(readOnly = true)
    public SignInRes signIn(SignInReq request) {
        Member member = memberRepository.findByMemberIdAndMemberDeleted(request.getMemberId(), false)
                .filter(it -> encoder.matches(request.getMemberPw(), it.getMemberPw()))	// 암호화된 비밀번호와 비교하도록 수정
                .orElseThrow(() -> new IllegalArgumentException("아이디 또는 비밀번호가 일치하지 않습니다."));
        String accessToken = tokenProvider.createAccessToken(String.format(member.getMemberId()));
        String refreshToken = tokenProvider.createRefreshToken();
        return new SignInResponse(member.getName(), member.getType(), token);
    }

    @Transactional
    public MemberUpdateRes updateMember(UUID id, MemberUpdateRequest request) {
        return memberRepository.findById(id)
                .filter(member -> encoder.matches(request.password(), member.getPassword()))	// 암호화된 비밀번호와 비교하도록 수정
                .map(member -> {
                    member.update(request, encoder);	// 새 비밀번호를 암호화하도록 수정
                    return MemberUpdateResponse.of(true, member);
                })
                .orElseThrow(() -> new NoSuchElementException("아이디 또는 비밀번호가 일치하지 않습니다."));
    }
}
