import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/aboutus_bloc/aboutus_bloc.dart';
import '../bloc/details_of_sliders/details_bloc.dart';
import '../bloc/factors_bloc/factors_bloc.dart';
import '../screens/pages/aboutus_screen.dart';
import '../screens/pages/charity_screen.dart';
import '../screens/pages/factors_screen.dart';
import '../screens/pages/main_screen.dart';
import '../screens/pages/news_screen.dart';
import '../screens/pages/show_details_of_slider_screen.dart';
import '../screens/pages/wreath_screens/reserve_wreath_screen.dart';
import '../screens/widget/image_slider.dart';

class ManageHomeItems {
  Map<String, dynamic> items;
  BuildContext context;
  ManageHomeItems(this.items, this.context);

  void decoder() {
    final ItemManagerModel itemModel = ItemManagerModel.fromJsonMap(items);
    final Myfn myfn = Myfn();

    if (itemModel.fnName == 'openPayment') {
      final String payType = itemModel.params['type'];
      final String payTitle = itemModel.params['title'];
      myfn.openPayment(type: payType, title: payTitle, context: context);
    }
    if (itemModel.fnName == 'openMyUrl') {
      final String url = itemModel.params['url'];
      myfn.openMyUrl(url);
    }
    if (itemModel.fnName == 'openPost') {
      final String id = itemModel.params['id'];
      myfn.openPost(id, context);
    }
    if (itemModel.fnName == 'openPaymentList') {
      myfn.openPaymentList(context);
    }
    if (itemModel.fnName == 'openAboutUs') {
      myfn.openAboutUs(context);
    }
    if (itemModel.fnName == 'openproject') {
      final int id = itemModel.params['id'];
      myfn.openproject(id, context);
    }
    if (itemModel.fnName == 'openpooyesh') {
      final int id = itemModel.params['id'];
      myfn.openpooyesh(id, context);
    }
    if (itemModel.fnName == 'taj') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReserveWreathScreen(),
      ));
    }
  }
}

class ItemManagerModel {
  final String fnName;
  final Map params;
  ItemManagerModel({required this.fnName, required this.params});
  factory ItemManagerModel.fromJsonMap(Map<String, dynamic> jsonObject) {
    return ItemManagerModel(
        fnName: jsonObject['fnName'], params: jsonObject['params']);
  }
}

class Myfn {
  Future<Either<String, String>> openMyUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
      return right('عملیات موفقیت آمیز');
    } catch (e) {
      return left('خطا در باز کردن مرورگر');
    }
  }

  static bool isDarkhastHasType = false;

  void openDamand({
    required String type,
    required String title,
    required BuildContext context,
  }) {
    if (type != '0') {
      isDarkhastHasType = true;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharityPage(id: int.parse(type), title: title),
      ),
    );
  }

  void openPayment(
      {required String type,
      required String title,
      required BuildContext context}) {
    if (type != '0') {
      ImageSliderScreen.goToShortcut.value = true;
    }
    ImageSliderScreen.id = int.parse(type);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CharityPage(id: int.parse(type), title: title),
        ));
  }

  void openDialog(
      BuildContext context, String btnOkText, String btnCanselText) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: const Center(
            child: Text(
              'hello',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkText: btnOkText,
          btnOkOnPress: () {},
          btnCancelText: btnCanselText,
          btnCancelOnPress: () {},
        ).show();
      },
    );
  }

  void openPost(String id, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsScreen(
          newsindex: int.parse(id),
        ),
      ),
    );
  }

  void openPaymentList(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => FactorsBloc(),
        child: const FactorsScreen(),
      );
    }));
  }

  void openAboutUs(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => AboutUsBloc(),
        child: const AboutUsScreen(),
      );
    }));
  }

  void openproject(int id, BuildContext context) {
    MainScreen.isPooyeshSelected = false;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => DetailSliderBloc(),
          child: ShowDetailsOfSliderScreen(detailsId: id),
        );
      },
    ));
  }

  void openpooyesh(int id, BuildContext context) {
    MainScreen.isPooyeshSelected = true;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => DetailSliderBloc(),
          child: ShowDetailsOfSliderScreen(detailsId: id),
        );
      },
    ));
  }
}
