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
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  final _wman = ['남자', '여자']; // 성별선택 드롭다운 리스트
  String? _selectedWman;

  int? selectedYear;
  List<DropdownMenuItem<int>> yearItems = []; // 태어난 년도 드롭다운 리스트

  void initYearItems() {
    for (int year = 1980; year <= DateTime.now().year - 10; year++) {
      yearItems.add(DropdownMenuItem<int>(
        value: year,
        child: Text(year.toString()),
      ));
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _selectedWman = _wman[0];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    initYearItems();
  }

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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: const InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0))),
                  child: Container(
                      // padding: const EdgeInsets.all(40.0),
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
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
                                            Icons.account_circle,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                          labelText: '아이디',
                                          focusColor: Color(0xFFF5BEB5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20, // 중복 확인 버튼과 아이디 입력창 사이의 간격 설정
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 50,
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
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.2, 0.2, 0.2, 0.2),
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
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
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
                              SizedBox(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller4,
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 16.0,
                                            horizontal: 10.0,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xFFF5BEB5),
                                            ),
                                          ),
                                          prefixIconColor: Color(0xFFF5BEB5),
                                          prefixIcon: Icon(
                                            Icons.alternate_email_rounded,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                          labelText: '이메일',
                                          focusColor: Color(0xFFF5BEB5),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10, // 이메일 인풋창과 인증 버튼 사이의 간격 설정
                                    ),
                                    SizedBox(
                                      width: 70,
                                      height: 48,
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
                                        child: const Text(
                                          '인증',
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller5,
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
                                      width: 20, // 중복 확인 버튼과 아이디 입력창 사이의 간격 설정
                                    ),
                                    SizedBox(
                                      width: 90,
                                      height: 50,
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
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.2, 0.2, 0.2, 0.2),
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
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '(선택)추가 정보',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                          '맞춤 정보 제공을 위해\n자율적으로 추가 정보를 입력해주세요.'),
                                    ],
                                  ),
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
                                      prefixIcon: Icon(Icons.call),
                                      border: OutlineInputBorder(),
                                      labelText: '전화번호',
                                      focusColor: Color(0xFFF5BEB5)),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                                child: Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '생년',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          // DropdownButton<String>(
                                          //   value: _selectedWman,
                                          //   items: _wman.map((e) {
                                          //     return DropdownMenuItem<String>(
                                          //       value: e,
                                          //       child: Text(e),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (value) {
                                          //     setState(() {
                                          //       _selectedWman = value!;
                                          //     });
                                          //   },
                                          // ),
                                          DropdownButton<int>(
                                            value: selectedYear,
                                            items: yearItems,
                                            onChanged: (int? year) {
                                              setState(() {
                                                selectedYear = year;
                                              });
                                            },
                                            hint: const Text('태어난 년도를 선택하세요'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '성별',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: _selectedWman,
                                            items: _wman.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(e),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedWman = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
