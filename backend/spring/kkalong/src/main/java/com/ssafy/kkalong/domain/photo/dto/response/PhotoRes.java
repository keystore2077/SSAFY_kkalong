package com.ssafy.kkalong.domain.photo.dto.response;

import com.ssafy.kkalong.domain.photo.entity.Photo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PhotoRes {
    @Schema(description = "사진의 고유 일련 번호")
    private int photoSeq;
    @Schema(description = "사진의 이름")
    private String photoImgName;
    @Schema(description = "사진의 등록일")
    private String photoRegDate;
    @Schema(description = "사진의 URL")
    private String url;

    public static PhotoRes toRes(Photo photo, String url){
        return PhotoRes.builder()
                .photoSeq(photo.getPhotoSeq())
                .photoImgName(photo.getPhotoImgName())
                .photoRegDate(photo.getPhotoRegDate())
                .url(url).build();
    }
}
