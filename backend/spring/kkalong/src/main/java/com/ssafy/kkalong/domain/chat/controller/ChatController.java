package com.ssafy.kkalong.domain.chat.controller;

import com.ssafy.kkalong.common.api.Api;
import com.ssafy.kkalong.common.error.ErrorCode;
import com.ssafy.kkalong.domain.chat.document.Chat;
import com.ssafy.kkalong.domain.chat.entity.ChatRoom;
import com.ssafy.kkalong.domain.chat.service.ChatService;
import com.ssafy.kkalong.domain.member.entity.Member;
import com.ssafy.kkalong.domain.member.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.http.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/chat")
public class ChatController {
    @Autowired
    private ChatService chatService;

    @Autowired
    private MemberService memberService;

    @PostMapping("")
    @Operation(summary = "대상과 방만들기")
    public Api<Object> createRoom(@RequestParam @Parameter(description = "채팅방 만들 대상 유저의 닉네임",
            required = true) String memberNickName){
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        // 대상이 존재하는 회원인지 조회
        Member chatTarget = memberService.checkNickName(memberNickName);
        if (member == null || chatTarget == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        // 방이 이미 존재하는지 체크
        ChatRoom chatRoom = chatService.getChatRoomByParticipant(member.getMemberSeq(), chatTarget.getMemberSeq());
        if (chatRoom != null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "이미 존재하는 채팅방입니다");
        }

        // 방을 생성(mysql) 후 반환
        return Api.OK(chatService.createRoom(member, chatTarget));
    }

    @GetMapping("")
    @Operation(summary = "자신이 참가한 모든 방 조회")
    public Api<Object> findAllRoomsByMemberSeq(){
        // 사용자 유효성 검사
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }
        return Api.OK(chatService.findAllRoomByMemberSeq(member));
    }

    @GetMapping(value="/{roomSeq}",produces= MediaType.TEXT_EVENT_STREAM_VALUE)
    public Api<Object> findByRoomSeq(@PathVariable Integer roomSeq){
        // 참가자가 맞는지 확인
        Member member = memberService.getLoginUserInfo();
        if (member == null) {
            return Api.ERROR(ErrorCode.BAD_REQUEST, "유효하지 않은 사용자 정보입니다");
        }

        ChatRoom chatRoom = chatService.getChatRoomBySeq(roomSeq);
        if (chatRoom == null){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "존재하지 않는 방 번호입니다");
        }
        if (chatRoom.getMemberFir().getMemberSeq() != member.getMemberSeq()
                && chatRoom.getMemberSec().getMemberSeq() != member.getMemberSeq()){
            return Api.ERROR(ErrorCode.BAD_REQUEST, "대화 접근 권한이 없습니다");
        }

        return Api.OK(chatService.findMyRoomSeq(roomSeq));
    }


    @CrossOrigin
    @PostMapping("/msg")
    public Api<Object> setMsg(@RequestBody Chat chat){
        return Api.OK(chatService.setMsg(chat));
    }
}
