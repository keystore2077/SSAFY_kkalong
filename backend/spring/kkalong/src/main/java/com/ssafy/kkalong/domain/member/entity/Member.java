package com.ssafy.kkalong.domain.member.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;

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

    @Column(nullable = false, length =200)
    private String memberSalt ;

    @Column(nullable = false, unique = true)
    private String nickName;

    @Column(nullable = false, unique = true, length = 40)
    private String memberEmail ;

    private char memberGender;
    //(M-남자, F - 여자)

    @Column(nullable = false)
    private Date memberBirthYear ;

    private boolean isMemberDeleted;

    private Date memberWithdrawnDate;
}
