class RestrictedContentApiModel {
  final String restrictedContentType;
  final String mediaType;
  final String description;
  final String language;

  const RestrictedContentApiModel(
      {required this.restrictedContentType,
      required this.mediaType,
      required this.description,
      required this.language});

  factory RestrictedContentApiModel.fromJson(Map<String, dynamic> json) {
    return RestrictedContentApiModel(
        restrictedContentType: json['restrictedContentType'] as String,
        mediaType: json['mediaType'] as String,
        description: json['description'] as String,
        language: json['language'] as String);
  }
}
