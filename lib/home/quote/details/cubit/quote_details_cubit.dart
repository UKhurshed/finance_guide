import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/quote/details/model/quote_historical.dart';
import 'package:finance_guide/home/quote/details/repository/quote_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'quote_details_state.dart';

class QuoteDetailsCubit extends Cubit<QuoteDetailsState> {
  final HistoryRepository historyRepository;

  QuoteDetailsCubit(this.historyRepository) : super(QuoteDetailsInitial());


  Future<void> getWeekly(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final items = await historyRepository.getWeekly(sym);
      emit(QuoteDetailsLoaded(items));
    }catch(error){
      debugPrint("History Cubit Error: $error");
      emit(QuoteDetailsError(error));
    }
  }

  Future<void> getMonthly(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final items = await historyRepository.getMonthly(sym);
      emit(QuoteDetailsLoaded(items));
    }catch(error){
      debugPrint("History Cubit Error: $error");
      emit(QuoteDetailsError(error));
    }
  }

  Future<void> getYear(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final items = await historyRepository.getYear(sym);
      emit(QuoteDetailsLoaded(items));
    }catch(error){
      debugPrint("History Cubit Error: $error");
      emit(QuoteDetailsError(error));
    }
  }

  Future<void> getFiveYear(String sym) async{
    try{
      emit(QuoteDetailsLoading());
      final items = await historyRepository.getFiveYear(sym);
      emit(QuoteDetailsLoaded(items));
    }catch(error){
      debugPrint("History Cubit Error: $error");
      emit(QuoteDetailsError(error));
    }
  }

  // Future<void> getDailyQuote(String sym) async{
  //   try{
  //     emit(QuoteDetailsLoading());
  //     final quoteDetails = await quoteDetailsRepository.getWeekly(sym);
  //     emit(QuoteDetailsLoaded(quoteDetails));
  //   }catch(error){
  //     print('Error: $error');
  //     emit(QuoteDetailsError(error));
  //   }
  // }

}
