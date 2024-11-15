import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/constants.dart';
import 'package:movie_task/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:movie_task/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_task/data/movie_services.dart';
import 'package:movie_task/screens/movie_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        backgroundColor: firstColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
            Spacer(),
            Text(
              'Favorites',
              style: TextStyle(
                  fontSize: 35,
                  color: secondColor,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesInitial) {
            return Center(
              child: Text(
                state.initial,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (state is FavoritesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritesLoaded) {
            final movies = state.movies;
            if (favorites.isNotEmpty) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                MovieDetailsCubit(MovieServices())
                                  ..getMoviesDetails(movies[index].id!),
                            child: MovieDetailsScreen(
                              movieModel: movies[index],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '$posterBaseUrl${movies[index].posterPath}'),
                                  fit: BoxFit.fill)),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<FavoritesCubit>()
                                    .removeMovieFromFavorites(movies[index]);
                              },
                              icon: Icon(
                                Icons.remove_circle_outline,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${movies[index].title}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (favorites.isEmpty) {
              return Center(
                child: Text(
                  'No Favorites In The List',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          } else if (state is ErrorLoadingFavorites) {
            return Text('Error Loading Favorites');
          }
          return SizedBox();
        },
      ),
    );
  }
}
