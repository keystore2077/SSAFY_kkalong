package com.ssafy.kkalong.fastapi;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.common.util.FileNameGenerator;
import com.ssafy.kkalong.fastapi.dto.RequestRembgRes;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
//    private String url = "http://222.107.238.44:4050";
    private String url = "http://localhost:4050";

    private final RestTemplate restTemplate;

    @Autowired
    public FastApiService(RestTemplate restTemplate){
        this.restTemplate = restTemplate;
    }

    public Api<Object> requestRembg(String memberId, MultipartFile mFile){
        String apiUrl = url + "/rembg";  // GPU서버의 URL
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
            Map<String, Object> jsonMap = objectMapper.readValue(jsonStr, new TypeReference<>() {});
            byte[] yesBg = Base64.getDecoder().decode((String)jsonMap.get("file_yes_bg"));
            byte[] noBg = Base64.getDecoder().decode((String)jsonMap.get("file_no_bg"));
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
            System.out.println("oh!!");
            return Api.OK(new RequestRembgRes(fileName, yesBgTempFile, fileName, noBgTempFile, "./"));
        } catch (JSONException  | IOException e) {
            // JSON 파싱 오류 처리
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "변환 실패");
        } catch (Exception e){
            e.printStackTrace();
            return Api.ERROR(ErrorCode.SERVER_ERROR, "알 수 없는 오류");
        }
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

//private static File getFile(String fileName, String response) throws IOException {
//        JSONObject jsonObject = new JSONObject(response); // JSON 문자열을 JSONObject로 파싱
//
//        // "image_data" 값을 string 타입의 textData로 추출
//        String textData = jsonObject.getString("image_data");
//
//        // textData를 바이트 배열로 변환
//        byte[] content = textData.getBytes();
//
//        // 바이트 배열을 File로 변경
//        File file = new File("temp/images/" + fileName);
//        // 디렉토리가 존재하지 않으면 생성
//        if (!file.getParentFile().exists()) {
//            file.getParentFile().mkdirs();
//        }
//        try (FileOutputStream fos = new FileOutputStream(file)) {
//            fos.write(content);
//        }
//        return file;
//    }
//
//    private File convertBinaryIOToFile(String jsonStr, String key) throws IOException {
//        ObjectMapper mapper = new ObjectMapper();
//        JsonNode rootNode = mapper.readTree(jsonStr);
//
//        if (rootNode.has(key)) {
//            String binaryData = rootNode.get(key).asText();
//            byte[] fileData = binaryData.getBytes();
//
//            File outputFile = new File(key + ".bin"); // 파일 확장자에 따라 적절히 수정
//
//            try (FileOutputStream outputStream = new FileOutputStream(outputFile)) {
//                outputStream.write(fileData);
//                return outputFile;
//            }
//        }
//
//        return null;
//    }
}
