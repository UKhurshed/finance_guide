import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class RealTimeFuturesScreen extends StatefulWidget {
  @override
  _RealTimeFuturesScreenState createState() => _RealTimeFuturesScreenState();
}

class _RealTimeFuturesScreenState extends State<RealTimeFuturesScreen> {
  var nameRealtimeFutures = List();
  final lastRealtimeFutures = List();
  final highRealtimeFutures = List();
  final lowRealtimeFutures = List();
  final changeRealtimeFutures = List();
  final changePtcRealtimeFutures = List();
  final dateRealtimeFutures = List();

  @override
  void initState() {
    getRealtimeFutures();
    super.initState();
  }

  final emptyStocks = [
    'pid-8830',
    'pid-68',
    'pid-8836',
    'pid-8831',
    'pid-8910',
    'pid-8883',
    'pid-8849',
    'pid-8833',
    'pid-8862',
    'pid-8988',
    'pid-954867',
    'pid-8861',
    'pid-49768',
    'pid-956470',
    'pid-959207',
    'pid-959208',
    'pid-959211',
    'pid-959209',
    'pid-8917',
    'pid-13916'
  ];

  Future<void> getRealtimeFutures() async {
    final response = await http
        .get("https://ru.investing.com/commodities/real-time-futures");
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
      nameRealtimeFutures =
          document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp");
      for (var j in emptyStocks) {
        lastRealtimeFutures.add(
            document.getElementsByClassName(j + '-last')[0].firstChild.text);
        highRealtimeFutures.add(
            document.getElementsByClassName(j + '-high')[0].firstChild.text);
        lowRealtimeFutures.add(
            document.getElementsByClassName(j + '-low')[0].firstChild.text);
        changeRealtimeFutures.add(
            document.getElementsByClassName('bold.$j-pc')[0].firstChild.text);
        changePtcRealtimeFutures.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateRealtimeFutures
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
        print('Date: ${dateRealtimeFutures.first}');
        print('Names ${nameRealtimeFutures.first.text}');
        print('Last: ${lastRealtimeFutures.first}');
        print('HIgh: ${highRealtimeFutures.first}');
        print('Low: ${lowRealtimeFutures.first}');
        print('Change: ${changeRealtimeFutures.first}');
        print('ChangePtc: ${changePtcRealtimeFutures.first}');
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
              lastRealtimeFutures.isEmpty
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
                                  Text(nameRealtimeFutures[index].text,
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
                                        dateRealtimeFutures[index],
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
                                  Text(highRealtimeFutures[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: kWhite)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(
                                    spacing: 2,
                                    children: [
                                      changeRealtimeFutures[index][0] == '-'
                                          ? Text(
                                              changeRealtimeFutures[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              changeRealtimeFutures[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                      changePtcRealtimeFutures[index][0] == '-'
                                          ? Text(
                                              '(${changePtcRealtimeFutures[index]})',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              '(${changePtcRealtimeFutures[index]})',
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
