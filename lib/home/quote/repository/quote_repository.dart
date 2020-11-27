import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finance_guide/home/quote/quote.dart';


class QuoteRepository{
  final base_url = 'https://cloud.iexapis.com/stable/stock';
  final token = 'pk_d7aa7a3fbda847ba96cea288e9e52c94';
  final symbols = ['aapl', 'msft', 'amzn', 'googl', 'fb', 'baba', 'ibm', 'nvda', 'orcl', 'hpq'];

  Future<List<Quote>> getQuote() async{
    List<Quote> quote;

    symbols.forEach((sym) async{
      Response response = await Dio().get('$base_url/$sym/quote?token=$token');
      if(response.statusCode == 200){
        print('Response:${response.data}');
        quote.add(Quote.fromJson(jsonDecode(response.data)));
      }
    });
    return quote;
  }
}