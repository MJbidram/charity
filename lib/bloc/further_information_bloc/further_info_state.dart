import 'package:charity/models/wreath_tarh_model.dart';
import 'package:charity/models/wreath_types_model.dart';
import 'package:dartz/dartz.dart';

class FurtherInfoState {}

class FurtherInfoInitState extends FurtherInfoState {}

class LoadingFurtherInfoState extends FurtherInfoState {}

class FurtherInfoLoadedState extends FurtherInfoState {
  Either<String, WearthTypeModel> type;
  Either<String, WreathTarhModel> tarh;
  FurtherInfoLoadedState(this.type, this.tarh);
}

class LoadingCreatOrder extends FurtherInfoInitState {}
