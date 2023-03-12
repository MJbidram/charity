import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charity/bloc/charity_bloc/charity_event.dart';
import 'package:charity/bloc/charity_bloc/charity_state.dart';
import 'package:charity/bloc/charity_bloc/chrity_bloc.dart';
import 'package:charity/constants/constants.dart';

import 'package:charity/data/repository/charity_repository.dart';
import 'package:charity/data/repository/payment_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:charity/screens/widget/category_amunt_used.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:charity/screens/widget/image_slider.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:digit_to_persian_word/digit_to_persian_word.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../widget/category_items.dart';

String? selectedValue;
String? firstTypeDescription;
String? secandTypeDescription;
TextEditingController amount = TextEditingController();

class CharityPage extends StatefulWidget {
  int id;
  String title;
  CharityPage({super.key, required this.id, required this.title});

  @override
  State<CharityPage> createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  FocusNode _myFocusNode1 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String firstType = '';
  // String secandType = '';
  List<CharityModelFirst>? firstType;
  List<CharityModelSecand>? secandType;
  int? needSecandType;
  int? needFirstType;
  String? idType;
  // final _firstBox = Hive.box<CharityModelFirst>('ModelFirst');
  // final _secandBox = Hive.box<CharityModelSecand>('ModelSecand');
  final _box = Hive.box('information');
  // List<CharityModelFirst>? firstBoxList;
  // List<CharityModelSecand>? secandBoxList;

