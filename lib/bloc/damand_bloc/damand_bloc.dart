import 'package:charity/bloc/damand_bloc/damand_event.dart';
import 'package:charity/bloc/damand_bloc/damand_state.dart';
import 'package:charity/data/repository/damand_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DamandBloc extends Bloc<DamandEvent, DamandState> {
  final IDamandRepository repository = locator.get();
  DamandBloc() : super(DamandInitState()) {
    on<GetDamandFirstTypeEvent>((event, emit) async {
      var response = await repository.getDamandTypes();
      emit(DamandLoadedFirstTypes(response));
    });

    on<GetDamandSecandTypeEvent>((event, emit) async {
      var response = await repository.getDamandSecandTypes(event.firstType);

      emit(DamandLoadedSecandTypes(response));
    });
  }
}
