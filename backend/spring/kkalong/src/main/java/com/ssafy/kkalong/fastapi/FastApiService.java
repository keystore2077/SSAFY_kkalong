package com.ssafy.kkalong.fastapi;

import com.fasterxml.jackson.core.type.TypeReference;
import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.fastapi.dto.FastApiRequestGeneralRes;
import com.ssafy.kkalong.fastapi.dto.RequestRembgRes;
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
import java.util.Map;

@Service
public class FastApiService {
    @Value("${ai-server.gpu.ip}:${ai-server.gpu.preprocess-port}")
    private String preprocessUrl;
//    private final String url = "http://localhost:4050";

    @Value("${ai-server.gpu.ip}:${ai-server.gpu.viton-port}")
    private String vitonHdUrl;

//    private final String openposeUrl = "http://localhost:4052";
    @Value("${ai-server.openpose}")
    private String openposeUrl;

    private final RestTemplate restTemplate;

    @Autowired
    public FastApiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public Api<Object> callWelcome() {
        System.out.println("callWelcome called.....");
        String apiUrl = preprocessUrl;
        String response = restTemplate.getForObject(apiUrl, String.class); // GET 요청 보내기
        System.out.println("response: " + response);
        return Api.OK(response);
    }

    public Api<Object> requestRembg(String memberId, MultipartFile mFile) {
        String apiUrl = preprocessUrl + "/rembg";  // GPU서버의 URL
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String mFileBase64;
        try {
            mFileBase64 = Base64.getEncoder().encodeToString(mFile.getBytes());
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 파일");
        }

        // ObjectMapper 초기화
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonStringReq = "{\"file\": \"" + mFileBase64 + "\"}";
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, new HttpEntity<>(jsonStringReq, headers), String.class);

