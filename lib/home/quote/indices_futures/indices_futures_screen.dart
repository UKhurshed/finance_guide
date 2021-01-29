import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class IndicesFuturesScreen extends StatefulWidget {
  @override
  _IndicesFuturesScreenState createState() => _IndicesFuturesScreenState();
}

class _IndicesFuturesScreenState extends State<IndicesFuturesScreen> {
  @override
  void initState() {
    getIndicesFutures();
    super.initState();
  }

  final highFutures = List();
  final lowFutures = List();
  final lastFutures = List();
  final changeFutures = List();
  final changePtcFutures = List();
  var nameIndicesFutures = List();
  final dateIndicesFutures = List();

  final emptyFutureList = [
    'pid-8873',
    'pid-8839',
    'pid-8874',
    'pid-8864',
    'pid-8884',
    'pid-8826',
    'pid-8853',
    'pid-8838',
    'pid-8867',
    'pid-8858',
    'pid-8837',
    'pid-8828',
    'pid-8825',
    'pid-8863',
    'pid-8878',
    'pid-941612',
    'pid-8859',
    'pid-941609',
    'pid-8984',
    'pid-8982'
  ];

  Future<void> getIndicesFutures() async {
    final response =
        await http.get("https://ru.investing.com/indices/indices-futures");
    if (response.statusCode == 200) {
      fetchElements(response.body);
    } else
      throw Exception("failed");
  }

  void fetchElements(String body) {
    setState(() {
      var document = parse(body);
      debugPrint(
          "Web: ${document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp").length}");
      nameIndicesFutures =
          document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp");
      for (var j in emptyFutureList) {
        lastFutures.add(
            document.getElementsByClassName(j + '-last')[0].firstChild.text);
        highFutures.add(
            document.getElementsByClassName(j + '-high')[0].firstChild.text);
        lowFutures.add(
            document.getElementsByClassName(j + '-low')[0].firstChild.text);
        changeFutures.add(
            document.getElementsByClassName('bold.$j-pc')[0].firstChild.text);
        changePtcFutures.add(
            document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
        dateIndicesFutures
            .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
      }
      print('Date: ${dateIndicesFutures.first}');
      print('Names $nameIndicesFutures');
      print('Last: ${lastFutures.first}');
      print('HIgh: ${highFutures.first}');
      print('Low: ${lowFutures.first}');
      print('Change: ${changeFutures.first}');
      print('ChangePtc: ${changePtcFutures.first}');
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
              lastFutures.isEmpty
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
                                  Text(nameIndicesFutures[index].text,
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
                                        dateIndicesFutures[index],
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
                                  Text('${highFutures[index]}',
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
                                      changeFutures[index][0] == '-' ? Text(
                                        changeFutures[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ) : Text(
                                        changeFutures[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      changePtcFutures[index][0] == '-'
                                          ? Text(
                                        '(${changePtcFutures[index]})',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                          : Text(
                                        '(${changePtcFutures[index]})',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],),
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
