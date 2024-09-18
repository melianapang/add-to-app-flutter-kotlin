class Illustrations {
  static const bool isFromFlutter =
      String.fromEnvironment("SOURCE") == "FLUTTER";

  static const String _basePath =
      '${isFromFlutter ? 'packages/genieclass_streaming_mobile/' : ''}assets/illustrations/';

  static const String defaultThumbnail =
      "${_basePath}illustration_default_thumbnail.png";
}
