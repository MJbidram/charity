import 'package:charity/models/charity_model.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:equatable/equatable.dart';

abstract class CharityState extends Equatable {}

class CharityLoadingFirstTypeState extends CharityState {
  @override
  List<Object?> get props => [];
}

class CharityLoadedFirstTypeState extends CharityState {
  final List<CharityModelFirst> items;
  CharityLoadedFirstTypeState({required this.items});
  @override
  List<Object?> get props => [items];
}

class CharityExseptionLoadedFirstTypeState extends CharityState {
  final String exseption;
  CharityExseptionLoadedFirstTypeState({required this.exseption});
  @override
  List<Object?> get props => [exseption];
}

class CharityLoadingSecandTypeState extends CharityState {
  @override
  List<Object?> get props => [];
}

class CharityLoadedSecandTypeState extends CharityState {
  final List<CharityModelSecand> item;
  CharityLoadedSecandTypeState({required this.item});
  @override
  List<Object?> get props => [item];
}

class CharityExseptionLoadedSecandTypeState extends CharityState {
  final String exseption;
  CharityExseptionLoadedSecandTypeState({required this.exseption});
  @override
  List<Object?> get props => [exseption];
}

class CharityLoadingUrlState extends CharityState {
  @override
  List<Object?> get props => [];
}

class CharityLoadedUrlState extends CharityState {
  final PayLinkModel payLinkModel;
  CharityLoadedUrlState({required this.payLinkModel});
  @override
  List<Object?> get props => [payLinkModel];
}

class CharityExseptionLoadingUrlState extends CharityState {
  final String exeption;
  CharityExseptionLoadingUrlState({required this.exeption});
  @override
  List<Object?> get props => [];
}

class CharityOpenBrowserState extends CharityState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CharityExseptionOpenBrowserState extends CharityState {
  final String exeption;
  CharityExseptionOpenBrowserState(this.exeption);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CharityPaymentValidating extends CharityState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CharityPaymentSoccesState extends CharityState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CharityPaymentUnsuccessState extends CharityState {
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
