import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popular_movies/movies/movies.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'movie_event.dart';
part 'movie_state.dart';


class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.httpClient}) : super(const MovieState());

  final http.Client httpClient;

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
    Stream<MovieEvent> events,
    TransitionFunction<MovieEvent, MovieState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetched) {
      yield await _mapMovieFetchedToState(state);
    }
    if (event is DetailMovieFetched) {
      yield await _addDetailMovieFetchedToState(state, event.id);
    }
  }

  Future<MovieState> _addDetailMovieFetchedToState(
      MovieState state, int id) async {
    if (state.detailMovies.containsKey(id)) return state;
    try {
      final detailMovie = await _fetchDetailMovie(id);
      return state.copyWith(
          detailMovies: Map.of(state.detailMovies)
            ..putIfAbsent(id, () => detailMovie));
    } on Exception {
      return state.copyWith(status: MovieStatus.failure);
    }
  }

  Future<MovieState> _mapMovieFetchedToState(MovieState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await _fetchMovies();
        return state.copyWith(
          status: MovieStatus.success,
          movies: movies,
          page: 2,
          hasReachedMax: false,
        );
      }
      final movies = await _fetchMovies(state.page);
      return movies.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: MovieStatus.success,
              movies: List.of(state.movies)..addAll(movies),
              page: state.page + 1,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: MovieStatus.failure);
    }
  }

  Future<DetailMovie> _fetchDetailMovie(int id) async {
    final response = await httpClient.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/movie/$id',
        <String, String>{
          'api_key': '${dotenv.env['API_KEY']}'
        },
      ),
    );
    if (response.statusCode == 200) {
      final details = json.decode(response.body) as Map;
      return DetailMovie(
          overview: details['overview'] as String,
          releaseDate: details['release_date'] as String,
          title: details['title'] as String,
          voteAverage: details['vote_average'] as double,
          genres: details['genres'] as List<dynamic>,
      );
    }
    throw Exception('error fetching detailmovie id=$id');
  }

  Future<List<Movie>> _fetchMovies([int page = 1]) async {
    final response = await httpClient.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/movie/popular',
        <String, String>{
          'api_key': '${dotenv.env['API_KEY']}',
          'page': '$page'
        },
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body)['results'] as List;
      return body.map((dynamic json) {
        return Movie(
          id: json['id'] as int,
          title: json['title'] as String,
          overview: json['overview'] as String,
          posterPath: json['poster_path'] as String,
          voteAverage: json['vote_average'] as num,
        );
      }).toList();
    }
    throw Exception('error fetching movies');
  }
}
