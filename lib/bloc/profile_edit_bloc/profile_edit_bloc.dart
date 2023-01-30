import 'package:charity/bloc/profile_edit_bloc/profile_edit_event.dart';
import 'package:charity/bloc/profile_edit_bloc/profile_edit_state.dart';
import 'package:charity/data/repository/profile_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PorfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final IprofileRepository _repository = locator.get();
  PorfileEditBloc() : super(PorfileEditInitState()) {
    on<LoadDetailsProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      var response = await _repository.getProfileDetails();
      emit(ProfileEditLoadedState(response));
    });
    on<SetEditProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      var response = await _repository.profileUpdate(
        address: event.address,

        email: event.email,
        phone: event.phone,
        username: event.username,

        // event.password,
        // event.password,
        // event.paswordConfirm,
      );
      emit(ProfileEditSetCahngeState(response));
    });
  }
}
