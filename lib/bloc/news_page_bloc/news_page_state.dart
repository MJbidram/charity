import 'package:charity/models/models.dart';

import 'package:equatable/equatable.dart';

abstract class NewsPageState extends Equatable {}

class NewsPageLoadingState extends NewsPageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsPageLoadedState extends NewsPageState {
  final List<NewsModel> newsModel;

  NewsPageLoadedState({
    required this.newsModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        newsModel,
      ];
}
