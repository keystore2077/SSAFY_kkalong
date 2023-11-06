package com.ssafy.kkalong.domain.closet.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class ClosetCreateRequest {

    @Schema(description = "옷장이름")
    private String closetName ;

    @Schema(description = "옷장구성 섹션")
    private List<SectionCreateRequestItem> closetSectionList ;

    @Schema(description = "옷장사진이름")
    private String closetImageName;


}
