import 'package:equatable/equatable.dart';

import '../../models/home_models.dart';
import '../../models/news_model.dart';

abstract class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final String teller;
  final String arabicText;
  final String farsiText;

  final List<HomePooyeshModel> pooyeshModel;

  final List<HomeProjectsModel> projectModel;

  final List<NewsModel> newsModl;

  HomeLoadedState({
    required this.teller,
    required this.arabicText,
    required this.farsiText,
    required this.pooyeshModel,
    required this.projectModel,
    required this.newsModl,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        teller,
        arabicText,
        farsiText,
        pooyeshModel,
        projectModel,
        newsModl,
      ];
}
