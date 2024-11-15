import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_task/screens/favorites_screen.dart';
import 'package:movie_task/widgets/now_playing_movies_category.dart';
import 'package:movie_task/widgets/popular_movies_category.dart';
import 'package:movie_task/widgets/top_rated_movies_category.dart';
import 'package:movie_task/widgets/upcoming_movies_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        backgroundColor: firstColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'MOVIES',
              style: TextStyle(
                  fontSize: 45,
                  color: secondColor,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritesScreen()));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 45,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieIsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieIsLoaded) {
            return const SingleChildScrollView(
                child: Column(
              children: [
                NowPlayingMoviescategory(),
                PopularMoviesCategory(),
                TopRatedMoviesCategory(),
                UpcomingMoviesCategory()
              ],
            ));
          }
          if (State is ErrorFetchingMovies) {
            throw ('Error');
          }
          return const SizedBox();
        },
      ),
    );
  }
}
