package com.ssafy.kkalong.domain.photo.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class SavePhotoOriginalReq {
    @Schema(description = "사용자가 보낸 파일")
    private MultipartFile file;
}
