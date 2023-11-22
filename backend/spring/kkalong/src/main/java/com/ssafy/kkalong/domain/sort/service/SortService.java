package com.ssafy.kkalong.domain.sort.service;

import com.ssafy.kkalong.domain.sort.entity.Sort;

public interface SortService {
    Sort getSort(String sort);
    Sort getClothSort(String sort);
}
