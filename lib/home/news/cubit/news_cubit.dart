import 'package:bloc/bloc.dart';
import 'package:finance_guide/home/news/news.dart';
import 'package:finance_guide/home/news/repository/news_repository.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.newsRepository) : super(NewsInitial());

  final NewsRepository newsRepository;
  Future<void> getNews(String query) async{
    try{
      // emit(SearchNewsLoading());
      final news = await newsRepository.getNews(query);
      emit(NewsLoaded(news));
    }catch(error){
      print('Error: $error');
      emit(NewsError(error));
    }
  }
}
