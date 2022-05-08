import 'package:hammer_dodgy/mapper/RestrictedContentUiMapper.dart';
import 'package:hammer_dodgy/models/ui/RestrictedContentUiModel.dart';

import '../models/api/MovieApiModel.dart';
import '../models/ui/MovieUiModel.dart';

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
