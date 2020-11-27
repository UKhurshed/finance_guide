import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/quote/quote.dart';
import 'package:meta/meta.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteCubit(this.quoteRepository) : super(QuoteInitial());

  Future<void> getQuote() async{
    try{
      emit(QuoteLoading());
      final quote = await quoteRepository.getQuote();
      emit(QuoteLoaded(quote));
    }catch(error){
      print('Error: $error');
      emit(QuoteError(error));
    }
  }
}




