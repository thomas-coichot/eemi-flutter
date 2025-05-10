import 'package:flutter/material.dart';
import 'package:flutter_5_wd/models/user_model.dart';
import 'package:flutter_5_wd/providers/auth_provider.dart';
import 'package:flutter_5_wd/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      token = response['token'];
      user = UserModel.fromJson(response['user']);

      await prefs.setString('token', token!);
    } on ApiException catch (e) {
      token = null;
      user = null;
    }

    notifyListeners();
  }

  void onAuthenticationSuccess(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();

    token = json['token'];
    user = UserModel.fromJson(json['user']);

    await prefs.setString('token', token!);

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
