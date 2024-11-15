import 'package:dio/dio.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/data/movie_list.dart';
import 'package:movie_task/data/movie_model.dart';
import 'package:movie_task/data/trailer_model.dart';

class MovieServices {
  Dio dio = Dio();

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      Response response = await dio.get('$baseUrl/now_playing?api_key=$apiKey');
      List<dynamic> movies = response.data['results'];
      List<MovieModel> nowPlayingMoviesList = [];
      for (var movie in movies) {
        MovieModel movieModel = MovieModel.fromJson(movie);
        nowPlayingMoviesList.add(movieModel);
      }
      return nowPlayingMoviesList;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      Response response = await dio.get('$baseUrl/popular?api_key=$apiKey');
      List<dynamic> movies = response.data['results'];
      List<MovieModel> popularMoviesList = [];
      for (var movie in movies) {
        MovieModel movieModel = MovieModel.fromJson(movie);
        popularMoviesList.add(movieModel);
      }
      return popularMoviesList;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      Response response = await dio.get('$baseUrl/top_rated?api_key=$apiKey');
      List<dynamic> movies = response.data['results'];
      List<MovieModel> topRatedMoviesList = [];
      for (var movie in movies) {
        MovieModel movieModel = MovieModel.fromJson(movie);
        topRatedMoviesList.add(movieModel);
      }
      return topRatedMoviesList;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      Response response = await dio.get('$baseUrl/upcoming?api_key=$apiKey');
      List<dynamic> movies = response.data['results'];
      List<MovieModel> upcomingMoviesList = [];
      for (var movie in movies) {
        MovieModel movieModel = MovieModel.fromJson(movie);
        upcomingMoviesList.add(movieModel);
      }
      return upcomingMoviesList;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<MovieList> getAllMovies() async {
    try {
      var nowPlayingMovies = await getNowPlayingMovies();
      var popularMovies = await getPopularMovies();
      var topRatedMovies = await getTopRatedMovies();
      var upcomingMovies = await getUpcomingMovies();
      return MovieList(
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
        topRatedMovies: topRatedMovies,
        upcomingMovies: upcomingMovies,
      );
    } catch (e) {
      print('Error $e');
      return MovieList();
    }
  }

  Future<MovieModel> getMovieDetails({required int movieId}) async {
    try {
      Response response = await dio.get('$baseUrl/$movieId?api_key=$apiKey');
      if (response.statusCode == 200) {
        MovieModel movieDetails = MovieModel.fromJson(response.data);
        return movieDetails;
      } else {
        throw Exception('Failed to load movie details');
      }
    } on Exception catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<TrailerModel?> getOfficialYouTubeTrailer(
      {required int movieId}) async {
    Response response =
        await dio.get('$baseUrl/$movieId/videos?api_key=$apiKey');
    List<dynamic> trailers = response.data['results'];
    for (var trailer in trailers) {
      TrailerModel trailerModel = TrailerModel.fromJson(trailer);
      if (trailerModel.site == 'YouTube' &&
          trailerModel.type == 'Trailer' &&
          trailerModel.official == true) {
        return trailerModel;
      }
    }
    return null;
  }
}
