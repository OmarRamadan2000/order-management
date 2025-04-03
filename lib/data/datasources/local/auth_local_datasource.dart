import 'dart:convert';
import '../../../core/storage/shared_pref_manager.dart';
import '../../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheUserData(UserModel userModel);
  Future<bool> isUserLoggedIn();
  UserModel? getUser();
  Future<bool> clearUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPrefManager sharedPrefManager;
  final String userKey = 'USER_DATA';
  final String loginStatusKey = 'IS_LOGGED_IN';

  AuthLocalDataSourceImpl({required this.sharedPrefManager});

  @override
  Future<bool> cacheUserData(UserModel userModel) async {
    await sharedPrefManager.saveData(
      key: userKey,
      value: json.encode(userModel.toJson()),
    );
    return await sharedPrefManager.saveData(key: loginStatusKey, value: true);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return sharedPrefManager.getData(key: loginStatusKey) ?? false;
  }

  @override
  UserModel? getUser() {
    final jsonString = sharedPrefManager.getData(key: userKey);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<bool> clearUserData() async {
    await sharedPrefManager.remove(userKey);
    return await sharedPrefManager.saveData(key: loginStatusKey, value: false);
  }
}
