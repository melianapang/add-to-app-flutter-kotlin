import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferencesService>(
  (_) => SharedPreferencesService(),
);

enum SharedPrefKeys {
  mcsToken('mcsToken'),
  uid('uid'),
  apiKey('apiKey'),
  userId('userId'),
  mcsUserId('mcsUserId'),

  none('none');

  const SharedPrefKeys(
    this.label,
  );
  final String label;
}

class SharedPreferencesService {
  SharedPreferencesService() : super() {
    _initSharedPreferences();
  }

  late SharedPreferences _sharedPreferences;
  bool _ready = false;

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _getSharedPreferences() async {
    if (!_ready) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _ready = true;
    }
  }

  //String
  Future<String?> get(SharedPrefKeys key) async {
    await _getSharedPreferences();
    return _sharedPreferences.getString(key.label);
  }

  Future<void> set(SharedPrefKeys key, String value) async {
    await _getSharedPreferences();
    await _sharedPreferences.setString(key.label, value);
  }
  //String

  Future<void> clearStorage() async {
    await _sharedPreferences.clear();
  }
}
