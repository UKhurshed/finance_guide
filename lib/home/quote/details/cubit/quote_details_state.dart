part of 'quote_details_cubit.dart';

@immutable
abstract class QuoteDetailsState {
  const QuoteDetailsState();
}

class QuoteDetailsInitial extends QuoteDetailsState {
  const QuoteDetailsInitial();
}

class QuoteDetailsLoading extends QuoteDetailsState{
  const QuoteDetailsLoading();
}

class QuoteDetailsLoaded extends QuoteDetailsState{
  final QuoteHistorical quoteHistorical;
  QuoteDetailsLoaded(this.quoteHistorical);
}

class QuoteDetailsError extends QuoteDetailsState{
  final String message;
  const QuoteDetailsError(this.message);
}
