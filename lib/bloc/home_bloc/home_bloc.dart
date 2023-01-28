import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/data/repositories/home_news.dart';
import 'package:charity/data/repository/home_data_repository.dart';
import 'package:charity/di/di.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeNews _repositoriesNews = HomeNews();
  final MYHomeRepository repository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      var response = await repository.getHomeData();
      var newsResponse = await _repositoriesNews.getHomePageListNews();
      // final homeData = await _repositories.getHomeData();
      // final homeNews = await _repositories.getHomePageListNews();
      emit(
          // HomeLoadedState(
          //   teller: homeData[2].teller,
          //   arabicText: homeData[2].arabicText,
          //   farsiText: homeData[2].farsiText,
          //   pooyeshModel: homeData[0],
          //   projectModel: homeData[1],
          //   newsModl: homeNews,
          // ),
          HomeLoadedState(response: response, newsModl: newsResponse));
    });
  }
}
