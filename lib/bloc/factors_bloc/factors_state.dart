import 'package:charity/models/factors_model.dart';
import 'package:dartz/dartz.dart';

abstract class FactorsState {}

class FactorsInitState extends FactorsState {}

class FactorsLoadingState extends FactorsState {}

class FactorsLoadedState extends FactorsState {
  Either<String, List<FactorsModle>> response;
  FactorsLoadedState(this.response);
}
