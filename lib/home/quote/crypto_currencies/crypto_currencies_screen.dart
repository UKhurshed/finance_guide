import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class CryptoCurrenciesScreen extends StatefulWidget {
  @override
  _CryptoCurrenciesScreenState createState() => _CryptoCurrenciesScreenState();
}

class _CryptoCurrenciesScreenState extends State<CryptoCurrenciesScreen> {
  var nameCurrency = List();
  var priceCurrency = List();
  final changePtcCurrency = List();
  // final dateCurrency = List();

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  final emptyStocks = [
    // 'pid-1',
    // 'pid-2',
    // 'pid-3',
    // 'pid-4',
    // 'pid-5',
    // 'pid-7',
    // 'pid-8',
    // 'pid-17',
    // 'pid-18',
    // 'pid-39',
    // 'pid-40',
    // 'pid-41',
    // 'pid-42',
    // 'pid-43',
    // 'pid-59',
    // 'pid-63',
    // 'pid-91',
    // 'pid-103',
    // 'pid-147',
    // 'pid-152'
  ];

  Future<void> getCurrency() async {
    final response =
    await http.get("https://ru.investing.com/crypto/currencies");
    if (response.statusCode == 200) {
      fetchElements(response.body);
    } else
      debugPrint("Error");
  }

  void fetchElements(String body) {
    setState(() {
      var document = parse(body);
      debugPrint(
          "Web: ${document.getElementsByClassName("price.js-currency-price")}");
      nameCurrency =
          document.getElementsByClassName("left.bold.elp.name.cryptoName.first.js-currency-name");
      priceCurrency = document.getElementsByClassName("price.js-currency-price");
      for (var j in emptyStocks) {
        // priceCurrency.add(
        //     document.getElementsByClassName(j + '-last')[0].firstChild.text);
        changePtcCurrency.add(
            document.getElementsByClassName('js-currency-change-24h.$j-pcp')[0].firstChild.text);
        // dateCurrency
        //     .add(document.getElementsByClassName("$j-time")[0].firstChild.text);
        // print('Date: ${dateCurrency.first}');
        print('Names ${nameCurrency.first.text}');
        print('Last Crypto: ${priceCurrency.first}');
        print('ChangePtc Crypto: ${changePtcCurrency.first}');
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
              priceCurrency.isEmpty
                  ? CircularProgressIndicator()
                  : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(nameCurrency[index].text, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(priceCurrency[index].text, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kWhite)),
                              SizedBox(
                                height: 5,
                              ),
                              changePtcCurrency[index][0] == '-'
                                  ? Text(
                                changePtcCurrency[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              )
                                  : Text(
                                changePtcCurrency[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
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
