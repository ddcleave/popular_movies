import 'package:equatable/equatable.dart';

class DetailMovie extends Equatable {
  const DetailMovie(
      {required this.overview,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.genres});

  final String overview;
  final String releaseDate;
  final String title;
  final num voteAverage;
  final List<dynamic> genres;

  @override
  List<Object> get props =>
      [overview, releaseDate, title, voteAverage, genres];
}
