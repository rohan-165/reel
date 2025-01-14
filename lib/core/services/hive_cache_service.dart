import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveCacheService {
  final String _cacheKey = "reel-cache";

  final List<Box> _boxList = [];

  // Private constructor
  HiveCacheService._privateConstructor();

  // Singleton instance
  static final HiveCacheService _instance =
      HiveCacheService._privateConstructor();

  // Factory constructor to return the singleton instance
  factory HiveCacheService() {
    return _instance;
  }

  Future<void> initCacheService() async {
    try {
      String dirPath = Platform.isIOS
          ? (await getApplicationSupportDirectory()).path
          : (await getApplicationDocumentsDirectory()).path;

      Hive.init(dirPath);
      _boxList.add(await Hive.openBox(_cacheKey));
    } catch (e) {
      log("::: Hive Initialization Error ::: [Local Stogare] :::");
    }
  }

  /// ==================== LOGIC TO GENERATE, DELETE & UPDATE UNIQUE KEYS ===================================

  Future<void> saveDataToCache({
    required dynamic value,
    required String key,
  }) async {
    try {
      Map<String, dynamic> cacheData = {};

      String? cacheKeyData = _boxList.first.get(_cacheKey);
      if (cacheKeyData != null && cacheKeyData.isNotEmpty) {
        cacheData = jsonDecode(cacheKeyData);
      }

      cacheData[key] = value;
      await Future.delayed(Duration(milliseconds: 100));
      await _boxList.first.put(_cacheKey, jsonEncode(cacheData));
    } catch (e) {
      log("::: Can't Save Data To Hive ::: [NetworkCacheService] :::");
      rethrow;
    }
  }

  Future<dynamic> getCacheData({
    required String key,
  }) async {
    try {
      Map<String, dynamic> cachedData = {};

      String? cacheKeyData = _boxList.first.get(_cacheKey);
      if (cacheKeyData != null && cacheKeyData.isNotEmpty) {
        Map<String, dynamic> responseData = jsonDecode(cacheKeyData);
        if (responseData.containsKey(key)) {
          cachedData = responseData[key];
          if (cachedData.isNotEmpty) {
            return cachedData;
          }
        }
      }
      return cachedData;
    } catch (e) {
      log("::: Can't Return Data From Hive ::: [Local Stogare] :::");
      return {};
    }
  }

  Future<void> clearCacheData() async {
    try {
      await _boxList.first.clear();
    } catch (e) {
      log("::: Error Raised During Cache Data Clear ::: [Local Stogare] :::");
    }
  }
}
