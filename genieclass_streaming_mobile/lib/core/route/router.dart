import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/route/routes.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/camera_preview_view.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/live_class_livekit_view.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/small_live_class_livekit_view.dart';
import 'package:genieclass_streaming_mobile/ui/views/recorded_class/recorded_class_view.dart';

final routeObserver = RouteObserver<PageRoute<dynamic>>();

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    MaterialPageRoute<T>? buildRoute<T>({
      required Widget Function(BuildContext) builder,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<T>(
        settings: settings,
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      );
    }

    bool argsIsInvalid = false;

    switch (settings.name) {
      case Routes.cameraPreview:
        return buildRoute(
          builder: (_) => const CameraPreviewView(),
        );
      case Routes.smallLiveClass:
        SmallLiveClassLivekitViewParam param;
        // if (settings.arguments is SmallLiveClassLivekitViewParam) {
        //   param = settings.arguments as SmallLiveClassLivekitViewParam;
        // } else {
        //   argsIsInvalid = true;
        //   continue invalidArgs;
        // }
        return buildRoute(
          builder: (_) => const SmallLiveClassLiveKitView(
            param: null,
          ),
        );
      case Routes.liveClass:
        return buildRoute(
          builder: (_) => const LiveClassLiveKitView(),
        );

      case Routes.recordedClass:
        return buildRoute(
          builder: (_) => const RecordedClassView(),
        );

      invalidArgs:
      default:
        String message = 'No route defined for ${settings.name}';
        if (argsIsInvalid) message = 'Route argument is invalid';
        return buildRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(message),
            ),
          ),
        );
    }
  }
}
