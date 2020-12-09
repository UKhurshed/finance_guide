import 'dart:convert';
import 'package:finance_guide/home/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsRepository {
  static const BASE_URL = 'https://newsapi.org/v2/top-headlines?';
  static const API_KEY = '40263c7dfce94e56b07bf112da413229';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<NewsModel> getNews(String query) async {
    NewsModel news;
    final SharedPreferences preferences = await prefs;
    // var now = new DateTime.now();
    // var formatter = new DateFormat('yyyy-MM-dd');
    // var FROM = formatter.format(now);
    var flag = preferences.getString("news") ?? '';

    try {
      if (flag.isNotEmpty) {
        debugPrint("Preferences worked");
        news = NewsModel.fromJson(jsonDecode(flag));
        return news;
      } else {
        debugPrint("Api Called");
        final http.Response response =
            await http.get('${BASE_URL}q=$query&apiKey=$API_KEY');
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          preferences.setString("news", response.body);
          news = NewsModel.fromJson(jsonDecode(response.body));
        }
        return news;
      }
    } catch (error) {
      print('Error: $error');
      throw Exception(error);
    }
  }
}
