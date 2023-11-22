package com.ssafy.kkalong.domain.fastapi.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.fastapi.dto.RequestVitonRes;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.domain.fastapi.dto.FastApiRequestGeneralRes;
import com.ssafy.kkalong.domain.fastapi.dto.RequestRembgRes;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.*;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public interface FastApiService {
    public Api<Object> callWelcome();

    public Api<Object> callWelcomeViton();

    public Api<Object> requestRembg(String memberId, MultipartFile mFile);

    public Api<Object> requestCihp(String memberId, MultipartFile mFile);

    public Api<Object> requestCihp(String memberId, byte[] mFile);

    public Api<Object> requestU2Net(String memberId, MultipartFile mFile) throws IOException;

    public Api<Object> requestU2Net(String memberId, byte[] mFile);

    public Api<Object> requestOpenpose(Member member, Photo photo);

    public Api<Object> requestOpenpose(Member member, String photoImgName, int photoSeq);

    public Api<Object> requestViton(Member member, String clothName, byte[] clothImg, byte[] clothMaskingImg,
                             String photoName, byte[] photoImg, byte[] photoParsingImg, byte[] photoOpenposeImg,
                             byte[] photoOpenposeJson);
}
