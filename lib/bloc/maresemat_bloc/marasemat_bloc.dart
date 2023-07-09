import 'package:charity/bloc/maresemat_bloc/marasemat_event.dart';
import 'package:charity/bloc/maresemat_bloc/marasemat_state.dart';
import 'package:charity/data/repository/marasemat_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarasematBloc extends Bloc<MarasematEvent, MarasematState> {
  final IMarasematRepository _repository = locator.get();
  MarasematBloc() : super(MarasematInitState()) {
    on<GetMarasematEvent>((event, emit) async {
      emit(LoadingMarasemState());
      var response = await _repository.getMarasemat();
      emit(MarasematLoadedState(response));
    });
    // on<filterOnMarasemat>((event, emit) async {
    //   emit(LoadingMarasemState());

    //   var response = await _repository.getMarasemat();
    //   response.fold((l) {}, (r) {

    //   });
    //   var searched;
    //   if (event.search.isEmpty) {
    //     searched = response;
    //   }
    //   searched = response.where((element) {
    //     return element.marhoomName.toLowerCase().contains(value.toLowerCase());
    //   }).toList();
    //   setState(() {
    //     marasemat = marasemsearch;
    //     print(marasemat);
    //   });
    //   emit(MarasematLoadedState(response));
    // });
  }
}
