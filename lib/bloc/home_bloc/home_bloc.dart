import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repositories _repositories;
  HomeBloc(this._repositories) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final activity = await _repositories.getHadisData();
      emit(HomeLoadedState(
          activity.teller, activity.arabicText, activity.farsiText));
    });
  }
}
