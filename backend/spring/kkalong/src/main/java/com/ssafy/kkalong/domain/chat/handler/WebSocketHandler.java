//package com.ssafy.kkalong.domain.chat.handler;
//
//import org.springframework.web.socket.TextMessage;
//
//public class WebSocketHandler extends TextWebSocketHandler {
//    @Override
//    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//        // 클라이언트로부터 메시지를 받았을 때 실행되는 로직
//        String receivedMessage = message.getPayload();
//        System.out.println("클라이언트로부터 메시지 수신: " + receivedMessage);
//
//        // 추가적인 메시지 처리 로직
//
//        // 클라이언트에게 응답 메시지 전송
//        session.sendMessage(new TextMessage("서버에서 응답: " + receivedMessage));
//    }
//}
