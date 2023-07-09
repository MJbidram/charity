import 'package:charity/models/marasemat.dart';
import 'package:dartz/dartz.dart';

class MarasematState {}

class MarasematInitState extends MarasematState {}

class LoadingMarasemState extends MarasematState {}

class MarasematLoadedState extends MarasematState {
  Either<String, List<MarasematModel>> response;
  MarasematLoadedState(this.response);
}

class MarasematFilterState extends MarasematState {
  Either<String, List<MarasematModel>> response;
  MarasematFilterState(this.response);
}
