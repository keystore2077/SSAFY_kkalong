package com.ssafy.kkalong.domain.cloth.service;

import com.ssafy.kkalong.domain.cloth.entity.Cloth;
import com.ssafy.kkalong.domain.cloth.repository.ClothRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ClothService {
    private final ClothRepository clothRepository;


}
