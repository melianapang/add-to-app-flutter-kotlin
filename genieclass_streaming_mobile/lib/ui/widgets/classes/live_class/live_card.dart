import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/class_card.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class LiveCard extends StatefulWidget {
  const LiveCard({
    super.key,
    // required this.item,
    required this.onTap,
    // required this.reminderOnTap,
    this.width,
  });

  final double? width;
  // final ScheduleEntity item;
  final Function() onTap;
  // final Function(bool isSet, ScheduleEntity item) reminderOnTap;

  @override
  State<LiveCard> createState() => _LiveCardState();
}

class _LiveCardState extends State<LiveCard> {
  final bool _reminderIsSet = false;
  final bool _isLive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(LiveCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClassCard(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildDateHeader(),
              _isLive ? _buildLiveBadge() : _buildReminderButton(context),
            ],
          ),
          Spacings.verSpace(4),
          Text(
            "Nama kelasNama kelasNama kelasNama kelasNama kelasNama kelasNama kelas",
            style: GCTextStyle.bodyEmphasized(
              color: GCColors.navyBlue,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacings.verSpace(4),
          Text(
            "Nama kelasNama kelasNama kelasNama kelasNama kelasNama kelasNama kelas",
            style: GCTextStyle.body2(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacings.verSpace(8),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildQuizButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(
            Images.icCalendar,
            width: 12,
            height: 12,
            colorFilter: const ColorFilter.mode(
              GCColors.apricotOrange,
              BlendMode.srcIn,
            ),
          ),
          Spacings.horSpace(4),
          Expanded(
            child: Text(
              "",
              style: GCTextStyle.caption(
                color: GCColors.skyBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderButton(BuildContext context) {
    return SvgPicture.asset(
      _reminderIsSet ? Images.icBellActive : Images.icBell,
      width: 24,
      height: 24,
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: GCColors.alertErrorChili,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Images.icLiveBadge,
            width: 12,
            height: 12,
          ),
          Spacings.horSpace(4),
          Text(
            'LIVE',
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
      margin: const EdgeInsets.all(0),
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
