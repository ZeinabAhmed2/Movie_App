import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:movie_task/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_task/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_task/data/movie_services.dart';
import 'package:movie_task/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final MovieServices movieServices = MovieServices();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(movieServices),
        ),
        BlocProvider(
          create: (context) => MovieDetailsCubit(movieServices),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          backgroundColor:firstColor,
          splashIconSize: 250,
          duration: 1800,
          splash: 'assets/cinema icon.avif',
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.scaleTransition,
          animationDuration: Duration(seconds: 3),
        ),
      ),
    );
  }
}
