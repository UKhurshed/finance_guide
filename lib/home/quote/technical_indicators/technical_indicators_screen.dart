import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class TechnicalIndicatorsScreen extends StatefulWidget {

  final String symbol;
  TechnicalIndicatorsScreen(this.symbol);

  @override
  _TechnicalIndicatorsScreenState createState() => _TechnicalIndicatorsScreenState(this.symbol);
}

class _TechnicalIndicatorsScreenState extends State<TechnicalIndicatorsScreen> {
  final String sym;
  _TechnicalIndicatorsScreenState(this.sym);
  String instrumentHeader;
  String resume;
  String avgCount;
  String techIndicator;
  String indicatorsSym;
  String indicatorsVal;
  List indi = new List();
  List indiValues = new List();


  @override
  void initState() {
    getElements(sym);
    super.initState();
  }

  Future<void> getElements(String sym) async{
    final webScraper = WebScraper('https://ru.investing.com');
    switch(sym){
      case 'AAPL':{
        if(await webScraper.loadWebPage("/equities/apple-computer-inc")){
          fetchElements(webScraper);
        }
      }
      break;
      case "MSFT":{
        if(await webScraper.loadWebPage("/equities/microsoft-corp-technical")){
          fetchElements(webScraper);
        }
      }
      break;
      case "IBM":{
        if(await webScraper.loadWebPage("/equities/ibm-technical")){
          fetchElements(webScraper);
        }
      }
      break;
      case "ORCL":{
        if(await webScraper.loadWebPage("/oracle-corp-technical")){
          fetchElements(webScraper);
        }
      }
      break;
      case "HPQ":{
        if(await webScraper.loadWebPage("/equities/hewlett-pack-technical")){
          fetchElements(webScraper);
        }
      }
      break;
      case "FB":{
        if(await webScraper.loadWebPage("/equities/facebook-inc")){
          fetchElements(webScraper);
        }
      }
      break;
      default: { print("Invalid choice"); }
      break;
    }
  }

  void fetchElements(WebScraper webScraper){

    setState(() {
      resume = webScraper.getElement('div.summary', [])[1]['title'].toString();
      final characters = webScraper.getElement("td.first.left.symbol",[]);
      final value = webScraper.getElement("td.right", []);
      for(var i in characters){
        indi.add(i['title']);
      }
      for(var k in value){
        indiValues.add(k['title']);
      }
      debugPrint("TechScreen: $resume");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Texaнализ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(resume ?? ''),
              SizedBox(height: 10,),
              Text('Технические индикаторы'),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: indi.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Text(indi[index]),
                      title: Text(indiValues[index]),
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
