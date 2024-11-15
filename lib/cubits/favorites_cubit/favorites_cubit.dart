import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_task/data/movie_model.dart';

part 'favorites_state.dart';

final List<MovieModel> favorites = [];

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  void favoriteMoviesLoading() {
    emit(FavoritesLoading());
    emit(FavoritesLoaded(movies: favorites));
  }

  void addMovieToFavorites(MovieModel movie) {
    if (!favorites.contains(movie)) {
      favorites.add(movie);
      emit(FavoritesLoaded(movies: favorites));
    }
  }

  void removeMovieFromFavorites(MovieModel movie) {
    if (favorites.contains(movie)) {
      favorites.remove(movie);
      emit(FavoritesLoaded(movies: favorites));
    }
  }

  bool isMovieInFavorites(int movieId) {
    return favorites.any((movie) => (movie.id == movieId));
  }
}
