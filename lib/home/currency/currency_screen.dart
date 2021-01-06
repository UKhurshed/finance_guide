import 'package:finance_guide/home/currency/cubit/currency_cubit.dart';
import 'package:finance_guide/home/currency/details/currency_detail_screen.dart';
import 'package:finance_guide/home/currency/repository/currency_repository.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Currency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrencyInit(CurrencyRepository()),
    );
  }
}

class CurrencyInit extends StatelessWidget {
  final CurrencyRepository currencyRepository;

  CurrencyInit(this.currencyRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyCubit(currencyRepository),
      child: CurrencyScreen(),
    );
  }
}

class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  @override
  void initState() {
    super.initState();
    final currencyCubit = context.read<CurrencyCubit>();
    currencyCubit.getCurrency("USD");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text('Форекс'),
      ),
      body:
          BlocBuilder<CurrencyCubit, CurrencyState>(builder: (context, state) {
        if (state is CurrencyError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Error'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ));
        }
        if (state is CurrencyInitial) {
          return loadingIndicator();
        }
        if (state is CurrencyLoading) {
          return loadingIndicator();
        }
        if (state is CurrencyLoaded) {
          var currency = state.currency.rates;
          var entries = currency.entries.toList();
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(color: kItemUnSelected,  ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: currency.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrDetailScreen(entries.elementAt(index).key)));
                  },
                  child:
                  // Card(
                  //   // color: Colors.black87,
                  //   child:
                    ListTile(
                      title: Text(
                        entries.elementAt(index).value.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      leading: Text(entries.elementAt(index).key,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  // ),
                );
              });
        } else {
          return Center(
            child: Text('Center Currency'),
          );
        }
      }),
    );
  }

  Widget loadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }
}
