import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_movies/app.dart';
import 'package:popular_movies/simple_bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}
