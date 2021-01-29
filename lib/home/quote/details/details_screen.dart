import 'package:finance_guide/home/quote/details/cubit/quote_details_cubit.dart';
import 'package:finance_guide/home/quote/details/details.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

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

  String resume;
  String avgCount;
  String techIndicator;
  String indicatorsSym;
  String indicatorsVal;
  var indi = List();
  var indiValues = List();
  var actions = List();

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
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text(quote.companyName ?? '', style: TextStyle(color: kItemUnSelected),),
      ),
      body: SingleChildScrollView(
        child: indi.isNotEmpty ? Column(
          children: [
            Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: quote.changePercent < 0 ? Icon(Icons.trending_down, color: Colors.red, size: 35,) : Icon(Icons.trending_up, color: Colors.green, size: 35),
                        title: Row(
                          children: [
                            Text(quote.latestPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white),),
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
                            Text('Технический анализ  ${quote.companyName}', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 10,
                            ),
                            Text( "Резюме: " + resume ?? '', style: TextStyle(color: Colors.white, fontSize: 17)),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ListView.separated(
                                  separatorBuilder: (context, index) => Divider(color: kItemUnSelected,),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: indi.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(height: 18,),
                                          Text(indi[index].text, style: TextStyle(color: Colors.white, fontSize: 16),),
                                        ],
                                      ),
                                      title: Text(indiValues[index].text, style: TextStyle(color: Colors.white)),
                                      trailing: Text(actions[index].text, style: TextStyle(color: Colors.white)),
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
    // final webScraper = WebScraper('https://ru.investing.com');

    switch (quote) {
      case 'AAPL':
        {
          final response = await http.get("https://ru.investing.com/equities/apple-computer-inc-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      case "MSFT":
        {
          final response = await http.get("https://ru.investing.com/equities/microsoft-corp-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      case "IBM":
        {
          final response = await http.get("https://ru.investing.com/equities/ibm-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      case "ORCL":
        {
          final response = await http.get("https://ru.investing.com/equities/oracle-corp-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      case "HPQ":
        {
          final response = await http.get("https://ru.investing.com/equities/hewlett-pack-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      case "FB":
        {
          final response = await http.get("https://ru.investing.com/equities/facebook-inc-technical");
          if(response.statusCode == 200){
            print("Succes");
            fetchElements(response.body);
          }
        }
        break;
      default:
        debugPrint("default");
        break;
    }
  }

  void fetchElements(String body) {

    setState(() {
      var document = parse(body);
      // resu = document.getElementsByClassName("div.summary")[0].firstChild.text; <span class="buy uppercaseText" title="">Активно покупать</span>
      // bar = document.getElementsByClassName("h2.float_lang_base_1.inlineblock")[0].firstChild.text;
      resume = document.getElementsByClassName("uppercaseText")[0].firstChild.text;
      indi = document.getElementsByClassName("first.left.symbol");
      indiValues = document.getElementsByClassName("right");
      actions = document.getElementsByClassName("left.textNum.bold");
      debugPrint("Indi: ${indi.first.text}");

      indi.removeRange(12, 18);
      actions.removeRange(12, 18);
      indiValues.removeAt(0);
      indiValues.removeAt(12);

      // for(var k in indi){
      //   debugPrint("Act: ${k.text}");
      // }
      //
      // for(var k in actions){
      //   debugPrint("Act: ${k.text}");
      // }

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
              child: Text('1м', style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
            InkWell(
              onTap: (){
                final detailsQuote = context.read<QuoteDetailsCubit>();
                detailsQuote.getYear(quote.symbol);
              },
              child: Text('1г', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            InkWell(
              onTap: (){
                final detailsQuote = context.read<QuoteDetailsCubit>();
                detailsQuote.getFiveYear(quote.symbol);
              },
              child: Text('5л', style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ],
        );
  }
}
