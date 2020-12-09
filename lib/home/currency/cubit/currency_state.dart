part of 'currency_cubit.dart';

@immutable
abstract class CurrencyState {
  const CurrencyState();
}

class CurrencyInitial extends CurrencyState {
  const CurrencyInitial();
}

class CurrencyLoading extends CurrencyState {
  const CurrencyLoading();
}

class CurrencyError extends CurrencyState {
  final String message;
  const CurrencyError(this.message);
}

class CurrencyLoaded extends CurrencyState {
  final Currency currency;
  const CurrencyLoaded(this.currency);
}