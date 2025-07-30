import 'dart:convert';


import 'package:hisab_kitab/Utils/prefsHelper.dart';

import '../Models/User.dart';
import 'constants.dart';

class Prefs {

  // static Future<SocialUser?> get getAppleCredentials async {
  //   String? value = await PreferencesHelper.getString(Constants.APPLE_PREFS);
  //   return value != null ? SocialUser.fromJson(json.decode(value)) : null;
  // }
  //
  // static Future setAppleCredentials(SocialUser socialUser) {
  //   return PreferencesHelper.setString(
  //       Constants.APPLE_PREFS, json.encode(socialUser.toMap()));
  // }


  static Future setUser(User user) {
    return PreferencesHelper.setString(
        Constants.user, json.encode(user.toJson()));
  }

  static Future<void> getUser(Function(User?) success) async {
    String? string = await PreferencesHelper.getString(Constants.user);
    if (string != null) {
      return success(User.fromJson(json.decode(string)));
    } else {
      return success(null);
    }
  }

  static Future<User?> getUserSync() async {
    String? string = await PreferencesHelper.getString(Constants.user);
    if (string != null) {
      return User.fromJson(json.decode(string));
    } else {
      return null;
    }
  }

  static void removeUser() {
    PreferencesHelper.remove(Constants.user);
    // removeFCMToken();
  }
}
