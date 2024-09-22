import 'dart:convert';
import 'package:d_liv/models/repositories/core/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../../entity/user_model.dart';
import '../environments/environments.dart';

class AuthRepository with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final String _authUrl = environments['dev']!['authUrl']!;

  Future<AuthResponse> loginPhone(String phone) async {
    final response = await _apiService.post('$_authUrl/auth/login/phone', {
      'email': phone,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Response> loginEmail(String email, String password) async {
    print('object');
    return await _apiService.post('$_authUrl/auth/login/', {
      'email': email,
      'password': password,
    });
  }

  // confirm token
  Future<void> confirmToken(String token) async {
    final response = await _apiService.post('$_authUrl/auth/confirm-token', {
      'token': token,
    });

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to confirm token');
    }
  }

  Future<Response> fetchUserData() async {
    final response = await _apiService.get('$_authUrl/auth/me');

    return response;
  }

  Future<void> logout() async {
    // Effacer les données utilisateur et le token
  }

  Future<void> forgotPassword(String email) async {
    final response = await _apiService.post('$_authUrl/auth/password-reset', {'email': email});
    print (response);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to send password reset email');
    }
  }

  Future<void> resetPassword(String token, String newPassword, String email) async {
    final response = await _apiService.post('$_authUrl/auth/reset-password', {
      'token': token,
      'newPassword': newPassword,
      'email': email,
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to reset password');
    }
  }

  Future<bool> verifyPasswordResetToken(String email, String token) async {
    final response = await _apiService.post('$_authUrl/auth/verify-password-reset-token', {
      'email': email,
      'token': token,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to verify password reset token');
    }
  }
}