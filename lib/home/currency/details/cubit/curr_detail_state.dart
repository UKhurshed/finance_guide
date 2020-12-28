part of 'curr_detail_cubit.dart';

@immutable
abstract class CurrDetailState {
  const CurrDetailState();
}

class CurrDetailInitial extends CurrDetailState {
  const CurrDetailInitial();
}

class CurrDetailLoading extends CurrDetailState{
  const CurrDetailLoading();
}

class CurrDetailLoaded extends CurrDetailState{
  final DetailRate rates;
  CurrDetailLoaded(this.rates);
}

class CurrDetailError extends CurrDetailState{
  final String message;
  const CurrDetailError(this.message);
}
