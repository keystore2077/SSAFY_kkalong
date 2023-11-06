// import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// // import '../user/login.dart';
// // import '../user/mypage.dart';
// import '../user/nampage.dart';
// // import './reafeat/bottom.dart';

// void main() {
//   runApp(const Main());
// }

// class Main extends StatelessWidget {
//   const Main({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color.fromARGB(255, 255, 255, 255)),
//         useMaterial3: true,
//       ),
//       home: AnimatedSplashScreen(
//         splash: Transform.scale(
//           scale: 3, // 이미지 크기를 조절하려면 이 값을 조절합니다. 1.5는 이미지를 1.5배 확대합니다.
//           child: Image.asset('Assets/Image/logo.png'),
//         ),
//         nextScreen: const NamPage(),
//         splashTransition: SplashTransition.fadeTransition,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/user/login.dart';
// import 'package:flutter_mycloset/user/mypage.dart';
// // import 'package:animated_splash_screen/animated_splash_screen.dart';
// // import '../user/login.dart';
// import '../user/mypage.dart';
// import '../user/nampage.dart';
// import './reafeat/bottom.dart';
// import './reafeat/splash.dart';

// class Main extends StatefulWidget {
//   const Main({super.key});

//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'HOME',
//       home: Splash(),
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
//               MyPage(),
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
import 'package:flutter/material.dart';
import 'package:flutter_mycloset/user/mypage.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../user/login.dart';
// import '../user/mypage.dart';
import '../user/nampage.dart';
import './reafeat/bottom.dart';
import './reafeat/splash.dart';
import './closet/mycloset.dart';
import './closet/closetdetail.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
                NamPage(),
                MyCloset(),
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
