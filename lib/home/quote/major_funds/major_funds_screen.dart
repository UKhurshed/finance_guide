import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class MajorFundsScreen extends StatefulWidget {
  @override
  _MajorFundsScreenState createState() => _MajorFundsScreenState();
}

class _MajorFundsScreenState extends State<MajorFundsScreen> {
  @override
  void initState() {
    getMajorFunds();
    super.initState();
  }

  final lastMajorFunds = List();
  final changePtcMajorFunds = List();
  var nameMajorFunds = List();
  final dateMajorFunds = List();
  // var leftSymbolsMajorFunds = List();

  final emptyFutureList = [
    'pid-1065320',
    'pid-1065276',
    'pid-1065275',
    'pid-1065321',
    'pid-1065327',
    'pid-1065324',
    'pid-1065325',
    'pid-1065332',
    'pid-1065326',
    'pid-1065328',
    'pid-1065329',
    'pid-1065322',
    'pid-1065330',
    'pid-1065319',
    'pid-1065323',
    'pid-1065267',
    'pid-1065268',
    'pid-1065270',
    'pid-1065269',
    'pid-1065301'
  ];

  Future<void> getMajorFunds() async {
    final response =
        await http.get("https://ru.investing.com/funds/major-funds");
    if (response.statusCode == 200) {
      fetchElements(response.body);
    } else
      throw Exception("failed");
  }

  void fetchElements(String body) {
    setState(() {
      var document = parse(body);
      nameMajorFunds =
          document.getElementsByClassName("bold.left.noWrap.elp.plusIconTd");
      // leftSymbolsMajorFunds = document.getElementsByClassName("td.left.symbol");
      for (var j in emptyFutureList) {
        lastMajorFunds.add(
            document.getElementsByClassName(j + '-last')[0].firstChild.text);
        changePtcMajorFunds.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateMajorFunds
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
      }
      // print("Left Symbol: ${leftSymbolsMajorFunds.first}");
      print('Date: ${dateMajorFunds.first}');
      print('Names $nameMajorFunds');
      print('Last: ${lastMajorFunds.first}');
      print('ChangePtc: ${changePtcMajorFunds.first}');
    });
  }

  // highFutures.isEmpty ? CircularProgressIndicator() :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              changePtcMajorFunds.isEmpty
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
                                  SizedBox(height: 10,),
                                  Text(
                                      '${nameMajorFunds[index].text.toString().substring(0, 16)} ...',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
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
                                        dateMajorFunds[index],
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
                                  Text('${lastMajorFunds[index]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: kWhite)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    spacing: 3,
                                    children: [
                                      // Text(
                                      //   "${leftSymbolsMajorFunds[index]}",
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.w500,
                                      //       color: kWhite),
                                      // ),
                                      changePtcMajorFunds[index][0] == '-'
                                          ? Text(
                                              changePtcMajorFunds[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              changePtcMajorFunds[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
