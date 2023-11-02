package com.ssafy.kkalong.domain.photo.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Photo {
    @Id
    @Schema(description = "사진의 일련번호")
    private int photoSeq;
    @Schema(description = "사진의 이름")
    private String photoImgName;
    @Schema(description = "소유자의 일련번호")
    private int memberSeq;
    @Schema(description = "배경 있는 누끼사진의 존재여부")
    private boolean photoImgYesBg;
    @Schema(description = "배경 없는 누끼사진의 존재여부")
    private boolean photoImgNoBg;
    @Schema(description = "파싱된 이미지의 존재여부")
    private boolean photoImgMasking;
    @Schema(description = "Openpose 처리된 이미지의 존재여부")
    private boolean photoImgOpenpose;
    @Schema(description = "Openpose 처리된 json의 존재여부")
    private boolean photoJsonOpenpose;
    @Schema(description = "등록일")
    private String photoRegDate;
}
