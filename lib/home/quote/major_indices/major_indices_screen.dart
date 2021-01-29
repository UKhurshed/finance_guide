import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class MajorIndicesScreen extends StatefulWidget {
  @override
  _MajorIndicesScreenState createState() => _MajorIndicesScreenState();
}

class _MajorIndicesScreenState extends State<MajorIndicesScreen> {
  final nameIndices = List();
  final lastIndices = List();
  final highIndices = List();
  final lowIndices = List();
  final changeIndices = List();
  final changePtcIndices = List();
  final dateIndices = List();
  var bold = List();

  final emptyIndices = [
    'pid-13666',
    'pid-13665',
    'pid-169',
    'pid-166',
    'pid-14958',
    'pid-170',
    'pid-44336',
    'pid-24441',
    'pid-17920',
    'pid-27254',
    'pid-172',
    'pid-27',
    'pid-167',
    'pid-175',
    'pid-168',
    'pid-174',
    'pid-177',
    'pid-176',
    'pid-14600',
    'pid-14601'
  ];

  @override
  void initState() {
    getMajorIndices();
    super.initState();
  }

  Future<void> getMajorIndices() async {
    final response =
        await http.get("https://ru.investing.com/indices/major-indices");

      if (response.statusCode == 200) {
        fetchElements(response.body);
      }
  }

  void fetchElements(String body) {
    setState(() {
     try{
       var document = parse(body);
       debugPrint(
           "Web: ${document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp").length}");
       bold = document.getElementsByClassName("bold.left.plusIconTd.noWrap.elp");
       for (var j in emptyIndices) {
         lastIndices.add(
             document.getElementsByClassName(j + '-last')[0].firstChild.text);
         highIndices.add(
             document.getElementsByClassName(j + '-high')[0].firstChild.text);
         lowIndices.add(
             document.getElementsByClassName(j + '-low')[0].firstChild.text);
         changeIndices.add(
             document.getElementsByClassName('bold.$j-pc')[0].firstChild.text);
         changePtcIndices.add(
             document.getElementsByClassName('bold.$j-pcp')[0].firstChild.text);
         dateIndices
             .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
         print('Date: ${dateIndices.first}');
         print('Names ${bold.first.text}');
         print('Last: ${lastIndices.first}');
         print('HIgh: ${highIndices.first}');
         print('Low: ${lowIndices.first}');
         print('Change: ${changeIndices.first}');
         print('ChangePtc: ${changePtcIndices.first}');
       }
     }catch(error){
       debugPrint("Error: $error");
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            lastIndices.isEmpty
                ? Center(child: CircularProgressIndicator())
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
                                  height: 8,
                                ),
                                Text(
                                  bold[index].text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  spacing: 3,
                                  children: [
                                    Icon(Icons.query_builder, size: 16, color: Colors.green,),
                                    Text(
                                      dateIndices[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kTextLightColor),
                                    ),

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
                                Text(highIndices[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,  fontSize: 15,
                                        color: kWhite)),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  spacing: 2,
                                  children: [
                                    changeIndices[index][0] == '-' ? Text(
                                      changeIndices[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ) : Text(
                                      changeIndices[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  changePtcIndices[index][0] == '-'
                                      ? Text(
                                    '(${changePtcIndices[index]})',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                      : Text(
                                    '(${changePtcIndices[index]})',
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
    );
  }
}
