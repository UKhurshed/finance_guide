import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class QuoteDetailsRepository{
  final base_url = 'https://sandbox.tradier.com/v1/markets/history?';
  final bearer_token = "TPJacRI9DBgtJgIFIMlrKVtjJgAs";

  Future<QuoteHistorical> getDaily(String sym) async{
    QuoteHistorical historical;
    String start = "2020-01-01";
    String end = "2020-12-09";


    var cacheDir = await getTemporaryDirectory();
    String fileName = "Monthly";
  }

  Future<QuoteHistorical> getWeekly(String sym) async{
    QuoteHistorical historical = QuoteHistorical();
    String start = "2020-11-01";
    String end = "2020-12-01";

    var cacheDir = await getTemporaryDirectory();
    String fileName = "$sym/weekly";

    if(await File(cacheDir.path + "/" + fileName).exists()){
      debugPrint("File Provider Details");
      var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
      historical = QuoteHistorical.fromJson(jsonDecode(jsonData));
    }else{
      try{
        var response = await http.get("$base_url/symbol=$sym&interval=weekly&start=$start&end=$end", headers: {
          'Accept': 'application/json',
          'Authorization': '$bearer_token'
        });
        if(response.statusCode == 200){
          debugPrint("Response Data: ${response.body}");
          var tempDir = await getTemporaryDirectory();
          File file = new File(tempDir.path + "/" + fileName);
          file.writeAsString(response.body, flush: true, mode: FileMode.write);
          historical = QuoteHistorical.fromJson(jsonDecode(response.body));
        }
      }catch(error){
        debugPrint("Error: #$error");
        throw Exception(error);
      }
    }
    return historical;
  }

  // Future<QuoteOneDay> getTodayStock() async{
  //   QuoteOneDay today;
  // }
}