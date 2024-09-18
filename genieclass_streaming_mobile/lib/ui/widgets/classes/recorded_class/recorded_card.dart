import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/illustration_paths.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/class_card.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecordedCard extends StatelessWidget {
  const RecordedCard({
    super.key,
    // required this.item,
    this.width,
    required this.onTap,
  });

  final double? width;
  // final ScheduleEntity item;
  final VoidCallback onTap;

  final double thumbnailHeight = 175;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        width: width,
        child: Column(
          children: [
            _buildImageCard(),
            _buildBodyCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return LayoutBuilder(builder: (_, constraints) {
      return Stack(
        children: [
          //shadow-background image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: CachedNetworkImage(
              width: constraints.maxWidth,
              height: thumbnailHeight,
              imageUrl: "",
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) => Image.asset(
                Illustrations.defaultThumbnail,
                fit: BoxFit.cover,
              ),
              errorWidget: (BuildContext context, String url, _) => Image.asset(
                Illustrations.defaultThumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //black layer to make the background image like shadow
          Container(
            width: constraints.maxWidth,
            height: thumbnailHeight,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          //thumbnail image
          Padding(
            padding: const EdgeInsets.only(
              left: 4,
            ),
            child: _buildClassThumbnail(
              constraints.maxWidth,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBodyCard() {
    return ClassCard(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      innerBorderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(8),
      ),
      outerBorderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(8),
      ),
      onTap: () {},
      width: width,
      child: Column(
        children: [
          Spacings.verSpace(12),
          ..._buildClassInfoView(),
          Spacings.verSpace(8),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildCreateWorksheetButton(),
          ),
          Spacings.verSpace(8),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildQuizButton(),
          ),
          Spacings.verSpace(12),
        ],
      ),
    );
  }

  Widget _buildClassThumbnail(double thumbnailWidth) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: CachedNetworkImage(
            width: thumbnailWidth - 4,
            height: thumbnailHeight,
            imageUrl: "",
            fit: BoxFit.cover,
            placeholder: (BuildContext context, String url) => Image.asset(
              Illustrations.defaultThumbnail,
              fit: BoxFit.cover,
            ),
            errorWidget: (BuildContext context, String url, _) => Image.asset(
              Illustrations.defaultThumbnail,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SvgPicture.asset(
          Images.icPlay,
          width: 24,
          height: 30,
        ),
      ],
    );
  }

  List<Widget> _buildClassInfoView() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Images.icCalendar,
              width: 12,
              height: 12,
            ),
            Spacings.horSpace(4),
            Text(
              "Datetime",
              style: GCTextStyle.caption(
                color: GCColors.skyBlue,
              ),
            )
          ],
        ),
      ),
      Spacings.verSpace(4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          "Nama kelasNama kelasNama kelasNama kelasNama kelasNama kelasNama kelas",
          style: GCTextStyle.bodyEmphasized(
            color: GCColors.navyBlue,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Spacings.verSpace(4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          "Nama kelasNama kelasNama kelasNama kelasNama kelasNama kelasNama kelas",
          style: GCTextStyle.body2(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  Widget _buildCreateWorksheetButton() {
    return ClassCard(
      height: 24,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 12),
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
      margin: const EdgeInsets.symmetric(horizontal: 12),
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
}
