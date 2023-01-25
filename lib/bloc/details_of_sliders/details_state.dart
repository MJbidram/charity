import 'package:charity/models/pooyesh_model.dart';
import 'package:charity/models/projects_model.dart';
import 'package:dartz/dartz.dart';

abstract class DetailState {}

class DetailInitState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailShowPooyeshState extends DetailState {
  Either<String, PooyeshModel> response;
  DetailShowPooyeshState(this.response);
}

class DetailShowProjectsState extends DetailState {
  Either<String, ProjectModel> response;
  DetailShowProjectsState(this.response);
}
