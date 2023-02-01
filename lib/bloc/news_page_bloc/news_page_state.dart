import 'package:charity/models/models.dart';
import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';

import '../../models/news_model.dart';

abstract class NewsState {}

class NewsInitState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  // final List<NewsModel> newsModel;
  final Either<String, List<NewsModel>> response;

  NewsLoadedState(
      {
      // required this.newsModel,
      required this.response});
}
