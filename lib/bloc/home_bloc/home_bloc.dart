import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repositories = HomeRepository();
  HomeBloc() : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final homeData = await _repositories.getHomeData();
      final homeNews = await _repositories.getHomePageListNews();
      emit(
        HomeLoadedState(
          teller: homeData[2].teller,
          arabicText: homeData[2].arabicText,
          farsiText: homeData[2].farsiText,
          pooyeshModel: homeData[0],
          projectModel: homeData[1],
          newsModl: homeNews,
        ),
      );
    });
  }
}
