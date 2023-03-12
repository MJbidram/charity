import 'package:charity/bloc/charity_bloc/charity_event.dart';
import 'package:charity/bloc/charity_bloc/charity_state.dart';
import 'package:charity/data/repository/charity_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/payment_repository.dart';

class CharityBloc extends Bloc<CharityEvent, CharityState> {
  final MyCharityRepository _charityRepository = locator.get();
  CharityBloc() : super(CharityInitState()) {
    on<LoadFirstTypeEvent>((event, emit) async {
      final firstTypeEither = await _charityRepository.getFirstTyp();

      emit(CharityLoadedFirstTypeState(items: firstTypeEither));
    });

    on<LoadSecandTypeEvent>((event, emit) async {
      // emit(CharityInitState());
      final secandTypeEither =
          await _charityRepository.getSecandTyp(event.firstType);

      emit(CharityLoadedSecandTypeState(items: secandTypeEither));
    });

    on<SelectSecandTypeEvent>((event, emit) {
      emit(CharitySelectedSecandTypeState());
    });

    on<GetPaymentUrlEvent>((event, emit) async {
      emit(CharityLoadingUrlState());
      IpaymentRepository paymentRepository = locator.get();
      final getUrl = await paymentRepository.getPaymentData(
          event.idType, event.amount, event.token);

      emit(CharityLoadedUrlState(getUrl));
    });
    on<OpenBrowserForPayEvent>((event, emit) async {
      IpaymentRepository paymentRepository = locator.get();
      final openBrowser =
          await paymentRepository.launchUrlForPayment(event.url);

      emit(CharityOpenBrowserState(openBrowser));
    });

    on<ShortcutEvent>((event, emit) {
      emit(CharityShortCutState(id: event.id, title: event.title));
    });
  }
}
