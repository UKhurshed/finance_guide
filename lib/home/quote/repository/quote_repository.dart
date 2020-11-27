import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuoteRepository {
  final base_url = 'https://cloud.iexapis.com/stable/stock';
  final token = 'pk_d7aa7a3fbda847ba96cea288e9e52c94';
  final symbols = ['aapl', 'msft', 'ibm', 'orcl', 'hpq', 'fb', 'googl'];

  //'baba', 'nvda', 'amzn'
  // Stream<List<String>> sum = ['aapl', 'msft', 'amzn', 'googl', 'fb', 'baba', 'ibm', 'nvda', 'orcl', 'hpq'];

  Future<List<Quote>> getQuote() async {
    List<Quote> quote = [];
    int _index = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    while (_index < symbols.length) {
      String sym = symbols[_index];

      if (preferences.getString('$sym') == null) {
        final quoteUrl = '$base_url/$sym/quote?token=$token';
        var response = await http.get(quoteUrl);
        if (response.statusCode == 200) {
          print('Response:${response.body}');
          preferences.setString("$sym", quoteUrl);
          quote.add(Quote.fromJson(jsonDecode(response.body)));
          _index++;
        }
      }else{

      }
    }
    print('length: ${quote.length}');
    return quote;
    // Quote quote;
    //  var response = await http.get("$base_url/$symbol/quote?token=$token");
    //  if(response.statusCode == 200){
    //    print('Response: $response');
    //    quote = Quote.fromJson(jsonDecode(response.body));
    //  }
    //  return quote;
  }
}
