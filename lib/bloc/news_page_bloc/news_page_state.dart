import 'package:charity/models/models.dart';

import 'package:equatable/equatable.dart';

import '../../models/news_model.dart';

abstract class NewsState extends Equatable {}

class NewsLoadingState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsModel;

  NewsLoadedState({
    required this.newsModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        newsModel,
      ];
}
