import 'package:charity/bloc/details_of_sliders/details_event.dart';
import 'package:charity/bloc/details_of_sliders/details_state.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/details_of_slider_repository.dart';

class DetailSliderBloc extends Bloc<DetailsEvent, DetailState> {
  final IDetailsOfSlidersRepositotys _repository = locator.get();
  DetailSliderBloc() : super(DetailInitState()) {
    on<LoadPooyshEvent>((event, emit) async {
      emit(DetailLoadingState());

      var response = await _repository.getPooyeshDetails(event.id);
      emit(DetailShowPooyeshState(response));
    });

    on<LoadProjectEvent>((event, emit) async {
      emit(DetailLoadingState());
      var response = await _repository.getProjectDetails(event.id);
      emit(DetailShowProjectsState(response));
    });
  }
}
