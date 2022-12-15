import 'package:charity/models/home_screen_model.dart';
import 'package:equatable/equatable.dart';

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

  List<PooyeshesModel> pooyeshModel;

  List<ProjectModel> projectModel;

  HomeLoadedState({
    required this.teller,
    required this.arabicText,
    required this.farsiText,
    required this.pooyeshModel,
    required this.projectModel,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        teller,
        arabicText,
        farsiText,
        pooyeshModel,
        projectModel,
      ];
}
