import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:genieclass_streaming_mobile/core/route/router.dart';
import 'package:genieclass_streaming_mobile/core/route/routes.dart';
import 'package:genieclass_streaming_mobile/core/services/navigation_service.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/cfg/config.env');
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: GCColors.neutralChalk,
      ),
      title: 'GenieClass',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.liveClass,
      navigatorKey: navigatorKey,
      builder: BotToastInit(),
      navigatorObservers: <NavigatorObserver>[
        routeObserver,
        BotToastNavigatorObserver(),
      ],
    );
  }
}
