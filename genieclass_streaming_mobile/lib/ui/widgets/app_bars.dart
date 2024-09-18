import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget buildAppBar(
  BuildContext context, {
  required String title,
  bool leading = false,
  List<Widget> actions = const <Widget>[],
  double? elevation,
}) {
  return AppBar(
    title: Text(
      title,
      style: GCTextStyle.title2Emphasized(
        color: GCColors.neutralChalk,
      ),
    ),
    backgroundColor: GCColors.navyDark,
    centerTitle: false,
    elevation: 0,
    automaticallyImplyLeading: true,
    leading: leading
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                Images.icSmallGeniebook,
                width: 8,
              ),
            ),
          )
        : null,
    actions: actions,
  );
}
