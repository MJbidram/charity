import 'package:charity/bloc/factors_bloc/factors_event.dart';
import 'package:charity/bloc/factors_bloc/factors_state.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FactorsBloc extends Bloc<FactorsEvent, FactorsState> {
  final IFactorsRepositorys _repositorys = locator.get();
  FactorsBloc() : super(FactorsInitState()) {
    on<FactorRequestListEvent>((event, emit) async {
      emit(FactorsLoadingState());
      var response = await _repositorys.getFactors(event.token!);
      emit(FactorsLoadedState(response));
    });
  }
}
