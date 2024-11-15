part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieIsLoading extends MovieState {}

class MovieIsLoaded extends MovieState {
  final MovieList movieList;

  MovieIsLoaded({required this.movieList});
}

class ErrorFetchingMovies extends MovieState {
  final String errorMessage;

  ErrorFetchingMovies({required this.errorMessage});
}
