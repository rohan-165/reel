import 'dart:convert';
import 'dart:developer';

import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';
import 'package:reel/feature/reel/domain/model/item_reel_model.dart';

abstract class HiveData {
  Future<void> saveUserDetail({required UserModel userModel});

  Future<UserModel?> getUserDetail();

  Future<void> saveReelData({
    required String key,
    required ItemReelModel itemModel,
  });
  Future<ItemReelModel?> getReelData({required String key});
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

  @override
  Future<void> saveReelData(
      {required String key, required ItemReelModel itemModel}) {
    try {
      // Implement the saving logic here
      // For example, save itemModel to Hive database
      String value = jsonEncode(itemModel.toJson());
      log("Set Item : $value");
      return HiveCacheService().saveDataToCache(value: value, key: key);
    } catch (e) {
      log('Error saving reel data to Hive: $e');
      rethrow;
    }
  }

  @override
  Future<ItemReelModel?> getReelData({required String key}) async {
    try {
      // Implement the retrieving logic here
      // For example, retrieve itemModel from Hive database
      dynamic value = await HiveCacheService().getCacheData(key: key);
      log("Get Item : $value");
      ItemReelModel itemModel = value != null
          ? ItemReelModel.fromJson(jsonDecode(value))
          : ItemReelModel();
      return itemModel;
    } catch (e) {
      log('Error retrieving reel data from Hive: $e');
      return null;
    }
  }
}
