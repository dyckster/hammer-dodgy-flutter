import 'package:hammer_dodgy/mapper/restricted_content_ui_mapper.dart';
import 'package:hammer_dodgy/models/ui/restricted_content_ui_model.dart';

import '../models/api/movie_api_model.dart';
import '../models/ui/movie_ui_model.dart';

class MovieUiMapper {
  RestrictedContentUiMapper restrictedContentUiMapper =
      RestrictedContentUiMapper();

  MovieUiModel map(MovieApiModel movieApi) {
    List<RestrictedContentUiModel> restrictedContent = movieApi
        .restrictedContent
        .map((e) => restrictedContentUiMapper.map(e))
        .toList();

    return MovieUiModel(
        id: movieApi.id,
        movieName: movieApi.movieName,
        adult: movieApi.adult,
        releaseDate: movieApi.releaseDate,
        runtime: movieApi.runtime,
        posterPath: movieApi.posterPath,
        imdbLink: movieApi.imdbLink,
        overview: movieApi.overview,
        restrictedContent: restrictedContent);
  }
}
