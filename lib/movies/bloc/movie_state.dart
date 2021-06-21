part of 'movie_bloc.dart';

enum MovieStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <Movie>[],
    this.page = 1,
    this.hasReachedMax = false,
    this.detailMovies = const <int, DetailMovie>{},
  });

  final MovieStatus status;
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;
  final Map<int, DetailMovie> detailMovies;

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    int? page,
    bool? hasReachedMax,
    Map<int, DetailMovie>? detailMovies,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      detailMovies: detailMovies ??  this.detailMovies,
    );
  }

  @override
  String toString() {
    return '''MovieState { status: $status, page: $page, hasReachedMax: $hasReachedMax }''';
  }

  @override
  List<Object> get props => [status, movies, page, hasReachedMax, detailMovies];
}
