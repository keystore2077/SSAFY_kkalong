package com.ssafy.kkalong.domain.sort.service;

import com.ssafy.kkalong.domain.sort.entity.Sort;
import com.ssafy.kkalong.domain.sort.repository.SortRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class SortServiceImpl implements SortService {
    private final SortRepository sortRepository;
    @Override
    public Sort getSort(String sort){
        return sortRepository.findBySortAndSortGroupSortGroupSeq(sort,2).orElse(null);
    }
    @Override
    public Sort getClothSort(String sort){
        return sortRepository.findBySortAndSortGroupSortGroupSeq(sort,1).orElse(null);
    }
}
