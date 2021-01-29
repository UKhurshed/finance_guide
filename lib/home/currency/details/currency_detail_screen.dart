import 'package:finance_guide/home/currency/details/cubit/curr_detail_cubit.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'currency_details.dart';

class CurrDetailScreen extends StatelessWidget {
  final String baseSym;

  const CurrDetailScreen(this.baseSym);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrDetailCubit(CurrencyDetailRepository()),
      child: CurrencyDetailScreen(baseSym),
    );
  }
}

class CurrencyDetailScreen extends StatefulWidget {
  final String sym;

  const CurrencyDetailScreen(this.sym);

  @override
  _CurrencyDetailScreenState createState() =>
      _CurrencyDetailScreenState(this.sym);
}

class _CurrencyDetailScreenState extends State<CurrencyDetailScreen> {
  final String symbol;
  String currentRate;
  String change;
  String changePtc;
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




  _CurrencyDetailScreenState(this.symbol);

  @override
  void initState() {
    final curr = context.read<CurrDetailCubit>();
    curr.getDaily(symbol);
    getElement(symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text('USD/$symbol'),
      ),
      body: SingleChildScrollView(
        child: currentRate != null ? Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                      leading: double.parse(change) < 0 ? Icon(Icons.trending_down, color: Colors.red, size: 35,) : Icon(Icons.trending_up, color: Colors.green, size: 35),
                      title: Row(
                        children: [
                          Text(currentRate,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
                          SizedBox(width: 10,),
                          double.parse(change) < 0 ? Text("$change", style: TextStyle(color: Colors.red),) : Text("$change",style: TextStyle(color: Colors.green) ),
                          SizedBox(width: 10,),
                          double.parse(change) < 0 ? Text("($changePtc)", style: TextStyle(color: Colors.red),) : Text("($changePtc)",style: TextStyle(color: Colors.green) ),
                        ],
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            BlocBuilder<CurrDetailCubit, CurrDetailState>(
              builder: (context, state) {
                if (state is CurrDetailError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                  return Center(
                    child: Text('error'),
                  );
                } else if (state is CurrDetailInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrDetailLoaded) {
                  var items = state.rates.rates;
                  var sortedItems = Map.fromEntries(items.entries.toList()
                    ..sort((k, v) => k.key.compareTo(v.key)));
                  var values = sortedItems.entries.toList();
                  // debugPrint("Values Length: ${values}");
                  var list = List<LineCharts>();
                  var i = 0;
                  while (i < values.length) {
                    list.add(new LineCharts(
                        i, values.elementAt(i).value.values.first));
                    i++;
                  }
                  debugPrint("Currency Length: ${list.length}");
                  debugPrint("Currency: $list");
                  return Column(
                    children: [
                      Container(
                          height: 200,
                          child: charts.LineChart(
                            _series(list),
                            animate: true,
                          )),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Curr"),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            buildChoiceHistory(context),
            SizedBox(height: 20,),
            Center(
              child: Column(
                children: [
                  Text('Технический анализ: USD/$symbol', style: TextStyle(color: Colors.white),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Резюме: " + resume ?? '', style: TextStyle(color: Colors.white)),
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
                                SizedBox(height: 19,),
                                Text(indi[index].text, style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            title: Text(indiValues[index].text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                            trailing: Text(actions[index].text, style: TextStyle(color: Colors.white)),
                          );
                        }),

                  ),
                ],
              ),

            ),
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Row buildChoiceHistory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            final currDetail = context.read<CurrDetailCubit>();
            currDetail.getDaily(symbol);
          },
          child: Text(
            '1н',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        InkWell(
          onTap: () {
            final currDetail = context.read<CurrDetailCubit>();
            currDetail.getWeekly(symbol);
          },
          child: Text('1м', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        InkWell(
          onTap: () {
            final currDetail = context.read<CurrDetailCubit>();
            currDetail.getYearly(symbol);
          },
          child: Text('1г', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        InkWell(
          onTap: () {
            final currDetail = context.read<CurrDetailCubit>();
            currDetail.getFiveYearly(symbol);
          },
          child: Text('5л', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> getElement(String sym) async{
    String symbol = sym.toLowerCase();
    final response = await http.get("https://ru.investing.com/currencies/usd-$symbol-technical");
    if(response.statusCode == 200){
      debugPrint('URL /currencies/usd-$symbol-technical');
      fetchElement(response.body);
    }
  }

  void fetchElement(String body){

    setState(() {
      var document = parse(body);

      
      currentRate = document.getElementsByClassName("top.bold.inlineblock")[0].text.replaceAll("\n", '').split(' ')[12].replaceAll(",", ".");
      change = document.getElementsByClassName("top.bold.inlineblock")[0].text.replaceAll("\n", '').split(' ')[36].replaceAll(",", ".");
      changePtc = document.getElementsByClassName("top.bold.inlineblock")[0].text.replaceAll("\n", '').split(' ')[60].replaceAll(",", ".");

      debugPrint("Current: $currentRate");
      debugPrint("change: $change");
      debugPrint("changeptc: $changePtc");
      resume = document.getElementsByClassName("uppercaseText")[0].firstChild.text;
      
      indi = document.getElementsByClassName("first.left.symbol");
      indi.removeRange(12, 18);
      
      indiValues = document.getElementsByClassName("right");
      indiValues.removeAt(0);
      // indiValues.removeRange(12, 18);
      
      actions = document.getElementsByClassName("left.textNum.bold");
      // actions.removeRange(12, 18);

    });
  }

  _series(List<LineCharts> data) {
    List<charts.Series<LineCharts, int>> series = [
      charts.Series(
          id: 'Currency',
          data: data,
          domainFn: (LineCharts series, _) => series.time,
          measureFn: (LineCharts series, _) => series.values,
          colorFn: (LineCharts series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }
}

class LineCharts {
  final int time;
  final double values;

  LineCharts(this.time, this.values);
}
