import 'dart:convert';

import 'package:flutter/material.dart';

import '../storage/local_storage.dart';

class SessionController {
  final LocalStorage sharedPreferenceClass = LocalStorage();
  static final SessionController _session = SessionController._internal();

  static bool? isLogin;

  static Map<String, dynamic>? userAccount;

  SessionController._internal() {
    isLogin = false;
  }

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInPreference(Map<String, dynamic> user) async {
    sharedPreferenceClass.setValue('userData', jsonEncode(user));
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  Future<void> getUserFromPreference() async {
    try {
      String userData = await sharedPreferenceClass.readValue('userData');
      var loginStatus = await sharedPreferenceClass.readValue('isLogin');

      if (userData.isNotEmpty) {
        SessionController.userAccount = jsonDecode(userData);
      }
      SessionController.isLogin = loginStatus == 'true';
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
