import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hammer_dodgy/mapper/movie_ui_mapper.dart';
import 'package:hammer_dodgy/models/api/movie_api_model.dart';
import 'package:hammer_dodgy/models/ui/movie_ui_model.dart';
import 'package:hammer_dodgy/styles.dart';
import 'package:hammer_dodgy/usecase/get_movie_data_use_case.dart';
import 'package:hammer_dodgy/widgets/movie_links_widget.dart';
import 'package:hammer_dodgy/widgets/restricted_content_widget.dart';
import 'package:hammer_dodgy/widgets/search_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

  late Future<MovieApiModel> futureMovie;
  late MovieUiModel movie = MovieUiModel.empty();

  void _getMovieData(String id, String language) {
    setState(() {
      futureMovie = GetMovieDataUseCase().fetchMovie(id, language);
    });
  }

  void _launchUrl(String url) async {
    print("Launcing url: $url");
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    Widget restrictedContentWidget;

    if (movie.restrictedContent.isEmpty) {
      restrictedContentWidget = Container();
    } else {
      restrictedContentWidget = Expanded(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              movie.restrictedContent.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(left: 32, top: 16),
                  child: RestrictedContentWidget(
                      restrictedContent: movie.restrictedContent[index]))),
        ),
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87]))),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 64),
              child: Text(movie.movieName, style: Styles.movieTitleTextStyle)),
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 12),
              child: Text(
                movie.overview,
                style: Styles.movieDescriptionTextStyle,
              )),
          MovieLinksWidget(
            onImdbUrl: () => _launchUrl(movie.imdbLink),
            onMovieDbUrl: () => _launchUrl("https://www.themoviedb.org/"),
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
      SearchBarWidget(
        onPressed: (text) {
          _getMovieData(text, "en");
          futureMovie.then((value) => {
                setState(() {
                  movie = movieUiMapper.map(value);
                })
              });
        },
      )
    ]));
  }
}
