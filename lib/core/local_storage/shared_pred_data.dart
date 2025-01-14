import 'package:reel/core/constants/shared_pref_keys.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/core/services/shared_pref_service.dart';

abstract class AbsSharedPrefData {
  Future<void> setToken({required String value});
  String? get getToken;
}

class SharedPrefDataImpl extends AbsSharedPrefData {
  @override
  Future<void> setToken({required String value}) {
    return getIt<SharedPrefsServices>()
        .setString(key: SharedPrefKeys.tokenKey, value: value);
  }

  @override
  String? get getToken => getIt<SharedPrefsServices>().getString(
        key: SharedPrefKeys.tokenKey,
      );
}
