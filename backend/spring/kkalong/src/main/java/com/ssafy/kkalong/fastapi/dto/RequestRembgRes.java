package com.ssafy.kkalong.fastapi.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.File;

@Data
@AllArgsConstructor
public class RequestRembgRes {
    @Schema(description = "사진 데이터")
    private File file;
    @Schema(description = "사진 이름")
    private String name;
    @Schema(description = "사진 경로")
    private String path;
}
