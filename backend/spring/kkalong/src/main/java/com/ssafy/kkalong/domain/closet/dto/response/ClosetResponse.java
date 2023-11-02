package com.ssafy.kkalong.domain.closet.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter

public class ClosetResponse {

    @Schema(description = "옷장이름")
    private String closetName ;
    @Schema(description = "삭제할 옷장 일렬번호")
    private int closetSeq;
}
