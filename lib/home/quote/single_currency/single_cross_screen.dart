import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class SingleCurrencyScreen extends StatefulWidget {
  @override
  _SingleCurrencyScreenState createState() => _SingleCurrencyScreenState();
}

class _SingleCurrencyScreenState extends State<SingleCurrencyScreen> {
  var nameSingleCurrency = List();
  final lastSingleCurrency = List();
  final highSingleCurrency = List();
  final lowSingleCurrency = List();
  final changeSingleCurrency = List();
  final changePtcSingleCurrency = List();
  final dateSingleCurrency = List();

  @override
  void initState() {
    getSingleCurrency();
    super.initState();
  }
  
  final emptySingleCurrency = [
    'pid-1',
    'pid-2',
    'pid-3',
    'pid-4',
    'pid-5',
    'pid-7',
    'pid-8',
    'pid-17',
    'pid-18',
    'pid-39',
    'pid-40',
    'pid-41',
    'pid-42',
    'pid-43',
    'pid-59',
    'pid-63',
    'pid-91',
    'pid-103',
    'pid-147',
    'pid-152'
  ];

  Future<void> getSingleCurrency() async {
    final response = //
    await http.get("https://ru.investing.com/currencies/single-currency-crosses");
    if (response.statusCode == 200) {
      fetchElements(response.body);
    } else
      debugPrint("Error");
  }

  void fetchElements(String body) {
    setState(() {
      var document = parse(body);
      debugPrint(
          "Web: ${document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp").length}");
      nameSingleCurrency =
          document.getElementsByClassName("bold.left.noWrap.elp.plusIconTd");
      for (var j in emptySingleCurrency) {
        // lastCrypto.add(
        //     document.getElementsByClassName(j + '-last')[0].firstChild.text);
        highSingleCurrency.add(
            document.getElementsByClassName(j + '-high')[0].firstChild.text);
        lowSingleCurrency.add(
            document.getElementsByClassName(j + '-low')[0].firstChild.text);
        changeSingleCurrency.add(
            document.getElementsByClassName('bold.$j-pc')[0].firstChild.text);
        changePtcSingleCurrency.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateSingleCurrency
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
        print('Date: ${dateSingleCurrency.first}');
        print('Names ${nameSingleCurrency.first.text}');
        // print('Last: ${lastCrypto.first}');
        print('HIgh: ${highSingleCurrency.first}');
        print('Low: ${lowSingleCurrency.first}');
        print('Change: ${changeSingleCurrency.first}');
        print('ChangePtc Cross: ${changePtcSingleCurrency.first}');
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
              changePtcSingleCurrency.isEmpty
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
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(nameSingleCurrency[index].text, style: TextStyle(
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
                                    dateSingleCurrency[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kTextLightColor),
                                  )
                                ],
                              )

                            ],
                          ),

                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text(highSingleCurrency[index], style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kWhite)),
                              SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 2,
                                children: [
                                  changeSingleCurrency[index][0] == '-'
                                      ? Text(
                                    changeSingleCurrency[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                      : Text(
                                    changeSingleCurrency[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  changePtcSingleCurrency[index][0] == '-'
                                      ? Text(
                                    '(${changePtcSingleCurrency[index]})',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                      : Text(
                                    '(${changePtcSingleCurrency[index]})',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
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
