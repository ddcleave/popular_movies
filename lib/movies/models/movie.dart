import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.voteAverage});

  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final num voteAverage;

  @override
  List<Object> get props => [id, title, overview, posterPath, voteAverage];
}
