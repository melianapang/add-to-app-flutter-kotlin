import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/app_bars.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/class_card.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class RecordedClassView extends StatefulWidget {
  const RecordedClassView({
    super.key,
  });

  @override
  State<RecordedClassView> createState() => _RecordedClassViewState();
}

class _RecordedClassViewState extends State<RecordedClassView> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(
          // "https://dl6.webmfiles.org/big-buck-bunny_trailer.webm",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GCColors.navyDark,
      appBar: buildAppBar(
        context,
        title: 'Recorded Class',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * (9 / 16),
              child: Chewie(controller: _chewieController),
            ),
            Spacings.verSpace(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Images.icCalendar,
                    width: 16,
                  ),
                  Spacings.horSpace(8),
                  Text(
                    'Tanggal',
                    style: GCTextStyle.callout(
                      color: GCColors.neutralChalk,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Judul videonya apa",
                style: GCTextStyle.title1(
                  boldness: GCFontBoldness.bold,
                  color: GCColors.neutralChalk,
                ),
              ),
            ),
            Spacings.verSpace(4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Deskripsii videonya apa",
                style: GCTextStyle.title2(
                  color: GCColors.neutralChalk,
                ),
              ),
            ),
            Spacings.verSpace(12),
            _buildQuizButton(),
            Spacings.verSpace(12),
            _buildCreateWorksheetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateWorksheetButton() {
    return ClassCard(
      height: 24,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      bgColor: GCColors.skyBlue,
      shadowBgColor: GCColors.blueBoxShadow,
      innerBorderRadius: BorderRadius.circular(8),
      outerBorderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(8),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Images.icPlay,
            width: 12,
            height: 12,
          ),
          Spacings.horSpace(4),
          Text(
            "Create Worksheet",
            style: GCTextStyle.caption(
              color: GCColors.neutralChalk,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton() {
    return ClassCard(
      height: 24,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      bgColor: GCColors.purple200,
      shadowBgColor: GCColors.subjectPurple,
      innerBorderRadius: BorderRadius.circular(8),
      outerBorderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(8),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Images.icPlay,
            width: 12,
            height: 12,
          ),
          Spacings.horSpace(4),
          Text(
            "Quiz 2/2",
            style: GCTextStyle.caption(
              color: GCColors.neutralChalk,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildChewie() {
  //   return Chewie(
  //     controller: _cubit.chewieController!,
  //   );
  // }

  // Widget _buildWebView(String url) {
  //   return PlatformWebViewWidget(
  //     PlatformWebViewWidgetCreationParams(controller: _cubit.webViewController),
  //   ).build(context);
  // }
}
