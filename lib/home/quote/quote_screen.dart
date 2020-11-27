import 'package:finance_guide/home/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteBuilder extends StatelessWidget {

  const QuoteBuilder({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteCubit(QuoteRepository()),
      child: QuoteScreen(),
    );
  }
}


class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
