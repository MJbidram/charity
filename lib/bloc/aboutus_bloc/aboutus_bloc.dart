import 'package:charity/bloc/aboutus_bloc/aboutus_event.dart';
import 'package:charity/bloc/aboutus_bloc/aboutus_state.dart';
import 'package:charity/data/repository/aboutus_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final IAboutUsRepository _repository = locator.get();
  AboutUsBloc() : super(AboutUsInitState()) {
    on<AboutUsLoadEvent>((event, emit) async {
      emit(AboutUsInitState());
      var response = await _repository.getAboutUs();
      emit(AboutUsLoadedState(response));
    });
  }
}
