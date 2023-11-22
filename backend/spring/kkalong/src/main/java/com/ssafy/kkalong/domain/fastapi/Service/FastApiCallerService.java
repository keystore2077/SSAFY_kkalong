package com.ssafy.kkalong.domain.fastapi.Service;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.api.Result;
import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.service.ClothService;
import com.ssafy.kkalong.domain.fastapi.dto.FastApiRequestGeneralRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.domain.photo.service.PhotoService;
import com.ssafy.kkalong.domain.s3.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.Objects;

public interface FastApiCallerService {
    @Async
    public void callOpenpose(Member member, Photo photo);

    @Async
    public void callCihp(Member member, Photo photo);

    @Async
    public void callU2Net(Member member, Cloth cloth);

    @Async
    public void callU2Net(Member member, String clothImgName, int clothSeq);
}
