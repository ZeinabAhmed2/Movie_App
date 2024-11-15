import 'package:movie_task/data/movie_model.dart';

class MovieList {
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> upcomingMovies;

  MovieList({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
  });
}
