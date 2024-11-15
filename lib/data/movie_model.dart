class MovieModel {
  final int? id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final DateTime? releaseDate;
  final double? voteAverage;

  MovieModel(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.releaseDate,
      required this.voteAverage});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'],
        posterPath: json['poster_path'],
        overview: json['overview'],
        releaseDate: DateTime.parse(json['release_date']),
        voteAverage: (json['vote_average'] as num).toDouble());
  }
}
