package com.ssafy.kkalong.domain.test;

import com.ssafy.kkalong.common.api.Api;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/test")
public class testcontroller {

    @Operation(summary = "test")
    @GetMapping("/test1")
    public Api<Object> testsever(){

        return Api.OK("test 성공");
    }

    @Operation(summary = "test 용")
    @GetMapping("/test2")
    public Api<Object> testsever2(){

        return Api.OK("test2 성공");
    }
}
