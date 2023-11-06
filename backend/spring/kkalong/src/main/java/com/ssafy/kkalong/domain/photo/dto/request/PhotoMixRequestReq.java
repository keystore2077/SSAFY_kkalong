package com.ssafy.kkalong.domain.photo.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class PhotoMixRequestReq {
    @Schema(description = "요청한 사진의 이름")
    private String photo_img_name;
    @Schema(description = "요청한 옷의 이름")
    private String cloth_img_name;
}
