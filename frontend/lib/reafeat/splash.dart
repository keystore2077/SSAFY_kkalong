// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import '../user/nampage.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode((SystemUiMode.immersive));

//     // Future.delayed(const Duration(seconds: 2), () {
//     //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //     builder: (_) => const Main(),
//     //   ));
//     // });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xffFEFFFF),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//         child:
//             // Column(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Image.asset(
//             //       'assets/images/splash_logo.png',
//             //       width: 70,
//             //     ),
//             //   ],
//             // ),
//             AnimatedSplashScreen(
//           splash: Transform.scale(
//             scale: 3, // 이미지 크기를 조절하려면 이 값을 조절합니다. 1.5는 이미지를 1.5배 확대합니다.
//             child: Image.asset('Assets/Image/logo.png'),
//           ),
//           nextScreen: const NamPage(),
//           splashTransition: SplashTransition.fadeTransition,
//         ),
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//         child: const Text(
//           'ⓒ 씅쑤신다. SSAFY',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

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
// // import 'package:flutter/services.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import '../user/nampage.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Splash(),
//   ));
// }

// class Splash extends StatelessWidget {
//   const Splash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xffFEFFFF),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//         child: AnimatedSplashScreen(
//           splash: Transform.scale(
//             scale: 3, // 이미지 크기를 조절
//             child: Image.asset('Assets/Image/logo.png'),
//           ),
//           nextScreen: const NamPage(),
//           splashTransition: SplashTransition.fadeTransition,
//         ),
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//         child: const Text(
//           'ⓒ 씅쑤신다. SSAFY',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode((SystemUiMode.immersive));

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Main(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffFEFFFF),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/Image/logo.png',
              width: 300,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
        child: const Text(
          'ⓒ 씅쑤신다. SSAFY',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
