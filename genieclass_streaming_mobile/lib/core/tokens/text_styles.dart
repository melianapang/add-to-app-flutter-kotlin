import 'package:flutter/material.dart';

import 'colors.dart';

enum GCFontBoldness {
  light,
  regular,
  semiBold,
  bold,
  extraBold,
}

extension GCFontBoldnessExt on GCFontBoldness {
  static const Map<GCFontBoldness, FontWeight> _inInts =
      <GCFontBoldness, FontWeight>{
    GCFontBoldness.light: FontWeight.w300,
    GCFontBoldness.regular: FontWeight.w400,
    GCFontBoldness.semiBold: FontWeight.w600,
    GCFontBoldness.bold: FontWeight.w700,
    GCFontBoldness.extraBold: FontWeight.w800,
  };

  FontWeight get inInt => _inInts[this] ?? FontWeight.w400;
}

class GCTextStyle {
  /*
    New Text Styles
  */
  static TextStyle largeTitle1({
    num fontSize = 34,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
        fontSize: fontSize.toDouble(),
        fontWeight: boldness.inInt,
        color: color,
        height: fontHeight,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily: "opensans",
        decorationColor: color,
        fontStyle: style);
  }

  static TextStyle largeTitle2({
    num fontSize = 24,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle largeTitle2Emphasized({
    num fontSize = 24,
    GCFontBoldness boldness = GCFontBoldness.extraBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle title1({
    num fontSize = 20,
    GCFontBoldness boldness = GCFontBoldness.semiBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle title2({
    num fontSize = 16,
    GCFontBoldness boldness = GCFontBoldness.semiBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle title2Emphasized({
    num fontSize = 16,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle cardTitle({
    num fontSize = 14,
    GCFontBoldness boldness = GCFontBoldness.extraBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle body({
    num fontSize = 16,
    GCFontBoldness boldness = GCFontBoldness.regular,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle bodyEmphasized({
    num fontSize = 16,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle body2({
    num fontSize = 14,
    GCFontBoldness boldness = GCFontBoldness.regular,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle body2Emphasized({
    num fontSize = 14,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle callout({
    num fontSize = 14,
    GCFontBoldness boldness = GCFontBoldness.semiBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle caption({
    num fontSize = 12,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle footnote({
    num fontSize = 10,
    GCFontBoldness boldness = GCFontBoldness.semiBold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle tabBar({
    num fontSize = 10,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: "opensans",
      decorationColor: color,
      fontStyle: style,
    );
  }

  static TextStyle underline({
    num fontSize = 12,
    GCFontBoldness boldness = GCFontBoldness.bold,
    Color color = GCColors.textDefault,
    double? fontHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: boldness.inInt,
      color: color,
      height: fontHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: color,
      fontStyle: style,
    );
  }
}
