import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_task/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_task/data/movie_services.dart';
import 'package:movie_task/screens/movie_details_screen.dart';
import 'package:movie_task/screens/upcoming_screen.dart';

class UpcomingMoviesCategory extends StatelessWidget {
  const UpcomingMoviesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MovieIsLoaded) {
          final upcomingMovies = state.movieList.upcomingMovies;
          final halfMoviesCount = (upcomingMovies.length / 2).ceil();

          return Column(
            children: [
              Row(
                children: [
                  const Text(
                    '  Upcoming',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<MovieCubit>(context),
                            child: UpcomingScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'see more',
                      style: TextStyle(
                        color: secondColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: halfMoviesCount + 1,
                  itemBuilder: (context, index) {
                    if (index < halfMoviesCount) {
                      final movie = upcomingMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    MovieDetailsCubit(MovieServices())
                                      ..getMoviesDetails(movie.id!),
                                child: MovieDetailsScreen(
                                  movieModel: movie,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              height: 230,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '$posterBaseUrl${movie.posterPath}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Text(
                                movie.title ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: BlocProvider.of<MovieCubit>(context),
                                    child: UpcomingScreen(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
        if (state is ErrorFetchingMovies) {
          throw 'Error';
        }
        return Container();
      },
    );
  }
}
