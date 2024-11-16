import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:movie_task/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_task/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_task/data/movie_services.dart';
import 'package:movie_task/screens/splash_screen.dart';

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
        home: SplashScreen(),      
      ),
    );
  }
}
