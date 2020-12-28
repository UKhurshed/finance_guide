import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/currency/details/currency_details.dart';
import 'package:finance_guide/home/currency/details/model/cu.dart';

import 'package:meta/meta.dart';


part 'curr_detail_state.dart';

class CurrDetailCubit extends Cubit<CurrDetailState> {
  final CurrencyDetailRepository currencyDetailRepository;

  CurrDetailCubit(this.currencyDetailRepository) : super(CurrDetailInitial());

  Future<void> getDaily(String curr) async{
    try{
      emit(CurrDetailLoading());
      var result = await currencyDetailRepository.getDaily(curr);
      emit(CurrDetailLoaded(result));
    }catch(error){
      debugPrint("Error: $error");
      emit(CurrDetailError(error));
    }
  }

  Future<void> getWeekly(String curr) async{
    try{
      emit(CurrDetailLoading());
      var result = await currencyDetailRepository.getWeekly(curr);
      emit(CurrDetailLoaded(result));
    }catch(error){
      debugPrint("Error: $error");
      emit(CurrDetailError(error));
    }
  }

  Future<void> getYearly(String curr) async{
    try{
      emit(CurrDetailLoading());
      var result = await currencyDetailRepository.getYearly(curr);
      emit(CurrDetailLoaded(result));
    }catch(error){
      debugPrint("Error: $error");
      emit(CurrDetailError(error));
    }
  }

  Future<void> getFiveYearly(String curr) async{
    try{
      emit(CurrDetailLoading());
      var result = await currencyDetailRepository.getFiveYear(curr);
      emit(CurrDetailLoaded(result));
    }catch(error){
      debugPrint("Error: $error");
      emit(CurrDetailError(error));
    }
  }


}
