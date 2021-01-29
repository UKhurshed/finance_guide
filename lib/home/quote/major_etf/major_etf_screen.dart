import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class MajorEtfScreen extends StatefulWidget {
  @override
  _MajorEtfScreenState createState() => _MajorEtfScreenState();
}

class _MajorEtfScreenState extends State<MajorEtfScreen> {
  var nameMajorEtf = List();
  final lastMajorEtf = List();
  final changePtcMajorEtf = List();
  final turnOverMajorEtf = List();

  final dateMajorEtf = List();

  @override
  void initState() {
    getMajorEtf();
    super.initState();
  }

  final emptyMajorEtf = [
    'pid-45035',
    'pid-44802',
    'pid-44638',
    'pid-44639',
    'pid-941456',
    'pid-40657',
    'pid-40668',
    'pid-651',
    'pid-512',
    'pid-509',
    'pid-510',
    'pid-505',
    'pid-44686',
    'pid-37487',
    'pid-14202',
    'pid-45143',
    'pid-14218',
    'pid-40689',
    'pid-45496',
    'pid-525'
  ];

  Future<void> getMajorEtf() async {
    final response = await http.get("https://ru.investing.com/etfs/major-etfs");
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
      nameMajorEtf =
          document.getElementsByClassName("bold.left.noWrap.elp.plusIconTd");
      for (var j in emptyMajorEtf) {
        turnOverMajorEtf.add(document.getElementsByClassName("$j-turnover")[0].firstChild.text);
        lastMajorEtf.add(
            document.getElementsByClassName(j + '-last')[0].firstChild.text);
        changePtcMajorEtf.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateMajorEtf
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
        print('Date: ${dateMajorEtf.first}');
        print('Names ${nameMajorEtf.first.text}');
        print('Last: ${lastMajorEtf.first}');
        print('ChangePtc Etf: ${changePtcMajorEtf.first}');
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
              changePtcMajorEtf.isEmpty
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
                                  Text(
                                      "${nameMajorEtf[index].text.toString().substring(0, 12)} ...",
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
                                        dateMajorEtf[index],
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
                                  Text(lastMajorEtf[index],
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
                                      // chan[index][0] == '-'
                                      //     ? Text(
                                      //   changeSingleCurrency[index],
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.red),
                                      // )
                                      //     : Text(
                                      //   changeSingleCurrency[index],
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.green),
                                      // ),
                                      Text(turnOverMajorEtf[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                                      changePtcMajorEtf[index][0] == '-'
                                          ? Text(
                                              '(${changePtcMajorEtf[index]})',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              '(${changePtcMajorEtf[index]})',
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