        // response에서 json 추출
        try {
            String jsonStr = responseEntity.getBody();
            jsonStr = jsonStr.substring(1, jsonStr.length() - 1);
            jsonStr = unescapeJsonString(jsonStr);
            Map<String, Object> jsonMap = objectMapper.readValue(jsonStr, new TypeReference<>() {
            });
            byte[] yesBg = Base64.getDecoder().decode((String) jsonMap.get("file_yes_bg"));
            byte[] noBg = Base64.getDecoder().decode((String) jsonMap.get("file_no_bg"));
            // 파일 임시 저장
            String fileName = FileNameGenerator.generateFileNameNoExtension("temp", memberId);

            File yesBgTempFile = File.createTempFile(fileName, ".jpg");
            try (FileOutputStream fos = new FileOutputStream(yesBgTempFile)) {
                fos.write(yesBg);
            } catch (IOException e) {
                e.printStackTrace();
            }

            File noBgTempFile = File.createTempFile(fileName, ".png");
            try (FileOutputStream fos = new FileOutputStream(noBgTempFile)) {
                fos.write(noBg);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return Api.OK(new RequestRembgRes(fileName, yesBgTempFile, fileName, noBgTempFile, "./"));
        } catch (JSONException | IOException e) {
            // JSON 파싱 오류 처리
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        } catch (Exception e) {
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "알 수 없는 오류");
        }
    }

    public Api<Object> requestCihp(String memberId, MultipartFile mFile) {
        try {
            return requestCihp(memberId, mFile.getBytes());
        } catch (IOException e) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 파일");
        }
    }

    public Api<Object> requestCihp(String memberId, byte[] mFile) {
        String apiUrl = preprocessUrl + "/cihp";  // GPU서버의 URL
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String mFileBase64 = Base64.getEncoder().encodeToString(mFile);

        // ObjectMapper 초기화
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonStringReq = "{\"file\": \"" + mFileBase64 + "\"}";

        // 변환 요청
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, new HttpEntity<>(jsonStringReq, headers), String.class);

        // response에서 json 추출
        try {
            System.out.println("추출 시작");
            String jsonStr = responseEntity.getBody();
            jsonStr = jsonStr.substring(1, jsonStr.length() - 1);
            jsonStr = unescapeJsonString(jsonStr);
//            System.out.println(jsonStr);
            Map<String, Object> jsonMap = objectMapper.readValue(jsonStr, new TypeReference<>() {
            });
            byte[] cihp = Base64.getDecoder().decode((String) jsonMap.get("cihp"));
            // 파일 임시 저장
            System.out.println("임시 저장중...");
            String fileName = FileNameGenerator.generateFileNameNoExtension("temp", memberId);

            File tempFile = File.createTempFile(fileName, ".jpg");
            try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                fos.write(cihp);
            } catch (IOException e) {
                System.out.println("fos 변환 실패");
                return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
            }
            return Api.OK(new FastApiRequestGeneralRes(fileName, tempFile, "./"));
        } catch (JSONException | IOException e) {
            // JSON 파싱 오류 처리
            e.printStackTrace();
            System.out.println("변환 중 실패");
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("알 수 없는 오류 발생: " + e.getMessage());
            return Api.ERROR(ErrorCode.SERVER_ERROR, "알 수 없는 오류");
        }
    }

    public Api<Object> requestU2Net(String memberId, MultipartFile mFile) throws IOException {
        return requestU2Net(memberId, mFile.getBytes());
    }

    public Api<Object> requestU2Net(String memberId, byte[] mFile) {
        String apiUrl = preprocessUrl + "/u2net";  // GPU서버의 URL
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String mFileBase64 = Base64.getEncoder().encodeToString(mFile);

        // ObjectMapper 초기화
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonStringReq = "{\"file\": \"" + mFileBase64 + "\"}";
        // 변환 요청
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(apiUrl, new HttpEntity<>(jsonStringReq, headers), String.class);

        // response에서 json 추출
        try {
            String jsonStr = responseEntity.getBody();
            jsonStr = jsonStr.substring(1, jsonStr.length() - 1);
            jsonStr = unescapeJsonString(jsonStr);
            Map<String, Object> jsonMap = objectMapper.readValue(jsonStr, new TypeReference<>() {
            });
            byte[] u2net = Base64.getDecoder().decode((String) jsonMap.get("u2net"));
            // 파일 임시 저장
            String fileName = FileNameGenerator.generateFileNameNoExtension("temp", memberId);

            File tempFile = File.createTempFile(fileName, ".jpg");
            try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                fos.write(u2net);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return Api.OK(new FastApiRequestGeneralRes(fileName, tempFile, "./"));
        } catch (JSONException | IOException e) {
            // JSON 파싱 오류 처리
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        } catch (Exception e) {
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "알 수 없는 오류");
        }
    }

    public Api<Object> requestOpenpose(Member member, Photo photo) {
        return requestOpenpose(member, photo.getPhotoImgName(), photo.getPhotoSeq());
    }

    public Api<Object> requestOpenpose(Member member, String photoImgName, int photoSeq) {
        String apiUrl = openposeUrl + "/openpose";  // GPU서버의 URL
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String requestJson = "{\"member_id\":\"" + member.getMemberId() +
                "\",\"photo_img_name\":\"" + photoImgName +
                "\",\"photo_seq\":\"" + photoSeq + "\"}";
        HttpEntity<String> requestEntity = new HttpEntity<>(requestJson, headers);

        // RestTemplate을 사용하여 FastAPI 서버에 POST 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, String.class).getBody();
        System.out.println(response);
        if (!response.equals("\"success\"")) {
            return Api.ERROR(ErrorCode.SERVER_ERROR, "처리중 문제 발생");
        }

        return Api.OK("success");
    }


    // 이스케이프된 문자열을 복원
    private String unescapeJsonString(String escapedString) {
        StringBuilder unescapedString = new StringBuilder();
        int i = 0;
        while (i < escapedString.length()) {
            char c = escapedString.charAt(i);
            if (c == '\\') {
                char nextChar = escapedString.charAt(i + 1);
                if (nextChar == 'u') {
                    String unicode = escapedString.substring(i + 2, i + 6);
                    char unicodeChar = (char) Integer.parseInt(unicode, 16);
                    unescapedString.append(unicodeChar);
                    i += 6;
                } else {
                    unescapedString.append(nextChar);
                    i += 2;
                }
            } else {
                unescapedString.append(c);
                i++;
            }
        }
        return unescapedString.toString();
    }
}
