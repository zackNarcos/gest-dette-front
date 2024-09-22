import 'dart:math';

import 'package:d_liv/models/entity/user_model.dart';
import 'package:d_liv/models/repositories/core/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../environments/environments.dart';

class UsersRepository with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final String _authUrl = environments['dev']!['authUrl']!;

  Future<Response> register(User user) async {
    final response = await _apiService.post('$_authUrl/users', user.toJson());

    return response;
  }

  Future<Response> registerGuest(User user) async {
    print('registerGuest');
    final response = await _apiService.post('$_authUrl/users/guest', user.toJson());

    return response;
  }

  Future<Response> update(String firstName, String lastName,String userId) async {
    return await _apiService.put('$_authUrl/users/$userId', {
      'firstName': firstName,
      'lastName': lastName,
    });
  }
}