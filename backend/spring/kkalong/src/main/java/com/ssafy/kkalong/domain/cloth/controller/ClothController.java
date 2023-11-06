package com.ssafy.kkalong.domain.cloth.controller;

import com.ssafy.kkalong.domain.cloth.service.ClothService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/cloth")
@RestController
@Slf4j
public class ClothController {

    private final ClothService clothService;

}
