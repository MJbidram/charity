import 'package:charity/bloc/news_page_bloc/news_page_event.dart';
import 'package:charity/bloc/news_page_bloc/news_page_state.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPageBloc extends Bloc<NewsPageEvent, NewsPageState> {
  final Repositories _repositories;
  NewsPageBloc(this._repositories) : super(NewsPageLoadingState()) {
    on<LoadNewsApIEvent>((event, emit) async {
      final _newsData = await _repositories.getNews();
      emit(NewsPageLoadedState(newsModel: _newsData));
    });
  }
}
