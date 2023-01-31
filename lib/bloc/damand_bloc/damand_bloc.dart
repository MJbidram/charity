import 'package:charity/bloc/damand_bloc/damand_event.dart';
import 'package:charity/bloc/damand_bloc/damand_state.dart';
import 'package:charity/data/repository/damand_repository.dart';
import 'package:charity/data/repository/profile_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DamandBloc extends Bloc<DamandEvent, DamandState> {
  final IDamandRepository repository = locator.get();
  final IprofileRepository profileRepo = locator.get();
  DamandBloc() : super(DamandInitState()) {
    on<GetDamandFirstTypeEvent>((event, emit) async {
      emit(DamandLoadingState());
      var response = await repository.getDamandTypes();
      var proResponse = await profileRepo.getProfileDetails();
      emit(DamandLoadedFirstTypes(response, proResponse));
    });

    on<GetDamandSecandTypeEvent>((event, emit) async {
      var response = await repository.getDamandSecandTypes(event.firstType);

      emit(DamandLoadedSecandTypes(response));
    });
    on<SendDamandEvent>((event, emit) async {
      emit(DamandLoadingState());
      var response = await repository.sendDamand(
          event.details ?? 'بدون توضیحات', event.type);
      emit(DamandSendedState(response));
    });
  }
}
