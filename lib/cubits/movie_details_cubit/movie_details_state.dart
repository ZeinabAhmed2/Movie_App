part of 'movie_details_cubit.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieModel movie;

  MovieDetailsLoaded({required this.movie});
}

class ErrorFetchingMovieDetails extends MovieDetailsState {
  final String errorMessage;

  ErrorFetchingMovieDetails({required this.errorMessage});
}
