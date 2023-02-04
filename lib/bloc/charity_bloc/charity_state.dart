import 'package:charity/models/charity_model.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class CharityState {}

class CharityInitState extends CharityState {}

class CharityLoadedFirstTypeState extends CharityState {
  final Either<String, List<CharityModelFirst>> items;
  CharityLoadedFirstTypeState({required this.items});
}

class CharityLoadedSecandTypeState extends CharityState {
  Either<String, List<CharityModelSecand>> items;

  CharityLoadedSecandTypeState({required this.items});
}

class CharityLoadingUrlState extends CharityState {
  @override
  List<Object?> get props => [];
}

class CharityLoadedUrlState extends CharityState {
  final Either<String, PayLinkModel> response;
  CharityLoadedUrlState(this.response);
}

class CharityOpenBrowserState extends CharityState {
  final Either<String, String> response;
  CharityOpenBrowserState(this.response);
}

class CharityPaymentValidating extends CharityState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CharityShortCutState extends CharityState {
  int id;
  String title;
  CharityShortCutState({required this.id, required this.title});
  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}
