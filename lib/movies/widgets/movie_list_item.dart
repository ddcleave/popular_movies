import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies/movies.dart';
import 'package:popular_movies/movies/view/detail_page.dart';
import 'package:http/http.dart' as http;

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;
  // late MovieBloc _movieBloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Image.network(
            'https://image.tmdb.org/t/p/w200${movie.posterPath}'),
        title: Text(movie.title),
        subtitle: Text(movie.voteAverage.toStringAsFixed(1)),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => MovieBloc(httpClient: http.Client())..add(DetailMovieFetched(movie.id)),
                child: DetailPage(id: movie.id),
                )));
        },
      ),
    );
  }
}
