
import 'dart:convert';

import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/home/currency/details/model/cu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CurrencyDetailRepository{
  final url = "https://api.exchangeratesapi.io/history?";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<DetailRate> getDaily(String curr) async{
    String start = "2021-01-17";
    String end = "2021-01-29";

    DetailRate rates = new DetailRate();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$curr daily") ?? '';
    
    try{
      if(flag.isNotEmpty){
        debugPrint("Preferences Currency Details");
        rates = DetailRate.fromJson(jsonDecode(flag));
        return rates;
      }else{
        debugPrint("Currency Details Api Called");
        var response = await http.get("${url}start_at=$start&end_at=$end&symbols=$curr&base=USD");
        if(response.statusCode == 200){
          print("Currency Details Response body: ${response.body}");
          preferences.setString("$curr daily", response.body);
          rates = DetailRate.fromJson(jsonDecode(response.body));
        }
        return rates;
      }
    }catch(error){
      debugPrint('Error: $error');
      throw Exception();
    }
  }

  Future<DetailRate> getWeekly(String curr) async{
    String start = "2020-12-13";
    String end = "2021-01-28";

    DetailRate rates = new DetailRate();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$curr weekly") ?? '';

    try{
      if(flag.isNotEmpty){
        debugPrint("Preferences Currency Details");
        rates = DetailRate.fromJson(jsonDecode(flag));
        return rates;
      }else{
        debugPrint("Currency Details Api Called");
        var response = await http.get("${url}start_at=$start&end_at=$end&symbols=$curr&base=USD");
        if(response.statusCode == 200){
          print("Currency Details Response body: ${response.body}");
          preferences.setString("$curr weekly", response.body);
          rates = DetailRate.fromJson(jsonDecode(response.body));
        }
        return rates;
      }
    }catch(error){
      debugPrint('Error: $error');
      throw Exception();
    }
  }


  Future<DetailRate> getYearly(String curr) async{
    String start = "2019-09-01";
    String end = "2021-01-29";

    DetailRate rates = new DetailRate();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$curr yearly") ?? '';

    try{
      if(flag.isNotEmpty){
        debugPrint("Preferences Currency Details");
        rates = DetailRate.fromJson(jsonDecode(flag));
        return rates;
      }else{
        debugPrint("Currency Details Api Called");
        var response = await http.get("${url}start_at=$start&end_at=$end&symbols=$curr&base=USD");
        if(response.statusCode == 200){
          print("Currency Details Response body: ${response.body}");
          preferences.setString("$curr yearly", response.body);
          rates = DetailRate.fromJson(jsonDecode(response.body));
        }
        return rates;
      }
    }catch(error){
      debugPrint('Error: $error');
      throw Exception();
    }
  }

  Future<DetailRate> getFiveYear(String curr) async{
    String start = "2013-12-28";
    String end = "2021-01-29";

    DetailRate rates = new DetailRate();
    final SharedPreferences preferences = await prefs;
    var flag = preferences.getString("$curr five") ?? '';

    try{
      if(flag.isNotEmpty){
        debugPrint("Preferences Currency Details");
        rates = DetailRate.fromJson(jsonDecode(flag));
        return rates;
      }else{
        debugPrint("Currency Details Api Called");
        var response = await http.get("${url}start_at=$start&end_at=$end&symbols=$curr&base=USD");
        if(response.statusCode == 200){
          print("Currency Details Response body: ${response.body}");
          preferences.setString("$curr five", response.body);
          rates = DetailRate.fromJson(jsonDecode(response.body));
        }
        return rates;
      }
    }catch(error){
      debugPrint('Error: $error');
      throw Exception();
    }
  }
}
