import 'package:hammer_dodgy/models/ui/RestrictedContentUiModel.dart';

class MovieUiModel {
  final String id;
  final String movieName;
  final bool adult;
  final String releaseDate;
  final int runtime;
  final String posterPath;
  final String imdbLink;
  final String overview;
  final List<RestrictedContentUiModel> restrictedContent;

  const MovieUiModel(
      {required this.id,
      required this.movieName,
      required this.adult,
      required this.releaseDate,
      required this.runtime,
      required this.posterPath,
      required this.imdbLink,
      required this.overview,
      required this.restrictedContent});

  factory MovieUiModel.empty() {
    return const MovieUiModel(
        id: "0",
        movieName: "Loading",
        adult: false,
        releaseDate: "",
        runtime: 0,
        posterPath: "",
        imdbLink: "",
        overview: "",
        restrictedContent: <RestrictedContentUiModel>[]);
  }
}
