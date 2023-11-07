import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: InfoModal()
      )
  );
}

class InfoModal extends StatefulWidget {
  const InfoModal({Key? key}) : super(key: key);

  @override
  _InfoModalState createState() => _InfoModalState();
  }

class _InfoModalState extends State<InfoModal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 버튼 클릭 이벤트
            showDialog(context: context, builder: (context) {
              return DialogUI();
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  5.0), // 원하는 각진 정도로 설정
            ),
            // 다른 스타일 속성들
          ),
          child: const Text('정보수정'),
        ),
      ),
    );
  }
}



class DialogUI extends StatelessWidget {
  DialogUI({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                '정보수정',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 40.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: Color(0xFFF5BEB5),
                          ),
                        ),
                        prefixIconColor: Color(0xFFF5BEB5),
                        prefixIcon: Icon(
                          Icons.face_6,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: '닉네임',
                        focusColor: Color(0xFFF5BEB5),
                      ),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    width: 10, // 중복 확인 버튼과 아이디 입력창 사이의 간격 설정
                  ),
                  SizedBox(
                    height: 40,
                    width: 30,
                    child: OutlinedButton(
                      onPressed: () {
                        // 중복 확인 작업을 수행하는 코드 추가
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // 각진 정도 조절
                        ),
                        side: const BorderSide(
                          color:
                          Color(0xFFF5BEB5), // 외곽선 색상 설정
                          width: 1, // 외곽선 두께 설정
                        ),
                      ),
                      child: Text(
                          '중복 확인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                            Color(0xFFF5BEB5), // 글자 색상 설정
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Color(0xFFF5BEB5))),
                    prefixIconColor: Color(0xFFF5BEB5),
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                    focusColor: Color(0xFFF5BEB5)),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // 비밀번호 안보이도록 하는 것
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                controller: controller3,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Color(0xFFF5BEB5))),
                    prefixIconColor: Color(0xFFF5BEB5),
                    prefixIcon: Icon(Icons.key),
                    border: OutlineInputBorder(),
                    labelText: '비밀번호 확인',
                    focusColor: Color(0xFFF5BEB5)),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // 비밀번호 안보이도록 하는 것
              ),
            ),
          ],
        ),
      ),
    );
  }
}
