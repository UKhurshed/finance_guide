import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:meta/meta.dart';

part 'quote_details_state.dart';

class QuoteDetailsCubit extends Cubit<QuoteDetailsState> {
  final QuoteDetailsRepository quoteDetailsRepository;

  QuoteDetailsCubit(this.quoteDetailsRepository) : super(QuoteDetailsInitial());


  Future<void> getWeeklyQuote(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final quoteDetails = await quoteDetailsRepository.getWeekly(sym);
      emit(QuoteDetailsLoaded(quoteDetails));
    }catch(error){
      print('Error: $error');
      emit(QuoteDetailsError(error));
    }
  }

  Future<void> getDailyQuote(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final quoteDetails = await quoteDetailsRepository.getDaily(sym);
      emit(QuoteDetailsLoaded(quoteDetails));
    }catch(error){
      print('Error: $error');
      emit(QuoteDetailsError(error));
    }
  }

}
