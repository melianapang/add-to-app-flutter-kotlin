import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  static EnvironmentEnum? _getEnvEnum(String environment) =>
      envMapping[environment];

  static EnvironmentEnum? get env {
    return _getEnvEnum(dotenv.env['ENV'] ?? '');
  }

  static String get baseURL {
    return dotenv.env['BASE_URL'] ?? '';
  }

  static String get streamBaseURL {
    return dotenv.env['STREAM_BASE_URL'] ?? '';
  }

  static String get imageBaseURL {
    final String url = dotenv.env['BASE_URL'] ?? '';
    return '$url/';
  }
}

enum EnvironmentEnum {
  staging,
  production,
}

extension EnvironmentEnumExtension on EnvironmentEnum {
  static const Map<EnvironmentEnum, String> values = <EnvironmentEnum, String>{
    EnvironmentEnum.staging: 'staging',
    EnvironmentEnum.production: 'production',
  };

  String? get value => values[this];
}

Map<String?, EnvironmentEnum> envMapping = <String?, EnvironmentEnum>{
  EnvironmentEnum.staging.value: EnvironmentEnum.staging,
  EnvironmentEnum.production.value: EnvironmentEnum.production,
};
