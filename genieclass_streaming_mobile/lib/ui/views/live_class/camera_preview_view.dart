import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/route/routes.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/core/utils/permission_utils.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/small_live_class_livekit_view.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/class_card.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:genieclass_streaming_mobile/view_models/live_class/camera_preview_view_model.dart';
import 'package:genieclass_streaming_mobile/view_models/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPreviewViewParam {
  CameraPreviewViewParam({
    required this.className,
    required this.onlineLessonId,
    required this.meetingId,
    required this.levelId,
    required this.subjectId,
    required this.wsUrl,
  });

  final String className;
  final String onlineLessonId;
  final String meetingId;
  final String levelId;
  final String subjectId;
  final String wsUrl;
}

///We are not using the `CameraPreviewView` class because it depends on the `CameraAwesome` library,
///which requires us to request permissions before initializing `CameraPreviewView`.
///If permissions are not granted, or if they are requested within this class,
///it will cause an error in the native app, preventing the camera preview from displaying.
/// We should also check for newer versions of the library in case updates address this issue.
///For now, let's just use native's codebase for this page.
class CameraPreviewView extends ConsumerStatefulWidget {
  const CameraPreviewView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CameraPreviewViewState();
}

class _CameraPreviewViewState extends ConsumerState<CameraPreviewView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<CameraPreviewViewModel>(
        model: CameraPreviewViewModel(
          liveClassChannelService: ref.read(
            liveClassChannelService,
          ),
        ),
        onModelReady: (viewModel) async {
          bool granted =
              await PermissionUtils.requestPermissions(listPermission: [
            Permission.camera,
            Permission.audio,
            Permission.microphone,
          ]);

          viewModel.setPermissionsStatus(granted: granted);
          if (granted) {
            viewModel.init();
            return;
          }

          if (!context.mounted) return;
          Navigator.pop(context);
        },
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: GCColors.navyDark,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildCameraPreview(viewModel)),
                Expanded(child: _buildInfoView(viewModel)),
              ],
            ),
          );
        });
  }

  Widget _buildCameraPreview(CameraPreviewViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: GCColors.alertBanana,
          width: 350,
          height: (9 / 16) * 350,
          child: viewModel.arePremissionsGranted
              ? CameraAwesomeBuilder.previewOnly(
                  previewFit: CameraPreviewFit.cover,
                  builder: (cameraState, preview) {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);

                    return const SizedBox.shrink();
                  },
                )
              : _buildLoadingIndicator(),
        ),
      ),
    );
  }

  Widget _buildInfoView(CameraPreviewViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                Images.icSmallGeniebook,
                width: 24,
              ),
              Spacings.horSpace(16),
              Text(
                viewModel.param.className,
                style: GCTextStyle.title1(
                  boldness: GCFontBoldness.extraBold,
                  color: GCColors.neutralChalk,
                ),
              ),
            ],
          ),
          Spacings.verSpace(8),
          Text(
            "Friday, 23 February 2024, 10:30 AM",
            style: GCTextStyle.callout(
              color: GCColors.neutralChalk,
            ),
          ),
          Spacings.verSpace(24),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: GCColors.navyBlue.withOpacity(0.5),
            ),
            child: Text(
              "Please enable your camera.\nCamera will always turned on during this class.",
              style: GCTextStyle.body2(
                color: GCColors.neutralChalk,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacings.verSpace(24),
          SizedBox(
            width: double.maxFinite,
            child: _buildGoToClassButton(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildGoToClassButton(CameraPreviewViewModel viewModel) {
    return ClassCard(
      onTap: () {
        if (viewModel.isLoadingData) return;

        Navigator.pushReplacementNamed(
          context,
          Routes.smallLiveClass,
          arguments: SmallLiveClassLivekitViewParam(
            onlineLessonId: viewModel.param.onlineLessonId,
            meetingId: viewModel.param.meetingId,
            levelId: viewModel.param.levelId,
            subjectId: viewModel.param.subjectId,
            wsUrl: viewModel.param.wsUrl,
          ),
        );
      },
      height: 32,
      padding: const EdgeInsets.all(8),
      bgColor: viewModel.isLoadingData
          ? GCColors.neutralGraphite
          : GCColors.apricotOrange,
      shadowBgColor:
          viewModel.isLoadingData ? GCColors.neutralDust : GCColors.orangeDark,
      innerBorderRadius: BorderRadius.circular(8),
      outerBorderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Text(
        viewModel.isLoadingData ? 'Loading...' : 'Join Class',
        style: GCTextStyle.bodyEmphasized(
          color: GCColors.neutralChalk,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          GCColors.apricotOrange,
        ),
      ),
    );
  }
}
