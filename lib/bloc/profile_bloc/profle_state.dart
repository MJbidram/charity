import 'package:charity/models/profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  Either<String, ProfileModel> response;
  ProfileLoadedState(this.response);
}
