import 'package:flutter/material.dart';
import 'package:flutter_5_wd/models/user_model.dart';
import 'package:flutter_5_wd/providers/auth_provider.dart';
import 'package:flutter_5_wd/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_service.dart';

class SessionNotifier extends ChangeNotifier {
  String? token;
  UserModel? user;

  SessionNotifier() {
    _refreshUser();
  }

  void _refreshUser() async {
    final prefs = await SharedPreferences.getInstance();

    final existToken = prefs.getString('token');

    if (existToken == null) {
      return;
    }

    try {
      final response = await AuthProvider().refresh();

      onAuthenticationSuccess(response);
    } on ApiException catch (e) {
      token = null;
      user = null;
      await prefs.remove('token');
    }

    notifyListeners();
  }

  void onAuthenticationSuccess(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();

    final notificationToken = await NotificationService.init();

    token = json['token'];
    await prefs.setString('token', json['token']);

    if (notificationToken != null) {
      try {
        final response = await AuthProvider().refreshNotificationToken(notificationToken);

        user = UserModel.fromJson(response);
      } on ApiException catch (e) {
        debugPrint('Error refreshing notification token: ${e.message}');
      }
    } else {
      user = UserModel.fromJson(json['user']);
    }

    notifyListeners();
  }

  bool isAuthenticated() {
    return token != null && user != null;
  }

  bool isAdmin() {
    if (!isAuthenticated()) {
      return false;
    }

    return user!.roles.contains('ROLE_ADMIN');
  }
}
