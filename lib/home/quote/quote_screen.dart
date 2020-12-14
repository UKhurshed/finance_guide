import 'package:finance_guide/home/drawer/drawer.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details/details_screen.dart';

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
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Quotes'),
      ),
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
              return ListView.builder(
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
                          child: Card(
                            color: Colors.grey[200],
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(quote.latestTime.toString())
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(quote.latestPrice.toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    quote.change < 0
                                        ? Text(
                                            "(${quote.changePercent}%)",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : Text("(+${quote.changePercent}%)",
                                            style:
                                                TextStyle(color: Colors.green)),
                                    // SizedBox(height: 5,),
                                    // Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red, fontSize: 18) : TextStyle(color: Colors.green, fontSize: 18)),
                                  ],
                                )),
                          ),
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

// class InputField extends StatelessWidget {
//   TextEditingController textEdit = TextEditingController();
//   bool isValid = false;
//
//   void submitSymbol(BuildContext context, String symbol) {
//     final quoteSym = context.read<QuoteCubit>();
//     quoteSym.getQuote(symbol);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: textEdit,
//             textInputAction: TextInputAction.search,
//             validator: (text){
//               if(text == null || text.isEmpty){
//                 return "Symbol is empty!";
//
//               }else{
//                 return null;
//               }
//             },
//             decoration: InputDecoration(
//               hintText: 'Enter Symbols',
//               suffixIcon: Icon(Icons.search),
//             ),
//           ),
//           // RaisedButton(onPressed: (){
//           //   submitSymbol(context, textEdit.text);
//           // },
//           //     child: Text('Submit'),
//           //     textColor: Colors.black,
//           //     color: Colors.white
//           // )
//         ],
//       ),
//     );
//   }
// }

// class InputField extends StatelessWidget {
//   TextEditingController textEdit = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: TextField(
//
//         textInputAction: TextInputAction.search,
//
//         decoration: InputDecoration(
//           hintText: 'Enter Symbols',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           suffixIcon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }
//
//   void submitSymbol(BuildContext context, String symbol) {
//     final quoteSym = context.read<QuoteCubit>();
//     quoteSym.getQuote(symbol);
//   }
// }
