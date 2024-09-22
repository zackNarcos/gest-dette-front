import 'dart:convert';
import 'package:d_liv/models/provider/provider.dart';
import 'package:d_liv/shared/constants/keys.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final http.Client _client = http.Client();

  final StorageData _storage = Get.find<StorageData>();
  // final String _baseUrl = environments['dev']!['baseUrl']!;

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(keyToken);
    return {
      "Content-Type": "application/json",
      // if (token != null && token != '') "Authorization": "Bearer $token",
      if (token != null && token != '') "authentication": token,
    };
  }

  Future<void> _refreshToken() async {
    // TODO::Implémentez LA logique pour rafraîchir le token
    // ...
  }

  Future<http.Response> post(String path, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await _client.post(
        Uri.parse(path),
        headers: headers,
        body: jsonEncode(data),
    );
  }

  Future<http.Response> get(String path) async {
    final headers = await _getHeaders();
    return await _client.get(
        Uri.parse(path),
        headers: headers
    );
  }

  Future<http.Response> put(String path, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await _client.put(
        Uri.parse(path),
        headers: headers,
        body: jsonEncode(data),
    );
  }

  Future<http.Response> delete(String path) async {
    final headers = await _getHeaders();
    return await _client.delete(
        Uri.parse(path),
        headers: headers
    );
  }

  Future<http.Response> patch(String path, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await _client.patch(
        Uri.parse(path),
        headers: headers,
        body: jsonEncode(data),
    );
  }
}
