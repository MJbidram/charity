import 'package:charity/models/aboutus_model.dart';
import 'package:dartz/dartz.dart';

abstract class AboutUsState {}

class AboutUsInitState extends AboutUsState {}

class AboutUsLoadedState extends AboutUsState {
  Either<String, AboutUsModel> response;
  AboutUsLoadedState(this.response);
}
