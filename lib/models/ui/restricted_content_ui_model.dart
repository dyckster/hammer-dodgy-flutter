class RestrictedContentUiModel {
  final String restrictedContentType;
  final String mediaType;
  final String title;
  final String description;
  final String language;
  final String icon;
  final bool isBlurred;
  final String timestamp;

  const RestrictedContentUiModel(
      {required this.restrictedContentType,
      required this.mediaType,
      required this.title,
      required this.description,
      required this.language,
      required this.isBlurred,
      required this.timestamp,
      required this.icon});
}
