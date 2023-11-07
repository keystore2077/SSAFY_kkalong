package com.ssafy.kkalong.domain.sort.service;

import com.ssafy.kkalong.domain.sort.entity.Sort;
import com.ssafy.kkalong.domain.sort.repository.SortRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class SortService {
    private SortRepository sortRepository;

    public Sort getSort(String sort){
        return sortRepository.findBySort(sort).orElse(null);
    }
}
