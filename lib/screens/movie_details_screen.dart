import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:movie_task/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_task/data/movie_model.dart';
import 'package:movie_task/data/movie_services.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsLoaded) {
            final details = state.movie;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$posterBaseUrl${details.posterPath}'),
                                fit: BoxFit.fill),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            details.title ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                DateFormat('MMM, yyyy').format(DateTime.parse(
                                    details.releaseDate.toString())),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              details.voteAverage!.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: ReadMoreText(
                            details.overview ?? '',
                            trimMode: TrimMode.Line,
                            colorClickableText: secondColor,
                            trimExpandedText: '  show less',
                            trimCollapsedText: ' show more',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 21,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final isLiked = context
                                      .read<FavoritesCubit>()
                                      .isMovieInFavorites(details.id!);
                                  return IconButton(
                                    onPressed: () {
                                      if (isLiked) {
                                        context
                                            .read<FavoritesCubit>()
                                            .removeMovieFromFavorites(details);
                                      } else {
                                        context
                                            .read<FavoritesCubit>()
                                            .addMovieToFavorites(details);
                                      }
                                    },
                                    icon: Icon(
                                      (isLiked)
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color:
                                          (isLiked) ? Colors.red : Colors.white,
                                      size: 35,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () {
                                  final posterPath =
                                      '$posterBaseUrl${details.posterPath}';
                                  final movieTitle = details.title;
                                  final overview = details.overview;
                                  Share.share(
                                      '$posterPath\n$movieTitle\n$overview');
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: secondColor),
                                onPressed: () async {
                                  final trailer = await MovieServices()
                                      .getOfficialYouTubeTrailer(
                                          movieId: details.id!);
                                  if (trailer != null) {
                                    final youTubeLink =
                                        '$youTubeBaseUrl${trailer.key}';
                                    launchUrl(Uri.parse(youTubeLink));
                                  } else {
                                    throw 'Link is not available';
                                  }
                                },
                                child: Text(
                                  'Watch Trailer',
                                  style: TextStyle(
                                      color: firstColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (State is ErrorFetchingMovieDetails) {
            throw 'error';
          }
          return Text('Error');
        },
      ),
    );
  }
}
