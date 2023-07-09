import 'package:charity/bloc/further_information_bloc/further_info_event.dart';
import 'package:charity/bloc/further_information_bloc/further_info_state.dart';
import 'package:charity/data/datasource/wearth_type_datasource.dart';
import 'package:charity/data/repository/creat_order_repository.dart';
import 'package:charity/data/repository/wearth_tarh_repository.dart';
import 'package:charity/data/repository/wearth_type_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class FurtherInfoBloc extends Bloc<FurtherInfoEvent, FurtherInfoState> {
  final IWearthTypeRepository wearthTypeDataSource = locator.get();
  final IWearthTarhRepository wearthTarhRepository = locator.get();
  final ICreatOrderRepositorey creatOrderRepositorey = locator.get();
  FurtherInfoBloc() : super(FurtherInfoInitState()) {
    on<GetFurtherInfoEvent>((event, emit) async {
      emit(LoadingFurtherInfoState());
      var wearthType = await wearthTypeDataSource.getWearthTypes();
      var wearthTarh = await wearthTarhRepository.getWearthTarhes();
      emit(FurtherInfoLoadedState(wearthType, wearthTarh));
    });

    on<CreatOrderEvent>((event, emit) async {
      var response = await creatOrderRepositorey.postOrder(
          event.name, event.marasem, event.type, event.tarh);

      response.fold((l) {}, (r) async {
        try {
          await launchUrl(Uri.parse(r.data.payData.url),
              mode: LaunchMode.externalNonBrowserApplication);
        } catch (e) {}
      });
    });
  }
}
