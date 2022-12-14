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

  HomeLoadedState(this.teller, this.arabicText, this.farsiText);
  @override
  // TODO: implement props
  List<Object?> get props => [teller, arabicText, farsiText];
}
