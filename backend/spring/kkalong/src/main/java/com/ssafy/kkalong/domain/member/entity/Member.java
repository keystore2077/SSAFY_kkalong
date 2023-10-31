package com.ssafy.kkalong.domain.member.entity;

import com.ssafy.kkalong.domain.member.dto.request.MemberUpdateReq;
import com.ssafy.kkalong.domain.member.dto.request.SignUpReq;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Entity
@Table(name = "member")
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int memberSeq;

    @Column(nullable = false, unique = true, length = 20)
    private String memberNickname ;

    @Column(nullable = false, unique = true, length = 20)
    private String memberId;

    @Column(nullable = false, length = 100)
    private String memberPw ;

    @Column(nullable = false, unique = true, length = 40)
    private String memberEmail ;

    @Column(length = 11)
    private String memberPhone ;

    private char memberGender;
    //(M-남자, F - 여자)

    private int memberBirthYear ;

    @Column(nullable = false)
    private LocalDateTime memberRegDate ;

    private boolean isMemberDeleted;

    private LocalDateTime memberWithdrawnDate;

    public static Member toEntity(SignUpReq request, PasswordEncoder encoder) {	// 파라미터에 PasswordEncoder 추가
        return Member.builder()
                .memberNickname(request.getMemberNickname())
                .memberId(request.getMemberId())
                .memberPw(encoder.encode(request.getMemberPw()))	// 수정
                .memberEmail(request.getMemberEmail())
                .memberPhone(request.getMemberPhone())
                .memberGender(request.getMemberGender())
                .memberBirthYear(request.getMemberBirthYear())
                .memberRegDate(LocalDateTime.now())
                .build();
    }

    public void update(MemberUpdateReq newMember, PasswordEncoder encoder) {	// 파라미터에 PasswordEncoder 추가
        this.memberPw = newMember.getMemberPw() == null || newMember.getMemberPw().isBlank()
                ? this.memberPw : encoder.encode(newMember.getMemberPw());	// 수정

        this.memberNickname = newMember.getMemberNickname();
        this.memberEmail = newMember.getMemberEmail();
        this.memberPhone = newMember.getMemberPhone();
        this.memberGender = newMember.getMemberGender();
        this.memberBirthYear = newMember.getMemberBirthYear();
    }
}
