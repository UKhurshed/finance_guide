import 'package:finance_guide/home/quote/details/cubit/quote_details_cubit.dart';
import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:finance_guide/home/quote/technical_indicators/technical_indicators_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';

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
      create: (context) => QuoteDetailsCubit(HistoryRepository()),
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
  var index = 0;

  _QuoteDetailsState(this.quote);

  @override
  void initState() {
    super.initState();
    final detailsQuote = context.read<QuoteDetailsCubit>();
    debugPrint("Sym ${quote.symbol}");
    detailsQuote.getFiveYear(quote.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quote.companyName ?? ''),
      ),
      body: Column(
        children: [
          Container(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: quote.changePercent < 0 ? Icon(Icons.trending_down, color: Colors.red, size: 35,) : Icon(Icons.trending_up, color: Colors.green, size: 35),
                      title: Row(
                        children: [
                          Text(quote.latestPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                          SizedBox(width: 10,),
                          quote.change < 0 ? Text("${quote.change}", style: TextStyle(color: Colors.red),) : Text("+${quote.change}",style: TextStyle(color: Colors.green) ),
                          SizedBox(width: 10,),
                          quote.change < 0 ? Text("(${quote.changePercent}%)", style: TextStyle(color: Colors.red),) : Text("(+${quote.changePercent}%)",style: TextStyle(color: Colors.green) ),
                        ],
                      )
                    ),
                  )
                ],
              ),
          ),
          SizedBox(height: 5,),
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
                  var list = state.items.history.day;
                  List sampleData = [];
                  list.forEach((element) => sampleData.add(element.toJson()));

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: OHLCVGraph(
                              data: sampleData,
                              enableGridLines: true,
                              volumeProp: 0.2,
                              gridLineAmount: 5,
                              gridLineColor: Colors.grey[300],
                              gridLineLabelColor: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text('yep'),
                  );
                }
              }),
          SizedBox(height: 10,),
          buildChoiceHistory(context),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child:
            // Center(
            //   child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Последний объем'),
                      SizedBox(width: 50,),
                      Text(quote.latestVolume.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Предыдущий объем'),
                      SizedBox(width: 50,),
                      Text(quote.previousVolume.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Средний объем'),
                      SizedBox(width: 50,),
                      Text(quote.latestVolume.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Последняя цена'),
                      SizedBox(width: 50,),
                      Text(quote.latestPrice.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Открытие'),
                      SizedBox(width: 50,),
                      Text(quote.open.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Закрытие'),
                      SizedBox(width: 50,),
                      Text(quote.close.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Предыдущая закрытия'),
                      SizedBox(width: 50,),
                      Text(quote.previousClose.toString())
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Цена/доход'),
                      SizedBox(width: 50,),
                      Text(quote.peRatio.toString())
                    ],
                  ),
                  SizedBox(height: 30,),

                  Center(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          // side: BorderSide(color: Colors.red)
                      ),
                      child: Text('Теханализ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                      color: Colors.green,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TechnicalIndicatorsScreen(quote.symbol)));
                      },
                    ),
                  ),
                ],
              ),
            // ),
          )
        ],
      ),
    );
  }

  Row buildChoiceHistory(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: (){
                final detailsQuote = context.read<QuoteDetailsCubit>();
                detailsQuote.getMonthly(quote.symbol);
              },
              child: Text('1м', style: TextStyle(fontSize: 16),),
            ),
            InkWell(
              onTap: (){
                final detailsQuote = context.read<QuoteDetailsCubit>();
                detailsQuote.getYear(quote.symbol);
              },
              child: Text('1г', style: TextStyle(fontSize: 16)),
            ),
            InkWell(
              onTap: (){
                final detailsQuote = context.read<QuoteDetailsCubit>();
                detailsQuote.getFiveYear(quote.symbol);
              },
              child: Text('5л', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
  }
}

//it's worked
/*
  var list = state.items.history.day;
                  List sampleData = [];
                  list.forEach((element) => sampleData.add(element.toJson()));

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: OHLCVGraph(
                              data: sampleData,
                              enableGridLines: true,
                              volumeProp: 0.2,
                              gridLineAmount: 5,
                              gridLineColor: Colors.grey[300],
                              gridLineLabelColor: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  );
 */