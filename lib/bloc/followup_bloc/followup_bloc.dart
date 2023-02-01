import 'package:charity/bloc/followup_bloc/followup_event.dart';
import 'package:charity/bloc/followup_bloc/followup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/damand_repository.dart';
import '../../di/di.dart';

class FollowUpDamandBloc extends Bloc<FollowUpEvent, FollowUpState> {
  FollowUpDamandBloc() : super(FollowUpInitState()) {
    final IDamandRepository repository = locator.get();
    on<FollowUpLoadEvent>((event, emit) async {
      emit(FollowUpInitState());
      var response = await repository.followUpDamand();
      emit(FollowUpLoadedState(response));
    });
  }
}
