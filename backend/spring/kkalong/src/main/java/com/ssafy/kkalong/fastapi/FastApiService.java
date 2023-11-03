package com.ssafy.kkalong.fastapi;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.fastapi.dto.RequestRembgRes;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;

@Service
public class FastApiService {
    private final RestTemplate restTemplate;

    @Autowired
    public FastApiService(RestTemplate restTemplate){
        this.restTemplate = restTemplate;
    }

    public Api<Object> requestRembg(String fileName, MultipartFile mFile){
        String apiUrl = "http://other-server-url/endpoint";  // GPU서버의 URL
        HttpHeaders headers = new HttpHeaders();
        // 필요한 헤더 설정
        headers.set("Authorization", "Bearer your-token");

        // HTTP 요청을 보내기 위한 HTTP 엔티티 생성
        MultiValueMap<String, Object> parts = new LinkedMultiValueMap<>();
        parts.add("fileName", fileName);
        try {
            parts.add("fileParam", mFile.getBytes());
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 파일");
        }

        // HTTP 요청을 보내기 위한 HTTP 엔티티 생성
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(parts, headers);

        // HTTP GET 요청 보내기
        String response = restTemplate.postForObject(apiUrl, requestEntity, String.class);

        // response에서 json 추출
        try {
            File file = getFile(fileName, response);
            return Api.OK(new RequestRembgRes(file, fileName, "temp/images/"));
        } catch (JSONException | IOException e) {
            // JSON 파싱 오류 처리
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        }
    }

    private static File getFile(String fileName, String response) throws IOException {
        JSONObject jsonObject = new JSONObject(response); // JSON 문자열을 JSONObject로 파싱

        // "image_data" 값을 string 타입의 textData로 추출
        String textData = jsonObject.getString("image_data");

        // textData를 바이트 배열로 변환
        byte[] content = textData.getBytes();

        // 바이트 배열을 File로 변경
        File file = new File("temp/images/" + fileName);
        // 디렉토리가 존재하지 않으면 생성
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(content);
        }
        return file;
    }
}
