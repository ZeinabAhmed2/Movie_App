import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_task/data/movie_list.dart';
import 'package:movie_task/data/movie_services.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieServices movieServices;
  MovieCubit(this.movieServices) : super(MovieInitial());
  Future<void> getMovies() async {
    emit(MovieIsLoading());
    try {
      MovieList movies = await movieServices.getAllMovies();
      emit(MovieIsLoaded(movieList: movies));
    } catch (e) {
      emit(ErrorFetchingMovies(errorMessage: 'Error $e'));
    }
  }
}
