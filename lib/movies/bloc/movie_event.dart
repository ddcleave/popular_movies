part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieFetched extends MovieEvent {}

class DetailMovieFetched extends MovieEvent {
  final int id;

  DetailMovieFetched(this.id);
}
