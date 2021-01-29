import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteRepository {
  final base_url = 'https://cloud.iexapis.com/stable/stock';
  final token = 'pk_d7aa7a3fbda847ba96cea288e9e52c94';
  final symbols = ['aapl', 'msft', 'ibm', 'orcl', 'hpq', 'fb'];

  Future<List<Quote>> getQuote() async {
    List<Quote> quote = [];

    var cacheDir = await getTemporaryDirectory();
    int index = 0;
    while(index < symbols.length){

      String sym = symbols[index];
      String fileName = "$sym.json";

      if(await File(cacheDir.path + "/" + fileName).exists()){
        debugPrint("File Provider");
        var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
        quote.add(Quote.fromJson(jsonDecode(jsonData)));
        index++;

      }else{
        try{
          var response = await http.get("$base_url/$sym/quote?token=$token");
          if(response.statusCode == 200){
            debugPrint("Response Data: ${response.body}");
            var tempDir = await getTemporaryDirectory();
            File file = new File(tempDir.path + "/" + fileName);
            file.writeAsString(response.body, flush: true, mode: FileMode.write);
            quote.add(Quote.fromJson(jsonDecode(response.body)));
            index++;
          }
        }catch(error){
          debugPrint("Error: #$error");
          throw Exception(error);
        }
      }
    }
    return quote;
  }

//   Future<List<Quote>> getQuote() async {
//     List<Quote> quote = [];
//     int _index = 0;
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     List<String> urls = [];
//
//     while(_index < symbols.length){
//       String sym = symbols[_index];
//       try{
//         if(preferences.getString("$sym") == null || preferences.getString("$sym").isEmpty){
//           debugPrint("Quote API Called");
//           final quoteUrl = '$base_url/$sym/quote?token=$token';
//           var response = await http.get(quoteUrl);
//           if(response.statusCode == 200){
//             print('Response:${response.body}');
//             preferences.setString("$sym", response.body);
//             quote.add(Quote.fromJson(jsonDecode(response.body)));
//             _index++;
//           }else{
//             continue;
//           }
//         }
//         // else{
//         //   debugPrint("SharedPreferences Started");
//         //   quote.add(Quote.fromJson(jsonDecode(preferences.getString("$sym"))));
//         //   _index++;
//         // }
//       }catch(error){
//         print('Error:$error');
//         continue;
//       }
//     }
//     debugPrint("Loop is finished");
//     return quote;
//   }
// }

//   Future<List<Quote>> getQuote() async {
//     List<Quote> quote = [];
//     int _index = 0;
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     List<String> char = [];
//
//
//     while (_index < symbols.length) {
//       String sym = symbols[_index];
//
//
//       if (preferences.getStringList('$sym') == null) {
//         final quoteUrl = '$base_url/$sym/quote?token=$token';
//         var response = await http.get(quoteUrl);
//         if (response.statusCode == 200) {
//           print('Response:${response.body}');
//           preferences.setString("$sym", quoteUrl);
//           quote.add(Quote.fromJson(jsonDecode(response.body)));
//           char.add(sym);
//           _index++;
//         }else{
//           continue;
//         }
//       }else{
//         var getChar = preferences.getStringList('$sym');
//         if(getChar.isNotEmpty){
//           quote.add(Quote.fromJson(jsonDecode(get)))
//         }
//
//     }
//     print('length: ${quote.length}');
//     return quote;
//     // Quote quote;
//     //  var response = await http.get("$base_url/$symbol/quote?token=$token");
//     //  if(response.statusCode == 200){
//     //    print('Response: $response');
//     //    quote = Quote.fromJson(jsonDecode(response.body));
//     //  }
//     //  return quote;
//   }
}
