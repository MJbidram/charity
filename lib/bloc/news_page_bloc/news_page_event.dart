import 'package:equatable/equatable.dart';

abstract class NewsPageEvent extends Equatable {
  const NewsPageEvent();
}

class LoadNewsApIEvent extends NewsPageEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
