import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/currency/model/currency_model.dart';
import 'package:finance_guide/home/currency/repository/currency_repository.dart';
import 'package:meta/meta.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyRepository currencyRepository;
  CurrencyCubit(this.currencyRepository) : super(CurrencyInitial());

  Future<void> getCurrency(String base) async{
    try{
      emit(CurrencyLoading());
      final currency = await currencyRepository.getCurrency(base);
      emit(CurrencyLoaded(currency));
    }catch(error){
      print('Error: $error');
      emit(CurrencyError(error));
    }
  }
}
