import 'package:finance_guide/home/quote/details/cubit/quote_details_cubit.dart';
import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:web_scraper/web_scraper.dart';

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

  String instrumentHeader;
  String resume;
  String avgCount;
  String techIndicator;
  String indicatorsSym;
  String indicatorsVal;
  List indi = new List();
  List indiValues = new List();
  List actions = new List();
  String resu;
  String bar;

  _QuoteDetailsState(this.quote);

  @override
  void initState() {
    super.initState();
    final detailsQuote = context.read<QuoteDetailsCubit>();
    debugPrint("Sym ${quote.symbol}");
    getElements(quote.symbol);
    detailsQuote.getFiveYear(quote.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quote.companyName ?? ''),
      ),
      body: SingleChildScrollView(
        child: resume != null ? Column(
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
                    SizedBox(height: 30,),
                    Center(
                        child: Column(
                          children: [
                            Text(resume ?? ''),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Технические индикаторы'),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: indi.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Text(indi[index]),
                                      title: Text(indiValues[index]),
                                      trailing: Text(actions[index]),
                                    );
                                  }),

                            ),
                          ],
                        ),

                    ),
                  ],
                ),
              // ),
            )
          ],
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  Future<void> getElements(String quote) async {
    final webScraper = WebScraper('https://ru.investing.com');
    switch (quote) {
      case 'AAPL':
        {
          if (await webScraper
              .loadWebPage("/equities/apple-computer-inc-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      case "MSFT":
        {
          if (await webScraper
              .loadWebPage("/equities/microsoft-corp-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      case "IBM":
        {
          if (await webScraper.loadWebPage("/equities/ibm-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      case "ORCL":
        {
          if (await webScraper.loadWebPage("/equities/oracle-corp-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      case "HPQ":
        {
          if (await webScraper
              .loadWebPage("/equities/hewlett-pack-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      case "FB":
        {
          if (await webScraper
              .loadWebPage("/equities/facebook-inc-technical")) {
            fetchElements(webScraper);
          }
        }
        break;
      default:
        debugPrint("default");
        break;
    }
  }

  void fetchElements(WebScraper webScraper) {

    setState(() {
      resume = webScraper.getElement('div.summary', [])[0]['title'].toString();
      resu = webScraper.getElement("div.summary", []).toString();
      bar = webScraper.getElement("h2.float_lang_base_1.inlineblock", [])[0]
      ['title'];
      final characters = webScraper.getElement("td.first.left.symbol", []);
      final value = webScraper.getElement("td.right", []);
      final action = webScraper.getElement("td.left.textNum.bold", []);

      for (var j in action) {
        actions.add(j['title']);
      }

      for (var i in characters) {
        indi.add(i['title']);
      }

      for (var k in value) {
        indiValues.add(k['title']);
      }
      indi.removeRange(12, 18);
      actions.removeRange(12, 18);
      debugPrint("TechScreen: $resume");
      debugPrint("Indi: $indi");
      debugPrint("IndiVal: $indiValues");
      debugPrint("Act: $actions");
    });
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
