// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/avata/choicepicture.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // import 'package:animated_splash_screen/animated_splash_screen.dart';
// import '../user/login.dart';
// import './reafeat/bottom.dart';
// import './closet/closetdetail.dart';
// import './category/category.dart';
// // import 'package:camera/camera.dart';

// void main() {
//   runApp(Main());
// }

// class Main extends StatefulWidget {
//   Main({super.key});

//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   // static final storage =
//   //     FlutterSecureStorage();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // 'const' 키워드를 제거했습니다.
//       home: SafeArea(
//         child: DefaultTabController(
//           initialIndex: 2,
//           length: 4,
//           child: Scaffold(
//             body: SafeArea(
//               child: TabBarView(
//                 children: [
//                   ChoicePicture(),
//                   CategoryPage(),
//                   ClosetDetail(),
//                   // LogIn(storage: storage),
//                   LogIn()
//                 ],
//               ),
//             ),
//             extendBodyBehindAppBar: true,
//             bottomNavigationBar: Bottom(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return const DefaultTabController(
//       initialIndex: 2,
//       length: 4,
//       child: Scaffold(
//         body: SafeArea(
//           child: TabBarView(
//             children: [
//               MyPage(),s
//               LogIn(),
//               MyPage(),
//               LogIn(),
//               // userToken == null
//               //     ? LogIn(storage: storage)
//               //     : MyPage(storage: storage)
//             ],
//           ),
//         ),
//         extendBodyBehindAppBar: true,
//         bottomNavigationBar: Bottom(),
//       ));
// }
import 'dart:io';
import 'dart:async';

import 'package:flutter_mycloset/user/pageapi.dart';
import 'package:provider/provider.dart';
import 'store/userstore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../user/pageapi.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mycloset/avata/choicepicture.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../user/login.dart';
// import '../user/mypage.dart';
import './reafeat/bottom.dart';
import './closet/closetdetail.dart';
import './category/category.dart';
import './user/pageapi.dart';

void main() {
  runApp(ChangeNotifierProvider(
          create: (c) => UserStore(),
          child: const Main())
    );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  static String? userToken; //user의 정보를 저장하기 위한 변수;
  static final storage = FlutterSecureStorage();
  final PageApi pageapi = PageApi();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _asyncMethod();
      setState(() {});
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userToken = await storage.read(key: "login");
    print(userToken);
    print('------');
    if (userToken != null) {
      await context
          .read<UserStore>()
          .changeAccessToken(userToken.toString().split(" ")[1].toString());
      final storetoken = context.read<UserStore>().accessToken;
      print('이닛 다시 하나요?');
      print(storetoken);
    } else {
      print('그냥 다 로그아웃');
      await storage.delete(key: "login");
      await context.read<UserStore>().changeAccessToken('');
      setState(() {});
    }
  }

  //로그인함수 수정+토큰 유효성검사 api추가

  // _asyncMethod() async {
  //   userToken = await storage.read(key: "login");
  //   if (userToken != null) {
  //     try {
  //       final response =
  //           await pageapi.tokenValidation(userToken.toString().split(" ")[1]);
  //       // final response =
  //       //     await pageapi.tokenValidation(userToken.toString().split(" ")[1]);
  //       if (response == 'success') {
  //         await context
  //             .read<UserStore>()
  //             .changeAccessToken(userToken.toString().split(" ")[1].toString());
  //       } else {
  //         await storage.delete(key: "login");
  //         await context.read<UserStore>().changeAccessToken('');
  //         userToken = null;
  //         setState(() {});
  //       }
  //     } catch (e) {
  //       await storage.delete(key: "login");
  //       await context.read<UserStore>().changeAccessToken('');
  //       userToken = null;
  //       setState(() {});
  //     }
  //   } else {
  //     await storage.delete(key: "login");
  //     await context.read<UserStore>().changeAccessToken('');
  //     userToken = null;

  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SafeArea(
      child: DefaultTabController(
        initialIndex: 2,
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: [
                ChoicePicture(),
                CategoryPage(),
                ClosetDetail(),
                LogIn(),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),
        ),
      ),
    ));
  }
}