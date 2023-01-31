import 'package:charity/models/damand_model.dart';
import 'package:charity/models/profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class DamandState {}

class DamandInitState extends DamandState {}

class DamandLoadingState extends DamandState {}

class DamandLoadedFirstTypes extends DamandState {
  Either<String, ProfileModel> checkeAddress;
  Either<String, List<DamandFirstTypeModel>> response;
  DamandLoadedFirstTypes(this.response, this.checkeAddress);
}

class DamandLoadedSecandTypes extends DamandState {
  Either<String, List<DamandSecandTypeModel>> response;
  DamandLoadedSecandTypes(this.response);
}

class DamandSendedState extends DamandState {
  Either<String, String> response;
  DamandSendedState(this.response);
}
