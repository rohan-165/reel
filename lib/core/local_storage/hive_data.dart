import 'dart:convert';
import 'dart:developer';

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
    try {
      // Implement the saving logic here
      // For example, save userModel to Hive database
      String key = 'User-Model';
      String value = jsonEncode(userModel.toJson());
      return HiveCacheService().saveDataToCache(value: value, key: key);
    } catch (e) {
      log('Error saving user detail to Hive: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserDetail() async {
    try {
      // Implement the retrieving logic here
      // For example, retrieve userModel from Hive database
      String key = 'User-Model';
      dynamic value = await HiveCacheService().getCacheData(key: key);
      UserModel userModel = UserModel.fromJson(jsonDecode(value));

      return userModel;
    } catch (e) {
      log('Error retrieving user detail from Hive: $e');
      return null;
    }
  }
}
