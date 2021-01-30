import 'package:finance_guide/home/currency/currency_screen.dart';
import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/home/quote/crypto_currencies/crypto_currencies_screen.dart';
import 'package:finance_guide/home/quote/indices_futures/indices_futures_screen.dart';
import 'package:finance_guide/home/quote/major_etf/major_etf_screen.dart';
import 'package:finance_guide/home/quote/major_funds/major_funds_screen.dart';
import 'package:finance_guide/home/quote/major_indices/major_indices_screen.dart';
import 'package:finance_guide/home/quote/most_active_stocks/most_activie_stocks_screen.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:finance_guide/home/quote/realtime_futures/realtime_futures_screen.dart';
import 'package:finance_guide/home/quote/single_currency/single_cross_screen.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details/details_screen.dart';

class QuoteMain extends StatelessWidget implements PreferredSizeWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(46.5),
          child: AppBar(
            backgroundColor: kAppBarMain,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Акции A',),
                Tab(text: 'Форекс A',),
                Tab(text: 'Индексы'),
                Tab(text: 'Фьючерсы'),
                Tab(text: 'Акции'),
                Tab(text: 'Товары'),
                Tab(text: 'Форекс'),
                // Tab(text: 'Криптовалюты'),
                Tab(text: 'ETF'),
                Tab(text: 'Фонды'),
              ],

              isScrollable: true,
              indicatorWeight: 0.1,
              indicatorColor: kWhite,
              unselectedLabelColor: kItemUnSelected,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            QuoteBuilder(),
            Currency(),
            MajorIndicesScreen(),
            IndicesFuturesScreen(),
            MostActiveStocksScreen(),
            RealTimeFuturesScreen(),
            SingleCurrencyScreen(),
            // CryptoCurrenciesScreen(),
            MajorEtfScreen(),
            MajorFundsScreen(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(5);
}

class QuoteBuilder extends StatelessWidget {
  const QuoteBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteCubit(QuoteRepository()),
      child: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  TextEditingController textEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: BlocBuilder<QuoteCubit, QuoteState>(builder: (context, state) {
            if (state is QuoteInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteLoaded) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: kItemUnSelected,
                      ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.quote.length,
                  itemBuilder: (context, index) {
                    Quote quote = state.quote[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(quote)));
                      },
                      child: ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    quote.companyName ?? 'sym',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    quote.latestTime.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    quote.latestPrice.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  quote.change < 0
                                      ? Text(
                                          "(${quote.changePercent.toString()}%)",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Text(
                                          "(+${quote.changePercent.toString()}%)",
                                          style:
                                              TextStyle(color: Colors.green)),
                                  // SizedBox(height: 5,),
                                  // Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red, fontSize: 18) : TextStyle(color: Colors.green, fontSize: 18)),
                                ],
                              )),
                      // ),
                    );
                  });
            } else {
              return inputField();
            }
          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final quoteCubit = context.read<QuoteCubit>();
    quoteCubit.getQuote('aapl');
  }

  Widget inputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: textEdit,
        textInputAction: TextInputAction.search,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "Symbol is empty!";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter Symbols',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitSymbol(BuildContext context, String symbol) {
    final quoteSym = context.read<QuoteCubit>();
    quoteSym.getQuote(symbol);
  }
}
