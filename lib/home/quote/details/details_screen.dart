import 'package:finance_guide/home/quote/details/cubit/quote_details_cubit.dart';
import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class QuoteDetailsArgument {
//   final Quote quote;
//
//   const QuoteDetailsArgument(this.quote);
// }
//
// class QuoteDetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     QuoteDetailsArgument args = ModalRoute.of(context).settings.arguments;
//     return BlocProvider(
//         create: (context) => QuoteDetailsCubit(QuoteDetailsRepository()), child:  QuoteDetails(args.quote),);
//   }
// }

class Details extends StatelessWidget {
  final Quote quote;

  const Details(this.quote);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: QuoteDetails(quote),
      create: (context) => QuoteDetailsCubit(QuoteDetailsRepository()),
    );
  }
}


class QuoteDetails extends StatefulWidget {
  final Quote quote;

  QuoteDetails(this.quote);

  @override
  _QuoteDetailsState createState() => _QuoteDetailsState(this.quote);
}

class _QuoteDetailsState extends State<QuoteDetails> {
  final Quote quote;

  _QuoteDetailsState(this.quote);

  @override
  void initState() {
    super.initState();
    final detailsQuote = context.read<QuoteDetailsCubit>();
    detailsQuote.getWeeklyQuote(quote.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quote.symbol ?? ''),
      ),
      body: SingleChildScrollView(child:
          BlocBuilder<QuoteDetailsCubit, QuoteDetailsState>(
              builder: (context, state) {
        if (state is QuoteDetailsError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          return Center(
            child: Text('error'),
          );
        } else if (state is QuoteDetailsInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is QuoteDetailsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is QuoteDetailsLoaded) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                // History quote = state.quoteHistorical.history.day[index];
                // Day quote = state.quoteHistorical.history.day[index];
                QuoteHistorical quote = state.quoteHistorical;
                return Card(child: ListTile(title: Text(quote.history.toString()),),);
                //   Card(
                //   color: Colors.grey[200],
                //   child: ListTile(
                //     title: Text(
                //       quote.high.toString(),
                //       style: TextStyle(fontSize: 16),
                //     ),
                //     leading: Text(
                //       quote.close.toString(),
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     trailing: Text(quote.date.toString() ?? '%',
                //         style: TextStyle(color: Colors.green, fontSize: 18)),
                //   ),
                // );
              });
        } else {
          return Center(
            child: Text('yep'),
          );
        }
      })),
    );
  }
}
