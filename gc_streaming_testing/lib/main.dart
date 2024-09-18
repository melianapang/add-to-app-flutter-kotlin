import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genieclass_streaming_mobile/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/cfg/.env');
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
