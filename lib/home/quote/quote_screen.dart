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

/*
     if (state is QuoteError) {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //   content: Text('Error'),
          //   backgroundColor: Colors.red,
          //   duration: Duration(seconds: 2),
          // ));
          return InputField();
        }
        if (state is QuoteInitial) {
          return InputField();
        }
        if (state is QuoteLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is QuoteLoaded) {
          return
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.quote.length,
                itemBuilder: (context, index) {
                  Quote quote = state.quote[index];
                  return ListTile(
                    title: Text(quote.change.toString() ?? '0.0',),
                    leading: Text(quote.symbol ?? 'sym'),
                    trailing: Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green)),
                  );
                });
        }
        return Text('Else');
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Quotes'),),
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
              return
              // Quote quote = state.quote;
              // return ListTile(
              //   title: Text(quote.change.toString() ?? '0.0'),
              //   leading: Text(quote.symbol ?? 'sym'),
              //   trailing: Text(quote.changePercent.toString() ?? '%',
              //       style: quote.changePercent < 0
              //           ? TextStyle(color: Colors.red)
              //           : TextStyle(color: Colors.green)),
              // );
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.quote.length,
                  itemBuilder: (context, index) {
                    Quote quote = state.quote[index];
                    return InkWell(
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Details(quote)));
                      },
                      child: Card(
                        color: Colors.grey[200],
                        child: ListTile(
                          title: Text(quote.change.toString() ?? '0.0', style: TextStyle(fontSize: 16),),
                          leading: Text(quote.symbol ?? 'sym', style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red, fontSize: 18) : TextStyle(color: Colors.green, fontSize: 18)),
                        ),
                      ),
                    );
                  });
              //   ListView.separated(
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       itemCount: state.quote.length,
              //       itemBuilder: (context, index) {
              //         Quote quote = state.quote[index];
              //         return ListTile(
              //           title: Text(quote.change.toString() ?? '0.0',),
              //           leading: Text(quote.symbol ?? 'sym'),
              //           trailing: Text(quote.changePercent.toString() ?? '%', style: quote.changePercent < 0 ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green)),
              //         );
              //       },
              //     separatorBuilder: (context, index){
              //         return Divider();
              //     },
              //       );
            } else {
              return inputField();
            }
          }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // submitSymbol(context, textEdit.text);
      //     final quoteCubit = context.read<QuoteCubit>();
      //     quoteCubit.getQuote('aapl');
      //   },
      //   child: Icon(Icons.search),
      // ),
    );
  }



  // _quoteDetails(Quote quote){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => QuoteDetailsPage(), settings: RouteSettings(arguments: QuoteDetailsArgument(quote))));
  // }

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
