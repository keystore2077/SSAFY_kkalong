package com.ssafy.kkalong.domain.member.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import com.ssafy.kkalong.domain.member.entity.Member;

import java.time.LocalDateTime;

@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SignUpRes {
    @Schema(description = "회원 고유일련번호")
    private int memberSeq;
    @Schema(description = "별명")
    private String memberNickname ;
    @Schema(description = "회원 아이디")
    private String memberId;
    @Schema(description = "이메일")
    private String memberEmail ;
    @Schema(description = "전화번호")
    private String memberPhone ;
    @Schema(description = "성별")
    private char memberGender;
    @Schema(description = "생년")
    private int memberBirthYear ;

    public static SignUpRes toRes (Member member) {
        return SignUpRes.builder()
                .memberSeq(member.getMemberSeq())
                .memberNickname(member.getMemberNickname())
                .memberId(member.getMemberId())
                .memberEmail(member.getMemberEmail())
                .memberPhone(member.getMemberPhone())
                .memberGender(member.getMemberGender())
                .memberBirthYear(member.getMemberBirthYear())
                .build();
    }
}
