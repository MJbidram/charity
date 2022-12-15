import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repositories _repositories;
  HomeBloc(this._repositories) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final hadis = await _repositories.getHadisData();
      final pooyeshes = await _repositories.getPooyeshesData();
      final projects = await _repositories.getprojectData();
      emit(
        HomeLoadedState(
          teller: hadis.teller,
          arabicText: hadis.arabicText,
          farsiText: hadis.farsiText,
          pooyeshModel: pooyeshes,
          projectModel: projects,
        ),
      );
    });
  }
}
