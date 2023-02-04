import 'package:charity/bloc/profile_bloc/profile_event.dart';
import 'package:charity/bloc/profile_bloc/profle_state.dart';
import 'package:charity/bloc/profile_edit_bloc/profile_edit_event.dart';
import 'package:charity/data/repository/profile_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class ProfielBloc extends Bloc<ProflieEvent, ProfileState> {
  ProfielBloc() : super(ProfileInitState()) {
    final IprofileRepository _repository = locator.get();
    on<LoadProfleEvent>((event, emit) async {
      emit(ProfileInitState());
      var response = await _repository.getProfileDetails();
      emit(ProfileLoadedState(response));
    });
  }
}
