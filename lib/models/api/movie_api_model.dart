import 'package:hammer_dodgy/models/api/restricted_content_api_model.dart';

class MovieApiModel {
  final String id;
  final String movieName;
  final bool adult;
  final String releaseDate;
  final int runtime;
  final String posterPath;
  final String imdbLink;
  final String overview;
  final List<RestrictedContentApiModel> restrictedContent;

  const MovieApiModel(
      {required this.id,
        required this.movieName,
      required this.adult,
      required this.releaseDate,
      required this.runtime,
      required this.posterPath,
      required this.imdbLink,
      required this.overview,
      required this.restrictedContent});

  factory MovieApiModel.fromJson(Map<String, dynamic> json) {
    print(json);
    List<RestrictedContentApiModel> contentList = <RestrictedContentApiModel>[];
    if (json['restrictedContentList'] != null) {
      json['restrictedContentList'].forEach((v) {
        contentList.add(RestrictedContentApiModel.fromJson(v));
      });
    }
    return MovieApiModel(
        id: json['id'] as String,
        movieName: json['movieName'] as String,
        adult: json['adult'] as bool,
        releaseDate: json['releaseDate'] as String,
        runtime: json['runtime'] as int,
        posterPath: json['posterPath'] as String,
        imdbLink: json['imdbLink'] as String,
        overview: json['overview'] as String,
        restrictedContent: contentList);
  }
}
