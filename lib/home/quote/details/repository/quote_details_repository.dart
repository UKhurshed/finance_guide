import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  final base_url = "https://sandbox.tradier.com/v1/markets/history?";
  final token = "TPJacRI9DBgtJgIFIMlrKVtjJgAs";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Item> getWeekly(String sym) async {
    String interval = "daily";
    String start = "2021-01-19";
    String end = "2021-01-29";

    Item items = Item();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$sym daily") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences Details Quote");
        items = Item.fromJson(jsonDecode(flag));
        return items;
      } else {
        debugPrint("Api Called");
        var response = await http.get(
            "${base_url}symbol=$sym&interval=$interval&start=$start&end=$end",
            headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("$sym daily", response.body);
          items = Item.fromJson(jsonDecode(response.body));
        }
        return items;
      }
    } catch (error) {
      print('Error:$error');
      throw Exception(error);
    }
  }


  Future<Item> getMonthly(String sym) async {
    String interval = "daily";
    String start = "2020-12-29";
    String end = "2021-01-29";

    Item items = Item();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$sym month") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences Details Quote");
        items = Item.fromJson(jsonDecode(flag));
        return items;
      } else {
        debugPrint("Api Called");
        var response = await http.get(
            "${base_url}symbol=$sym&interval=$interval&start=$start&end=$end",
            headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("$sym month", response.body);
          items = Item.fromJson(jsonDecode(response.body));
        }
        return items;
      }
    } catch (error) {
      print('Error:$error');
      throw Exception(error);
    }
  }

  Future<Item> getYear(String sym) async {
    String interval = "daily";
    String start = "2020-01-29";
    String end = "2021-01-29";

    Item items = Item();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$sym year") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences Details Quote");
        items = Item.fromJson(jsonDecode(flag));
        return items;
      } else {
        debugPrint("Api Called");
        var response = await http.get(
            "${base_url}symbol=$sym&interval=$interval&start=$start&end=$end",
            headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("$sym year", response.body);
          items = Item.fromJson(jsonDecode(response.body));
        }
        return items;
      }
    } catch (error) {
      print('Error:$error');
      throw Exception(error);
    }
  }

  Future<Item> getFiveYear(String sym) async{
    String interval = "monthly";
    String start = "2016-01-29";
    String end = "2021-01-29";

    Item items = Item();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$sym five") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences Details Quote");
        items = Item.fromJson(jsonDecode(flag));
        return items;
      } else {
        debugPrint("Api Called");
        var response = await http.get(
            "${base_url}symbol=$sym&interval=$interval&start=$start&end=$end",
            headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("$sym five", response.body);
          items = Item.fromJson(jsonDecode(response.body));
        }
        return items;
      }
    } catch (error) {
      print('Error:$error');
      throw Exception(error);
    }
  }
}