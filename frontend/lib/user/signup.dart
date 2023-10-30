// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Signup(),
//     );
//   }
// }

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Signup> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('회원가입'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               '버튼을 누를 때마다 카운트가 증가합니다:',
//             ),
//             Text(
//               '$_counter',
//               style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: '증가',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// import './addinfo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              '회원가입',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 65),
        // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: const InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0))),
                  child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                child: TextField(
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
                                        Icons.account_circle,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '아이디',
                                      focusColor: Color(0xFFF5BEB5)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 80,
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
                              SizedBox(
                                height: 80,
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
                                      prefixIcon: Icon(Icons.key),
                                      border: OutlineInputBorder(),
                                      labelText: '비밀번호 확인',
                                      focusColor: Color(0xFFF5BEB5)),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: TextField(
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
                                      labelText: '이메일',
                                      focusColor: Color(0xFFF5BEB5)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: TextField(
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
                                        Icons.face_6,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '닉네임',
                                      focusColor: Color(0xFFF5BEB5)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () {},
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFF5BEB5))),
                                          child: const SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '회원가입',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                              // const AddInfo(),
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
