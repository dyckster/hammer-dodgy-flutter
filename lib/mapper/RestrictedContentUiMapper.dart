import 'package:hammer_dodgy/models/ui/RestrictedContentUiModel.dart';

import '../models/api/RestrictedContentApiModel.dart';

class RestrictedContentUiMapper {
  RestrictedContentUiModel map(RestrictedContentApiModel restrictedContent) {
    return RestrictedContentUiModel(
        restrictedContentType: restrictedContent.restrictedContentType,
        mediaType: restrictedContent.mediaType,
        title: getTitle(restrictedContent),
        description: restrictedContent.description,
        language: restrictedContent.language,
        icon: getImage(restrictedContent),
        isBlurred: restrictedContent.mediaType != "VIDEO",
        timestamp: "");
  }

  String getImage(RestrictedContentApiModel restrictedContent) {
    switch (restrictedContent.restrictedContentType) {
      case "RECENT":
        {
          return "assets/img_recent_movie.png";
        }
      case "ADULT":
        {
          return "assets/img_adult.png";
        }
      default:
        {
          return "assets/img_video.png";
        }
    }
  }

  String getTitle(RestrictedContentApiModel restrictedContent) {
    switch (restrictedContent.restrictedContentType) {
      case "RECENT":
        {
          return "Movie was released recent";
        }
      case "ADULT":
        {
          return "Movie has adult content";
        }
      default:
        {
          return "Movie has restricted content";
        }
    }
  }
}
