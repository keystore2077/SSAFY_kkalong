package com.ssafy.kkalong.domain.photo.service;

import com.ssafy.kkalong.domain.photo.entity.Photo;
import com.ssafy.kkalong.domain.photo.repository.PhotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PhotoService {
    @Autowired
    private PhotoRepository photoRepository;

    public String getPhotoURL(){
        return "접근용 url";
    }

    public boolean savePhotoOriginal(){
        return true;
    }

    public boolean callRembg(){
        return true;
    }

    public List<Photo> getPhotoList(){
        return new ArrayList<Photo>();
    }

    public Photo getPhotoBySeq(){
        return new Photo();
    }

    public boolean deletePhotoBySeq(){
        return true;
    }

    public boolean callOpenpose(){
        return true;
    }

    public boolean callCIHP(){
        return true;
    }

    public String callVITON(){
        return "반환용URL";
    }
}
