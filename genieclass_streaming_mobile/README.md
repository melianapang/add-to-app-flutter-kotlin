# GenieClass Streaming module

This module is using Flutter v3.22.0.

## Getting Started

1. `cp /assets/cfg/.env.example /assets/cfg/config.env`
    Ask your peers for the values.
    The env file should have name (`config.env` not only `.env`) to be detected from the native side.
2. `flutter pub run build_runner build --delete-conflicting-outputs`
3. `flutter pub get`
4. (optional) Create Flutter App project as testing app, replace your `MainApp()` function inside `runApp()` function in `main.dart` to `MainApp()` from this module. 
    It will look like this:
    ```import 'package:flutter/material.dart';
    import 'package:flutter_dotenv/flutter_dotenv.dart';
    import 'package:flutter_riverpod/flutter_riverpod.dart';
    import 'package:genieclass_streaming_mobile/main.dart';

    Future<void> main() async {
        WidgetsFlutterBinding.ensureInitialized();

        await dotenv.load(fileName: 'assets/cfg/config.env');
        runApp(
            const ProviderScope(
            child: MainApp(),
            ),
       );
    }```dart
    
5. (optional) Also create `/assets/cfg/config.env` inside the testing Flutter App.
6. (optional) Register this module in the `dependencies` section inside `pubspec.yaml` (in testing Flutter app):
    ```dependencies:
        genieclass_streaming_mobile:
            path: ../genieclass_streaming_mobile
        flutter_riverpod: ^2.4.0
        flutter_dotenv: ^5.1.0```dart

7. (optional) Register the assets folder in `pubspec.yaml` (in testing Flutter app).
8. (optional) When running the Flutter app for testing, you need to replace certain values that are received from the native side with dummy values.
8. Run the testing app and get start!