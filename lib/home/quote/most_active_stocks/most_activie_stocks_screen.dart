import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class MostActiveStocksScreen extends StatefulWidget {
  @override
  _MostActiveStocksScreenState createState() => _MostActiveStocksScreenState();
}

class _MostActiveStocksScreenState extends State<MostActiveStocksScreen> {
  var nameStocks = List();
  final lastStocks = List();
  final highStocks = List();
  final lowStocks = List();
  final changeStocks = List();
  final changePtcStocks = List();
  final dateStocks = List();
  
  @override
  void initState() {
    getMostActiveStocks();
    super.initState();
  }

  final emptyStocks = [
    'pid-13711',
    'pid-13684',
    'pid-13689',
    'pid-13683',
    'pid-13707',
    'pid-13744',
    'pid-44465',
    'pid-1163363',
    'pid-13718',
    'pid-40423',
    'pid-102063',
    'pid-13693',
    'pid-13678',
    'pid-13716',
    'pid-13712',
    'pid-13690',
    'pid-13679',
    'pid-44464',
    'pid-13713',
    'pid-13705'
  ];

  Future<void> getMostActiveStocks() async {
    final response =
        await http.get("https://ru.investing.com/equities/most-active-stocks");
    if (response.statusCode == 200) {
      fetchElements(response.body);
    } else
      debugPrint("Error");
  }

  void fetchElements(String body) {
    setState(() {
      var document = parse(body);
      // debugPrint(
      //     "Web: ${document.getElementsByClassName("left.bold.plusIconTd.noWrap.elp")}");
      nameStocks =
          document.getElementsByClassName("left.bold.plusIconTd.elp");
      for (var j in emptyStocks) {
        lastStocks.add(
            document.getElementsByClassName('align_right.$j' + '-last')[0].firstChild.text);
        highStocks.add(
            document.getElementsByClassName('align_right.$j' + '-high')[0].firstChild.text);
        lowStocks.add(
            document.getElementsByClassName(j + '-low')[0].firstChild.text);
        changeStocks.add(
            document.getElementsByClassName('bold.$j-pc')[0].firstChild.text);
        changePtcStocks.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateStocks
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
        print('Date: ${dateStocks.first}');
        print('Names ${nameStocks.first}');
        print('Last: ${lastStocks.first}');
        print('HIgh: ${highStocks.first}');
        print('Low: ${lowStocks.first}');
        print('Change: ${changeStocks.first}');
        print('ChangePtc: ${changePtcStocks.first}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              lastStocks.isEmpty
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: kItemUnSelected,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(nameStocks[index].text, style: TextStyle(
                                      fontWeight: FontWeight.bold,  fontSize: 15,
                                      color: Colors.white)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    spacing: 3,
                                    children: [
                                      Icon(
                                        Icons.query_builder,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        dateStocks[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kTextLightColor),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(highStocks[index], style: TextStyle(
                                      fontWeight: FontWeight.bold,  fontSize: 15,
                                      color: kWhite)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    spacing: 2,
                                    children: [
                                      changeStocks[index][0] == '-' ? Text(
                                        changeStocks[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ) : Text(
                                        changeStocks[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      changePtcStocks[index][0] == '-'
                                          ? Text(
                                        '(${changePtcStocks[index]})',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                          : Text(
                                        '(${changePtcStocks[index]})',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],),
                                ],
                              ),
                            );
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
