package com.ssafy.kkalong.domain.social.dto.response;

import com.ssafy.kkalong.domain.social.entity.Fashion;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
@Builder
@Data
public class FashionInfoRes {

    @Schema(description = "회원 닉네임")
    private String memberNickname ;

    @Schema(description = "인덱스")
    int fashionSeq;

    @Schema(description = "코디 이름")
    private String fashionName ;

    @Schema(description = "공개여부")
    private boolean isFashionPrivate;

    @Schema(description = "생성 일시")
    private LocalDateTime fashionRegDate ;

    @Schema(description = "사진 Url")
    private String imgUrl ;

    @Schema(description = "좋아요 수")
    private int cntLike ;

    @Schema(description = "싫어요 수")
    private int cntHate ;

    public static FashionInfoRes toRes(Fashion fashion, String imgUrl,int cntLike,int cntHate){
        return FashionInfoRes.builder()
                .memberNickname(fashion.getMember().getMemberNickname())
                .fashionSeq(fashion.getFashionSeq())
                .fashionName(fashion.getFashionName())
                .isFashionPrivate(fashion.isFashionPrivate())
                .fashionRegDate(fashion.getFashionRegDate())
                .imgUrl(imgUrl)
                .cntLike(cntLike)
                .cntHate(cntHate)
                .build();
    }
}
