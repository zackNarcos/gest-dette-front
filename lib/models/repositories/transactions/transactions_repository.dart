import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../entity/transaction_model.dart';
import '../core/api_service.dart';
import '../environments/environments.dart';

class TransactionsRepository  with ChangeNotifier {

  final ApiService _apiService = ApiService();
  final String _baseUrl = environments['dev']!['baseUrl']!;

  Future<Response> store(Transaction transaction) async {
    final response = await _apiService.post('$_baseUrl/transactions', transaction.toJson());

    return response;
  }

  Future<Response> update(Transaction transaction) async {
    return await _apiService.put('$_baseUrl/transactions/${transaction.id}', transaction.toJson());
  }

  Future<Response> getAll() async {
    return await _apiService.get('$_baseUrl/transactions');
  }
}