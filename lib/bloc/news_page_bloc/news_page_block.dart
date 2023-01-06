import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/data/repositories/news_repositorys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepositorys _repositories = NewsRepositorys();
  NewsBloc() : super(NewsLoadingState()) {
    on<LoadNewsApIEvent>((event, emit) async {
      final newsData = await _repositories.getNews();
      emit(NewsLoadedState(newsModel: newsData));
    });
  }
}
