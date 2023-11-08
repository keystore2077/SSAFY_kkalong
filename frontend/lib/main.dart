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

// import 'package:provider/provider.dart';
// import 'store/userstore.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/avata/choicepicture.dart';
// // import 'package:animated_splash_screen/animated_splash_screen.dart';
// import '../user/login.dart';
// // import '../user/mypage.dart';
// import './reafeat/bottom.dart';
// import './closet/closetdetail.dart';
// import './category/category.dart';
// import './user/pageapi.dart';

// void main() {
//   runApp(
//       ChangeNotifierProvider(create: (c) => UserStore(), child: const Main()));
// }

// class Main extends StatefulWidget {
//   const Main({super.key});

//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   static String? userToken; //user의 정보를 저장하기 위한 변수;
//   static final storage = FlutterSecureStorage();
//   final PageApi pageapi = PageApi();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _asyncMethod();
//       setState(() {});
//     });
//   }

//   _asyncMethod() async {
//     userToken = await storage.read(key: "login");
//     if (userToken != null) {
//       try {
//         final response =
//             await pageapi.tokenValidation(userToken.toString().split(" ")[1]);
//         // final response =
//         //     await pageapi.tokenValidation(userToken.toString().split(" ")[1]);
//         if (response == 'success') {
//           await context
//               .read<UserStore>()
//               .changeAccessToken(userToken.toString().split(" ")[1].toString());
//         } else {
//           await storage.delete(key: "login");
//           await context.read<UserStore>().changeAccessToken('');
//           userToken = null;
//           setState(() {});
//         }
//       } catch (e) {
//         await storage.delete(key: "login");
//         await context.read<UserStore>().changeAccessToken('');
//         userToken = null;
//         setState(() {});
//       }
//     } else {
//       await storage.delete(key: "login");
//       await context.read<UserStore>().changeAccessToken('');
//       userToken = null;

//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         home: SafeArea(
//       child: DefaultTabController(
//         initialIndex: 2,
//         length: 4,
//         child: Scaffold(
//           body: SafeArea(
//             child: TabBarView(
//               children: [
//                 ChoicePicture(),
//                 CategoryPage(),
//                 ClosetDetail(),
//                 LogIn(),
//                 // userToken == null
//                 //     ? LogIn(storage: storage)
//                 //     : MyPage(storage: storage)
//               ],
//             ),
//           ),
//           extendBodyBehindAppBar: true,
//           bottomNavigationBar: Bottom(),
//         ),
//       ),
//     ));
//   }
// }

import 'package:provider/provider.dart';
import 'store/userstore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mycloset/avata/choicepicture.dart';
import './reafeat/splash.dart';
import '../user/login.dart';
import '../user/mypage.dart';
import './reafeat/bottom.dart';
import './closet/closetdetail.dart';
import './category/category.dart';
import './user/pageapi.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Pretendard",
        ),
        home: const Splash(),
      ),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // static String? userToken; //user의 정보를 저장하기 위한 변수;
  // static final storage = FlutterSecureStorage();
  final PageApi pageapi = PageApi();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await _asyncMethod();
      setState(() {});
    });
  }

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

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(255, 136, 126, 136),
          content: Text('한번 더 뒤로가기를 누를 시 종료됩니다'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    // SystemNavigator.pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await onWillPop(); // 기존 onWillPop 함수 호출
      },
      child: DefaultTabController(
        initialIndex: 3,
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: const [
                ChoicePicture(),
                CategoryPage(),
                ClosetDetail(),
                MyPage(),
                // userToken == null
                //     ? LogIn(storage: storage)
                //     : MyPage(storage: storage)
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
