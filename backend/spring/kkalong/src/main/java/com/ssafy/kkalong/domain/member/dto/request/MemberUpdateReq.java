package com.ssafy.kkalong.domain.member.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberUpdateReq {
    @Schema(description = "별명")
    private String memberNickname ;

    @Schema(description = "비밀번호")
    private String memberPw ;

    @Schema(description = "회원 새비밀번호")
    String newPassword;

    @Schema(description = "이메일")
    private String memberEmail ;

    @Schema(description = "전화번호")
    private String memberPhone ;

    @Schema(description = "성별")
    private Character memberGender;

    @Schema(description = "생년")
    private int memberBirthYear ;
}
