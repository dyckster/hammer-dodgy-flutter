import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hammer_dodgy/styles.dart';

class MovieLinksWidget extends StatelessWidget {
  const MovieLinksWidget(
      {Key? key, required this.onMovieDbUrl, required this.onImdbUrl})
      : super(key: key);

  final VoidCallback onMovieDbUrl;
  final VoidCallback onImdbUrl;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
        onTap: onMovieDbUrl,
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text.rich(TextSpan(
              text: "Информация для сайта получена с сайта ",
              style: Styles.movieLinksTextStyle,
              children: [
                TextSpan(
                    text: "moviedb.com",
                    style: Styles.movieLinksTextStyleUnderline)
              ])),
        ),
      ),
      Container(
        color: Colors.white,
        width: 2,
        height: 16,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 6),
        child: Icon(
          Icons.link,
          color: Colors.white,
        ),
      ),
      GestureDetector(
        onTap: onImdbUrl,
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text.rich(TextSpan(
              text: "Фильм на imdb.com",
              style: Styles.movieLinksTextStyleUnderline)),
        ),
      )
    ]);
  }
}
