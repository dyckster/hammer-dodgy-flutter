import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hammer_dodgy/mapper/MovieUiMapper.dart';
import 'package:hammer_dodgy/models/api/MovieApiModel.dart';
import 'package:hammer_dodgy/models/ui/MovieUiModel.dart';
import 'package:hammer_dodgy/usecase/GetMovieDataUseCase.dart';
import 'package:hammer_dodgy/widgets/RestrictedContentWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MovieUiMapper movieUiMapper = MovieUiMapper();

  dynamic movieIdController = TextEditingController();

  late Future<MovieApiModel> futureMovie;
  late MovieUiModel movie = MovieUiModel.empty();

  void _getMovieData(String id, String language) {
    setState(() {
      futureMovie = GetMovieDataUseCase().fetchMovie(id, language);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget restrictedContentWidget;
    if (movie.restrictedContent.isEmpty) {
      restrictedContentWidget = Container();
    } else {
      restrictedContentWidget = ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            movie.restrictedContent.length,
            (index) => Padding(
                padding: const EdgeInsets.only(left: 32, top: 16),
                child: RestrictedContentWidget(
                    restrictedContent: movie.restrictedContent[index]))),
      );
    }
    Widget backgroundContainer;
    if (movie == MovieUiModel.empty()) {
      backgroundContainer = Container();
    } else {
      backgroundContainer = Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(movie.posterPath), fit: BoxFit.cover)),
      );
    }

    return Scaffold(
        body: Stack(children: [
      backgroundContainer,
      Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.transparent, Colors.black87]))),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 64),
            child: Text(
              movie.movieName,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 12),
            child: Text(
              movie.overview,
              style: GoogleFonts.roboto(
                  textStyle:
                      const TextStyle(color: Color(0xD9FFFFFF), fontSize: 14)),
            ),
          ),
          restrictedContentWidget,
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 12),
            child: Text(
              "Нарушения в озвучке",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 28)),
            ),
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 4,
            child: TextField(
              controller: movieIdController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Enter Movie Id',
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed: (() {
                  _getMovieData(movieIdController.text, "en");
                  futureMovie.then((value) => {
                        setState(() {
                          movie = movieUiMapper.map(value);
                        })
                      });
                }),
                child: const Text("GO")),
          )
        ],
      )
    ]));
  }
}
