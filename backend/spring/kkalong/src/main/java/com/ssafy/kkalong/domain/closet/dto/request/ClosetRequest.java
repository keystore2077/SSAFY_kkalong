package com.ssafy.kkalong.domain.closet.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ClosetRequest {
    @Schema(description = "옷장이름")
    private String closetName ;

    @Schema(description =  "삭제할 옷장 일련번호")
    private int closetSeq;
}
