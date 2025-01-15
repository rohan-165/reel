import 'package:reel/core/routes/routes_name.dart';
import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/core/services/shared_pref_service.dart';

mixin LogoutMixin {
  void logout() {
    getIt<SharedPrefsServices>().clearSharedPrefsData();
    HiveCacheService().clearCacheData();
    getIt<NavigationService>().pushNamedAndRemoveUntil(RoutesName.login, false);
  }
}
