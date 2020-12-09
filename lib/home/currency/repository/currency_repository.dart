import 'dart:convert';

import 'package:finance_guide/home/currency/model/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  final base_url = "https://api.exchangeratesapi.io/latest?";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Currency> getCurrency(String base) async {
    Currency currency;
    final SharedPreferences preferences = await prefs;

    var flag = preferences.getString("currency") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences worked");
        currency = Currency.fromJson(jsonDecode(flag));
        return currency;
      } else {
        debugPrint("Api Called");
        final http.Response response = await http.get('${base_url}base=$base');

        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("currency", response.body);
          currency = Currency.fromJson(jsonDecode(response.body));
        }
        return currency;
      }
    } catch (error) {
      print('Error: $error');
      throw Exception(error);
    }
  }
}
