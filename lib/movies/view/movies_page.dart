import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies/movies.dart';
import 'package:http/http.dart' as http;

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie')),
      body: BlocProvider(
        create: (_) => MovieBloc(httpClient: http.Client())..add(MovieFetched()),
        child: MoviesList(),
      ),
    );
  }
}
