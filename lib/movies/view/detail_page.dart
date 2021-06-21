import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/movies/movies.dart';
import 'package:popular_movies/movies/widgets/movie_detail_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({ Key? key, required this.id }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.detailMovies.containsKey(id))
          return MovieDetailPage(movie: state.detailMovies[id]!);
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}