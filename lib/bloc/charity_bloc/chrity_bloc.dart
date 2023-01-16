import 'package:charity/bloc/charity_bloc/charity_event.dart';
import 'package:charity/bloc/charity_bloc/charity_state.dart';
import 'package:charity/data/repository/charity_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/payment_repository.dart';

class CharityBloc extends Bloc<CharityEvent, CharityState> {
  final MyCharityRepository _charityRepository = locator.get();
  CharityBloc() : super(CharityLoadingFirstTypeState()) {
    on<LoadFirstTypeEvent>((event, emit) async {
      final firstTypeEither = await _charityRepository.getFirstTyp();
      firstTypeEither.fold(
          (l) => emit(CharityExseptionLoadedFirstTypeState(exseption: l)),
          (r) => emit(CharityLoadedFirstTypeState(items: r!)));
    });

    on<LoadSecandTypeEvent>((event, emit) async {
      emit(CharityLoadingSecandTypeState());
      final secandTypeEither =
          await _charityRepository.getSecandTyp(event.firstType);
      secandTypeEither.fold(
          (l) => emit(CharityExseptionLoadedSecandTypeState(exseption: l)),
          (r) => emit(CharityLoadedSecandTypeState(item: r!)));
    });

    on<GetPaymentUrlEvent>((event, emit) async {
      emit(CharityLoadingUrlState());
      IpaymentRepository paymentRepository = locator.get();
      final getUrl = await paymentRepository.getPaymentData(
          event.idType, event.amount, event.token);
      getUrl.fold((l) => emit(CharityExseptionLoadingUrlState(exeption: l)),
          (r) {
        emit(CharityLoadedUrlState(payLinkModel: r));
        print(r);
      });
    });
    on<OpenBrowserForPayEvent>((event, emit) async {
      IpaymentRepository paymentRepository = locator.get();
      final openBrowser =
          await paymentRepository.launchUrlForPayment(event.url);
      openBrowser.fold((l) => emit(CharityExseptionOpenBrowserState(l)),
          (r) => emit(CharityOpenBrowserState()));
    });

    on<ShortcutEvent>((event, emit) {
      emit(CharityShortCutState(id: event.id, title: event.title));
    });
  }
}
