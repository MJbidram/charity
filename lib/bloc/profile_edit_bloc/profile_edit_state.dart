import 'package:charity/models/profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileEditState {}

class PorfileEditInitState extends ProfileEditState {}

class ProfileEditLoadedState extends ProfileEditState {
  Either<String, ProfileModel> response;
  ProfileEditLoadedState(this.response);
}

class ProfileLoadingState extends ProfileEditState {}

class ProfileEditSetCahngeState extends ProfileEditState {
  Either<String, ProfileUpdateModel> response;
  ProfileEditSetCahngeState(this.response);
}
