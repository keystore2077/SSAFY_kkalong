import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../user/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: Transform.scale(
          scale: 3, // 이미지 크기를 조절하려면 이 값을 조절합니다. 1.5는 이미지를 1.5배 확대합니다.
          child: Image.asset('Assets/Image/logo.png'),
        ),
        nextScreen: const LogIn(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
