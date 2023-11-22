package com.ssafy.kkalong.domain.assess.service;

import com.ssafy.kkalong.domain.assess.dto.request.AssessReq;
import com.ssafy.kkalong.domain.assess.dto.response.AssessRes;
import com.ssafy.kkalong.domain.assess.dto.response.FashionAssessRes;
import com.ssafy.kkalong.domain.assess.dto.response.FashionListRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.social.entity.Fashion;
import com.ssafy.kkalong.domain.social.repository.FashionRepository;
import com.ssafy.kkalong.domain.s3.service.S3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

public interface AssessService {
    List<FashionAssessRes> getOpenFashionList(int memberSeq);

    AssessRes likeFashion(Member member, AssessReq request);

    FashionListRes getlikeFashionList(Member member);
}
