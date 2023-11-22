package com.ssafy.kkalong.domain.member.service;

import com.ssafy.kkalong.domain.member.dto.request.MemberProfileUpdateReq;
import com.ssafy.kkalong.domain.member.dto.request.MemberUpdateReq;
import com.ssafy.kkalong.domain.member.dto.request.SignInReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
import com.ssafy.kkalong.domain.member.dto.response.MemberUpdateRes;
import com.ssafy.kkalong.domain.member.dto.response.SignInRes;
import com.ssafy.kkalong.domain.member.dto.response.SignUpRes;
import com.ssafy.kkalong.domain.member.entity.Member;

import java.util.Optional;

public interface MemberService {
    SignUpRes registMember(SignUpReq request);
    SignInRes signIn(SignInReq request);
    Member getLoginUserInfo();
    Member checkId(String memberId);
    Member checkNickName(String nickName);
    Member checkNickNameEvenIfDeleted(String nickName);
    void logout(Member member);
    Optional<MemberUpdateRes> updateMemberProfile(String memberId, MemberProfileUpdateReq request);
    MemberUpdateRes updateMember(Member member, MemberUpdateReq request);
    void deleteMember(Member member);

}
