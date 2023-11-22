package com.ssafy.kkalong.domain.assess.service;

import com.ssafy.kkalong.domain.assess.dto.request.AssessReq;
import com.ssafy.kkalong.domain.assess.dto.response.AssessRes;
import com.ssafy.kkalong.domain.assess.dto.response.FashionAssessRes;
import com.ssafy.kkalong.domain.assess.dto.response.FashionListRes;
import com.ssafy.kkalong.domain.member.entity.Member;

import java.util.List;

public interface AssessService {
    List<FashionAssessRes> getOpenFashionList(int memberSeq);
    AssessRes likeFashion(Member member, AssessReq request);
    FashionListRes getlikeFashionList(Member member);
}
