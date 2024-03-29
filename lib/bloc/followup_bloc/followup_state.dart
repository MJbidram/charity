import 'package:charity/models/damand_model.dart';
import 'package:dartz/dartz.dart';

abstract class FollowUpState {}

class FollowUpInitState extends FollowUpState {}

class FollowUpLoadedState extends FollowUpState {
  final Either<String, List<DamandListModle>> response;
  FollowUpLoadedState(this.response);
}

class FollowUpDeleteState extends FollowUpState {
  final Either<String, String> response;
  FollowUpDeleteState(this.response);
}

class FollowUpUpdateState extends FollowUpState {}
