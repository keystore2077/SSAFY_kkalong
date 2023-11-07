import 'package:flutter/material.dart';
import '../user/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key, this.storage});

  @override
  State<LogIn> createState() => _LogInState();
  final storage;
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              '로그인',
              style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 65),
        // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Form(
                    child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      // primaryColor: const Color.fromARGB(255, 242, 241, 241),
                      inputDecorationTheme: const InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0))),
                  // TextStyle(
                  //     color: Color.fromARGB(255, 242, 241, 241),
                  //     fontSize: 16.0))),
                  child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 58,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: TextField(
                                    onChanged: (context) {},
                                    style: const TextStyle(fontSize: 15),
                                    controller: controller,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 10.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xFFF5BEB5))),
                                        prefixIconColor: Color(0xFFF5BEB5),
                                        prefixIcon: Icon(
                                          Icons.alternate_email_rounded,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        labelText: '아이디',
                                        focusColor: Color(0xFFF5BEB5)),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 58,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                        prefixIcon:
                                            Icon(Icons.vpn_key_outlined),
                                        border: OutlineInputBorder(),
                                        labelText: '비밀번호',
                                        focusColor: Color(0xFFF5BEB5)),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true, // 비밀번호 안보이도록 하는 것
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () async {
                                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(
                                                        controller.text) &&
                                                RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                    .hasMatch(
                                                        controller2.text)) {
                                            } else if (RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(
                                                        controller.text) &&
                                                !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                    .hasMatch(
                                                        controller2.text)) {
                                              showSnackBar(
                                                  context,
                                                  const Text(
                                                      '비밀번호를 특수문자,영어를 포함해 주세요'));
                                            } else if (!RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(
                                                        controller.text) &&
                                                RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                    .hasMatch(
                                                        controller2.text)) {
                                              showSnackBar(
                                                  context,
                                                  const Text(
                                                      '아이디를 이메일 형식을 입력해주세요'));
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  const Text(
                                                      '아이디 비밀번호를 확인해주세요'));
                                            }
                                          },
                                          style:
                                              // const ButtonStyle(
                                              //     backgroundColor:
                                              //         MaterialStatePropertyAll(
                                              //             Color(0xFFF5BEB5))),
                                              OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0), // 원하는 각진 정도로 설정
                                            ),
                                            backgroundColor:
                                                const Color(0xFFF5BEB5),
                                          ),
                                          child: const SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '로그인',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUp()), // SignUpPage는 회원가입 페이지의 위젯입니다.
                                  );
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: const Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('아직 깔롱쟁이 회원이 아니라면?'),
                                          Text(
                                            '회원가입',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar =
      SnackBar(content: text, backgroundColor: const Color(0xFFF5BEB5));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
