import 'package:dartz/dartz.dart';

import '../../models/home_models.dart';
import '../../models/news_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NewsModel> newsModl;
  Either<String, List> response;

  HomeLoadedState({
    required this.newsModl,
    required this.response,
  });
}
