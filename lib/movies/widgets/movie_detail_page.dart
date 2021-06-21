import 'package:flutter/material.dart';
import 'package:popular_movies/movies/movies.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key, required this.movie})
      : super(
          key: key,
        );

  final DetailMovie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.headline4,
              )),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Rating: ${movie.voteAverage.toStringAsFixed(1)}',
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Release date: ${movie.releaseDate}',
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Genres: ${movie.genres.map((x) => x["name"]).join(", ")}'),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(movie.overview,
                  style: Theme.of(context).textTheme.bodyText1)),
        ],
      ),
    );
  }
}
