class Images {
  static const bool isFromFlutter =
      String.fromEnvironment("SOURCE") == "FLUTTER";

  static const String _basePath =
      '${isFromFlutter ? 'packages/genieclass_streaming_mobile/' : ''}assets/images/';

  static const String icSmallGeniebook =
      "${_basePath}ic_small_geniebook_logo.svg";
  static const String icClose = "${_basePath}ic_close.svg";

  static const String icPlay = "${_basePath}ic_play.svg";
  static const String icCalendar = "${_basePath}ic_calendar.svg";

  static const String icLevelFilter = "${_basePath}ic_level_filter.svg";
  static const String icLiveBadge = "${_basePath}ic_live_badge.svg";
  static const String icBell = "${_basePath}ic_bell.svg";
  static const String icBellActive = "${_basePath}ic_bell_active.svg";
}
