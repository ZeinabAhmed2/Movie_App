part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {
  final String initial = 'No Favorites In The List';
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<MovieModel> movies;

  FavoritesLoaded({required this.movies});
}

class ErrorLoadingFavorites extends FavoritesState {
  final String errorMessage;

  ErrorLoadingFavorites({required this.errorMessage});
}
