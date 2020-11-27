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
    return SingleChildScrollView(
      child: BlocBuilder<QuoteCubit, QuoteState>(builder: (context, state) {
        if (state is QuoteError) {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //   content: Text('Error'),
          //   backgroundColor: Colors.red,
          //   duration: Duration(seconds: 2),
          // ));
          return InputField();
        }
        if (state is QuoteInitial) {
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
          return InputField();
        }
        if (state is QuoteLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is QuoteLoaded) {
          // Quote quote = state.quote;
          return
          //   ListTile(
          //   leading: Text(quote.symbol ?? 'sym'),
          //   title: Text(quote.change.toString() ?? '0.0'),
          //   trailing: Text(quote.changePercent.toString() ?? '%'),
          // );
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.quote.length,
                itemBuilder: (context, index) {
                  Quote quote = state.quote[index];
                  return ListTile(
                    title: Text(quote.change.toString() ?? '0.0',),
                    leading: Text(quote.symbol ?? 'sym'),
                    trailing: Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green)),
                  );
                });
        }
        return Text('Else');
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    final quoteCubit = context.read<QuoteCubit>();
    quoteCubit.getQuote('aapl');
  }
}

class InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitSymbol(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter Symbols',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitSymbol(BuildContext context, String symbol) {
    final quoteSym = context.read<QuoteCubit>();
    quoteSym.getQuote(symbol);
  }
}