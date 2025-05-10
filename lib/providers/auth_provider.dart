import 'package:flutter_5_wd/services/api_service.dart';

class AuthProvider {
  Future login({required Map<String, dynamic> data}) {
    return ApiService.request(
      uri: 'auth',
      method: 'POST',
      data: data,
    );
  }

  Future refresh() {
    return ApiService.request(
      uri: 'refresh',
      method: 'POST',
    );
  }
}
