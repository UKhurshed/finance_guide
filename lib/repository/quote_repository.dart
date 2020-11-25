import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finance_guide/model/quote.dart';

class QuoteRepository{
  final base_url = 'https://cloud.iexapis.com/stable/stock';
  final token = 'pk_d7aa7a3fbda847ba96cea288e9e52c94';
  
  Future<Quote> getQuote() async{
    Quote quote;
    Response response = await Dio().get('$base_url/aapl/quote?token=$token');
    if(response.statusCode == 200){
      print('Response:${response.data}');
      quote = Quote.fromJson(jsonDecode(response.data));
    }
    return quote;
  }
}