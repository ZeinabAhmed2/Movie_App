import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      animationDuration: Duration(seconds: 3),
      backgroundColor: firstColor,
      duration: Duration(seconds: 4),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,        
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              height: 300,
              width: 300,
              'assets/cinema icon.avif'),
          ),
          Text(
            'MOVIES',
            style: TextStyle(
              fontSize: 55,
              color: secondColor,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
      nextScreen: HomeScreen(),
    );
  }
}
