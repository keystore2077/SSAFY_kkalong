package com.ssafy.kkalong.domain.s3.service;

import com.amazonaws.HttpMethod;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import com.amazonaws.util.IOUtils;
import com.ssafy.kkalong.common.util.MultipartFileToFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public interface S3Service {
    // Amazon S3에 파일 업로드1
    public String uploadFile(String key, MultipartFile multipartFile) throws IOException;

    // Amazon S3에 파일 업로드2
    public String uploadFile(String key, File file);

    public byte[] downloadFile(String key);

    public String generatePresignedUrl(String key);

    public String copyS3(String sourceKey, String destinationKey);

    public String copyTempToFashion(String fileName);
}
