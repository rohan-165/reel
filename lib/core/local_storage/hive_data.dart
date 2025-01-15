import 'dart:convert';

import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';

abstract class HiveData {
  Future<void> saveUserDetail({required UserModel userModel});

  Future<UserModel?> getUserDetail();
}

class HiveDataImpl implements HiveData {
  // Implement the required methods for saving and retrieving user data from Hive database
  @override
  Future<void> saveUserDetail({required UserModel userModel}) {
    // Implement the saving logic here
    // For example, save userModel to Hive database
    String key = 'User-Model';
    String value = jsonEncode(userModel.toJson());
    return HiveCacheService().saveDataToCache(value: value, key: key);
  }

  @override
  Future<UserModel?> getUserDetail() async {
    // Implement the retrieving logic here
    // For example, retrieve userModel from Hive database
    String key = 'User-Model';
    String value = await HiveCacheService().getCacheData(key: key);
    if (value == null || value.isEmpty) return null;
    return UserModel.fromJson(jsonDecode(value));
  }
}
