package com.ssafy.kkalong.domain.photo.service;

import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface PhotoService {
    public List<Photo> getPhotoList(Member member);

    public Photo getPhotoBySeq(int photoSeq);

    @Transactional
    public boolean deletePhotoBySeq(Photo photo);

    public Photo savePhoto(Photo photo);

    public void updatePhotoImgMasking(int photoSeq);
}
