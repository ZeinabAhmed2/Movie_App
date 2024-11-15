import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_task/data/movie_model.dart';
import 'package:movie_task/data/movie_services.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieServices movieServices;

  MovieDetailsCubit(this.movieServices) : super(MovieDetailsInitial());

  Future<void> getMoviesDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails =
          await movieServices.getMovieDetails(movieId: movieId);
      emit(MovieDetailsLoaded(movie: movieDetails));
    } catch (e) {
      emit(ErrorFetchingMovieDetails(errorMessage: '$e'));
    }
  }
}
