package com.ssafy.kkalong.domain.photo.repository;

import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.photo.entity.Photo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PhotoRepository extends JpaRepository<Photo, Integer> {
    List<Photo> findAllByMemberMemberSeqAndIsPhotoDeleted(Member member, boolean b);

    Photo findByPhotoSeqAndIsPhotoDeleted(int photoSeq, boolean b);

    Optional<Object> findByPhotoSeq(int photoSeq);
}