  int? shortcutId;
  String? shortcutTitle;
  @override
  initState() {
    // TODO: implement initState

    super.initState();
    shortcutId = widget.id;
    shortcutTitle = widget.title;
    _myFocusNode1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ImageSliderScreen.goToShortcut.value == true) {
      return BlocProvider(
        create: (context) => CharityBloc()
          ..add(
            ShortcutEvent(id: shortcutId!, title: shortcutTitle!),
          ),
        child: bodey(context),
      );
    } else {
      return BlocProvider(
        create: (context) => CharityBloc()
          ..add(
            LoadFirstTypeEvent(),
          ),
        child: bodey(context),
      );
    }
  }

  Directionality bodey(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: grey,
        //app bar
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 60,
            title: Text(
              shortName,
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  size: 32,
                ),
              ),
            ],
            backgroundColor: grey,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: blueGradient,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 170),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: blueGradient,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 170),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 170),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 170),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(child: _getCharityPageBody(context)),

        // ),
      ),
    );
  }

  Widget _getCharityPageBody(BuildContext context) {
    // List<CharityModelFirst>? itemsCharityFirst;
    // List<CharityModelSecand>? itemsCharitySecand;
    String url;
    int paymentFactor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: Text('پرداخت و نیکو کاری',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'VB',
                      fontSize: 18,
                      color: blueDark,
                    )),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text('تعیین مبلغ'),
            const SizedBox(
              height: 16,
            ),
            amountTextFild(),
            const SizedBox(
              width: double.infinity,
              height: 16,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Wrap(
                spacing: 10,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  AmountUsed(
                    amountText: '۵,۰۰۰',
                    amountValue: '5,000',
                    onTap: () {
                      setState(() {
                        amount.text = '5,000';
                      });
                      !_formKey.currentState!.validate();
                    },
                  ),
                  AmountUsed(
                    amountText: '۱۰,۰۰۰',
                    amountValue: '10,000',
                    onTap: () {
                      setState(() {
                        amount.text = '10,000';
                      });
                      !_formKey.currentState!.validate();
                    },
                  ),
                  AmountUsed(
                    amountText: '۲۰,۰۰۰',
                    amountValue: '20,000',
                    onTap: () {
                      setState(() {
                        amount.text = '20,000';
                      });
                      !_formKey.currentState!.validate();
                    },
                  ),
                  AmountUsed(
                    amountText: '۵۰,۰۰۰',
                    amountValue: '50,000',
                    onTap: () {
                      setState(() {
                        amount.text = '50,000';
                      });
                      !_formKey.currentState!.validate();
                    },
                  ),
                  AmountUsed(
                    amountText: '۱۰۰,۰۰۰',
                    amountValue: '100,000',
                    onTap: () {
                      setState(() {
                        amount.text = '100,000';
                      });
                      !_formKey.currentState!.validate();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'نوع و موارد مصرف:',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<CharityBloc, CharityState>(builder: (context, state) {
              if (state is CharityInitState) {
                return MySpinKit();
              }
              if (state is CharityLoadedFirstTypeState) {
                return state.items.fold((l) {
                  return Center(
                    child: ErrorBox(
                      errorMessage: l,
                      onTap: () {
                        context.read<CharityBloc>().add(LoadFirstTypeEvent());
                      },
                    ),
                  );
                }, (r) {
                  firstType = [...r];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDropDownFildFirest(context, firstType, secandType),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(firstTypeDescription ?? ''),

                      const SizedBox(
                        height: 16,
                      ),
                      // Text(
                      //   'انتخاب نوع جزئی تر:',
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // DropdownButtonFormField2(
                      //     decoration: InputDecoration(
                      //       // label: Text('data'),

                      //       isDense: true,
                      //       contentPadding: EdgeInsets.zero,
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //     isExpanded: true,
                      //     hint: const Text(
                      //       'ابتدا نوع و موارد مصرف را انتخاب کنید',
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //     icon: const Icon(
                      //       Icons.arrow_drop_down,
                      //       color: Colors.black45,
                      //     ),
                      //     dropdownMaxHeight: 200,
                      //     iconSize: 30,
                      //     buttonHeight: 50,
                      //     buttonPadding:
                      //         const EdgeInsets.only(left: 20, right: 10),
                      //     dropdownDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     items: []),
                      // const SizedBox(
                      //   height: 32,
                      // ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            PayLinkModel? payLinkModel;
                            String _amount =
                                amount.text.toString().replaceAll(',', '');
                            print(_amount);
                            _amount = removeZero(_amount);
                            String? token = await AuthManager.readauth();

                            context.read<CharityBloc>().add(GetPaymentUrlEvent(
                                idType: idType!,
                                amount: _amount,
                                token: token!));
                            // IpaymentRepository paymentRepository = locator.get();

                            // var either = await paymentRepository.getPaymentData(
                            //     idType!, _amount, token!);
                            // either.fold((l) => print(l), (r) async {
                            //   payLinkModel = r;
                            //   await _box.put('factorId', r.faktoorId);
                            //   var either2 =
                            //       await paymentRepository.launchUrlForPayment(r.url);
                            //   either2.fold((l) => print(l), (r) => print(r));
                            // });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'انتقال به صفحه پرداخت',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.payment,
                                  size: 24,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  );
                });
              }
              if (state is CharityLoadedSecandTypeState) {
                // if (_secandBox.isEmpty) {
                // for (var i = 0; i < state.item.length; i++) {
                //   // _secandBox.add(state.item[i]);
                //   _secandBox.put(i, state.item[i]);
                // }
                // // }

                // for (var i = 0; i < _secandBox.values.length; i++) {
                //   secandBoxList = _secandBox.values.toList();
                // }
                // itemsCharitySecand = state.item;

                return state.items.fold((l) {
                  return Center(
                    child: ErrorBox(
                      errorMessage: l,
                      onTap: () {
                        context.read<CharityBloc>().add(LoadFirstTypeEvent());
                      },
                    ),
                  );
                }, (r) {
                  secandType = [...r];
                  return ImageSliderScreen.goToShortcut.value
                      ? shortcutPayPooyesh(context)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getDropDownFildFirest(
                                context, firstType, secandType),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(firstTypeDescription ?? ''),
                            const SizedBox(
                              height: 16,
                            ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : Text(
                                    'انتخاب نوع جزئی تر:',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : const SizedBox(
                                    height: 16,
                                  ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : _getDropDownFildsecand(
                                    context, firstType, secandType),
                            const SizedBox(
                              height: 4,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blueDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  PayLinkModel? payLinkModel;
                                  String _amount = amount.text.toString();
                                  _amount = _amount.replaceAll(',', '');
                                  print(_amount);
                                  _amount = removeZero(_amount);
                                  String? token = await AuthManager.readauth();

                                  context.read<CharityBloc>().add(
                                      GetPaymentUrlEvent(
                                          idType: idType!,
                                          amount: _amount,
                                          token: token!));
                                  // IpaymentRepository paymentRepository = locator.get();

                                  // var either = await paymentRepository.getPaymentData(
                                  //     idType!, _amount, token!);
                                  // either.fold((l) => print(l), (r) async {
                                  //   payLinkModel = r;
                                  //   await _box.put('factorId', r.faktoorId);
                                  //   var either2 =
                                  //       await paymentRepository.launchUrlForPayment(r.url);
                                  //   either2.fold((l) => print(l), (r) => print(r));
                                  // });
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'انتقال به صفحه پرداخت',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Icon(
                                        Icons.payment,
                                        size: 24,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        );
                });

                //
              }
              if (state is CharitySelectedSecandTypeState) {
                return ImageSliderScreen.goToShortcut.value
                    ? shortcutPayPooyesh(context)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getDropDownFildFirest(
                              context, firstType, secandType),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(firstTypeDescription ?? ''),
                          const SizedBox(
                            height: 16,
                          ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : Text(
                                  'انتخاب نوع جزئی تر:',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : const SizedBox(
                                  height: 16,
                                ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : _getDropDownFildsecand(
                                  context, firstType, secandType),
                          const SizedBox(
                            height: 4,
                          ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : Text(secandTypeDescription ?? ''),
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blueDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                PayLinkModel? payLinkModel;
                                String _amount = amount.text.toString();
                                _amount = _amount.replaceAll(',', '');
                                print(_amount);
                                _amount = removeZero(_amount);
                                String? token = await AuthManager.readauth();

                                context.read<CharityBloc>().add(
                                    GetPaymentUrlEvent(
                                        idType: idType!,
                                        amount: _amount,
                                        token: token!));
                                // IpaymentRepository paymentRepository = locator.get();

                                // var either = await paymentRepository.getPaymentData(
                                //     idType!, _amount, token!);
                                // either.fold((l) => print(l), (r) async {
                                //   payLinkModel = r;
                                //   await _box.put('factorId', r.faktoorId);
                                //   var either2 =
                                //       await paymentRepository.launchUrlForPayment(r.url);
                                //   either2.fold((l) => print(l), (r) => print(r));
                                // });
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'انتقال به صفحه پرداخت',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.payment,
                                      size: 24,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      );
              }

              //

              if (state is CharityLoadingUrlState) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.info,
                    body: const Center(
                      child: Text(
                        'درحال ارسال درخواست ...\n پس از عملیات پرداخت میتوانید از قسمت پروفایل کاربری فاتور پرداخت را مشاهده کنید',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    title: 'This is Ignored',
                    desc: 'This is also Ignored',
                    btnOkOnPress: () {},
                  ).show();
                });

                return ImageSliderScreen.goToShortcut.value
                    ? shortcutPayPooyesh(context)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageSliderScreen.goToShortcut.value
                              ? shortcutPayPooyesh(context)
                              : _getDropDownFildFirest(
                                  context, firstType, secandType),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(firstTypeDescription ?? ''),
                          const SizedBox(
                            height: 16,
                          ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : Text(
                                  'انتخاب نوع جزئی تر:',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : const SizedBox(
                                  height: 16,
                                ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : _getDropDownFildsecand(
                                  context, firstType, secandType),
                          const SizedBox(
                            height: 4,
                          ),
                          secandType?.length == 0
                              ? const SizedBox(
                                  height: 1,
                                )
                              : Text(secandTypeDescription ?? ''),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blueDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () async {},
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'انتقال به صفحه پرداخت',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.payment,
                                      size: 24,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      );
              }
              if (state is CharityLoadedUrlState) {
                return state.response.fold((l) {
                  return Center(
                    child: ErrorBox(
                      errorMessage: l,
                      onTap: () {
                        context.read<CharityBloc>().add(LoadFirstTypeEvent());
                      },
                    ),
                  );
                }, (r) {
                  url = r.url;
                  paymentFactor = r.faktoorId;
                  _box.put('factorId', paymentFactor);
                  context
                      .read<CharityBloc>()
                      .add(OpenBrowserForPayEvent(url: url));

                  return ImageSliderScreen.goToShortcut.value
                      ? shortcutPayPooyesh(context)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getDropDownFildFirest(
                                context, firstType, secandType),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(firstTypeDescription ?? ''),
                            const SizedBox(
                              height: 16,
                            ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : Text(
                                    'انتخاب نوع جزئی تر:',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : const SizedBox(
                                    height: 16,
                                  ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : _getDropDownFildsecand(
                                    context, firstType, secandType),
                            const SizedBox(
                              height: 4,
                            ),
                            secandType?.length == 0
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : Text(secandTypeDescription ?? ''),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blueDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () async {},
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'انتقال به صفحه پرداخت',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Icon(
                                        Icons.payment,
                                        size: 24,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        );
                });
              }
              if (state is CharityShortCutState) {
                needFirstType = 1;
                needSecandType = 1;
                return shortcutPayPooyesh(context);
              }
              if (state is CharityOpenBrowserState) {
                return state.response.fold((l) {
                  return Center(
                    child: ErrorBox(
                      errorMessage: l,
                      onTap: () {
                        context.read<CharityBloc>().add(LoadFirstTypeEvent());
                      },
                    ),
                  );
                }, (r) {
                  context.read<CharityBloc>().add(LoadFirstTypeEvent());
                  return const Center(
                    child: MySpinKit(),
                  );
                });
              } else {
                return Center(
                  child: ErrorBox(
                    errorMessage: 'خطای ناشناخته',
                    onTap: () {
                      context.read<CharityBloc>().add(LoadFirstTypeEvent());
                    },
                  ),
                );
              }
            }),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  shortcutPayPooyesh(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          // height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(shortcutTitle!),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: blueDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              PayLinkModel? payLinkModel;
              String _amount = amount.text.toString();
              _amount = _amount.replaceAll(',', '');
              print(_amount);
              _amount = removeZero(_amount);
              String? token = await AuthManager.readauth();

              context.read<CharityBloc>().add(GetPaymentUrlEvent(
                  idType: ImageSliderScreen.id!.toString(),
                  amount: _amount,
                  token: token!));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'انتقال به صفحه پرداخت',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.payment,
                size: 24,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget amountTextFild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        validator: (value) {
          if (value != null) {
            value = removeZero(value);
          }
          if (value!.length >= 4 &&
              !value.contains('.') &&
              !value.contains('-')) {
            return null;
          } else if (value.isNotEmpty && value.length < 4) {
            return 'مقدار وارد شده کم تر از حد مجاز است!';
          } else if (value.contains('.') || value.contains('-')) {
            return 'مبلغ مجاز نیست';
          } else {
            return 'ابتدا مبلغ را وارد کنید';
          }
        },
        controller: amount,
        focusNode: _myFocusNode1,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'GM',
          fontSize: 16,
        ),
        inputFormatters: [DigitInputFormat()],
        onChanged: (value) {
          !_formKey.currentState!.validate();
          String val = value.toString();
          val.toPersianDigit().seRagham();
          setState(() {
            value = val;
          });
        },
        decoration: InputDecoration(
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: blueDark,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            labelText: '  مبلغ (تومان)  ',
            labelStyle: TextStyle(
              fontFamily: 'GM',
              color: _myFocusNode1.hasFocus ? blueDark : Colors.grey,
              fontSize: 18,
            )),
      ),
    );
  }

  Widget _getDropDownFildFirest(
      BuildContext context,
      List<CharityModelFirst>? firstType,
      List<CharityModelSecand>? secandType) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        // label: Text('data'),

        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'انتخاب',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      dropdownMaxHeight: 200,
      iconSize: 30,
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: firstType == null
          ? []
          : firstType
              .map((item) => DropdownMenuItem<String>(
                    value: item.id!.toString(),
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
      validator: (value) {
        if (value == null) {
          return 'لطفا نوع صدقه خود را انتخاب کنید';
        }
        if (needFirstType == 0) {
          return 'لطفا نوع صدقه خود را انتخاب کنید';
        }
      },
      onChanged: (value) {
        List<CharityModelFirst> listSelect = [];
        listSelect = firstType!.where((element) {
          return element.id.toString().contains(value.toString());
        }).toList();
        needSecandType = listSelect[0].optionalSubSelect ?? 1;
        firstTypeDescription = listSelect[0].description ?? '';
        // print(des);
        // print('needSecandType' + needSecandType.toString());
        !_formKey.currentState!.validate();
        if (needSecandType == 1) {
          idType = value.toString();
        }
        context
            .read<CharityBloc>()
            .add(LoadSecandTypeEvent(firstType: value.toString()));
        // setState(() {
        //   // _getSecandTyps(value);

        // });
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  Widget _getDropDownFildsecand(
      BuildContext context,
      List<CharityModelFirst>? firstType,
      List<CharityModelSecand>? secandType) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        // label: Text('data'),

        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'انتخاب',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      dropdownMaxHeight: 200,
      iconSize: 30,
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: secandType == null
          ? []
          : secandType
              .map((item) => DropdownMenuItem<String>(
                    value: item.id!.toString(),
                    child: Text(
                      item.title!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
      validator: (value) {
        if (value == null && needSecandType == 0) {
          return 'لطفا نوع جزئی تر را انتخاب کنید';
        }
      },
      onChanged: (value) {
        secandTypeDescription = '';
        !_formKey.currentState!.validate();
        idType = value.toString();
        // secandTypeDescription =
        //     secandType?[int.parse(value.toString())].description ??
        //         'توضیحاتی ندارد';

        // print(secandTypeDescription);
        List<CharityModelSecand> listSelectsecand = [];
        listSelectsecand = secandType!.where((element) {
          return element.id.toString().contains(value.toString());
        }).toList();
        secandTypeDescription = listSelectsecand[0].description;
        context.read<CharityBloc>().add(SelectSecandTypeEvent());
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }

  @override
  void dispose() {
    ImageSliderScreen.goToShortcut.value = false;
    _myFocusNode1.dispose();

    super.dispose();
  }
}

String removeZero(String num) {
  for (var i = 0; i < num.length; i++) {
    if (num[i] != '0') {
      String res = num.substring(i);
      print(res);
      return res;
    }
  }

  return '0';
}
