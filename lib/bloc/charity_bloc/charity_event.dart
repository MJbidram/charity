import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:equatable/equatable.dart';

abstract class CharityEvent extends Equatable {
  const CharityEvent();
}

class LoadApiEvent extends CharityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadWithSub extends CharityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
