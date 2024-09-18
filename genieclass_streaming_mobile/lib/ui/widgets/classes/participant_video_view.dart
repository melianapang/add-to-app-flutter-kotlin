import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';

class ParticipantVideoView extends StatefulWidget {
  const ParticipantVideoView._({
    required this.participant,
    required this.showInfo,
    required this.isLocalParticipant,
  });

  final Participant participant;
  final bool showInfo;
  final bool isLocalParticipant;

  factory ParticipantVideoView.main({
    required RemoteParticipant participant,
  }) {
    return ParticipantVideoView._(
      participant: participant,
      showInfo: false,
      isLocalParticipant: false,
    );
  }

  factory ParticipantVideoView.participant({
    required Participant participant,
    required bool isLocalParticipant,
  }) {
    return ParticipantVideoView._(
      participant: participant,
      showInfo: true,
      isLocalParticipant: isLocalParticipant,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _ParticipantVideoViewState();
  }
}

class _ParticipantVideoViewState extends State<ParticipantVideoView> {
  TrackPublication? videoPubTrack;

  @override
  void initState() {
    super.initState();
    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
  }

  @override
  void dispose() {
    widget.participant.removeListener(_onParticipantChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ParticipantVideoView oldWidget) {
    oldWidget.participant.removeListener(_onParticipantChanged);
    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          if (videoPubTrack?.track != null)
            VideoTrackRenderer(
              videoPubTrack?.track as VideoTrack,
            ),
          _buildMutedVideoWidget(),
          _buildSpeakingIndicator(),
          _buildVideoInfoBanner(),
        ],
      ),
    );
  }

  Widget _buildMutedVideoWidget() {
    if (videoPubTrack?.muted != true) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      color: GCColors.navyDark,
      child: SvgPicture.asset(
        Images.icSmallGeniebook,
        width: 80,
        height: 80,
      ),
    );
  }

  Widget _buildSpeakingIndicator() {
    if (!widget.participant.isSpeaking) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        border: Border.all(
          color: GCColors.navyExtendedBright,
          width: 3,
        ),
      ),
    );
  }

  Widget _buildVideoInfoBanner() {
    if (widget.participant.name == "Teacher" || !widget.showInfo) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 4,
        ),
        color: GCColors.navyBlue.withOpacity(0.6),
        child: Stack(
          children: [
            Positioned(
              bottom: 2,
              child: SvgPicture.asset(
                Images.icSmallGeniebook,
                width: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Center(
                child: Text(
                  widget.participant.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GCTextStyle.callout(
                    color: GCColors.neutralChalk,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onParticipantChanged() {
    if (widget.isLocalParticipant) {
      _onLocalParticipantChanged();
      return;
    }

    final TrackPublication? videoTrack =
        widget.participant.videoTrackPublications.firstOrNull;
    final TrackPublication? videoPub =
        widget.participant.getTrackPublicationBySource(TrackSource.camera) ??
            videoTrack;

    if (videoPub?.muted != true && videoPub != null) {
      videoPubTrack = videoPub;
      setState(() {});
      return;
    }

    videoPubTrack = null;
    setState(() {});
  }

  void _onLocalParticipantChanged() {
    final LocalParticipant? localParticipant =
        widget.participant as LocalParticipant?;
    if (localParticipant == null) {
      return;
    }

    final LocalTrackPublication? videoPub =
        localParticipant.videoTrackPublications.firstOrNull ??
            localParticipant.getTrackPublicationBySource(TrackSource.camera);

    // localParticipant.videoTrackPublications.first.track ??

    if (videoPub?.muted != true && videoPub != null) {
      videoPubTrack = videoPub;
      setState(() {});
    }
  }
}
