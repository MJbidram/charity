import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charity/bloc/damand_bloc/damand_bloc.dart';
import 'package:charity/bloc/damand_bloc/damand_event.dart';
import 'package:charity/bloc/damand_bloc/damand_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/damand_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/screens/widget/error_box.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/auth_manager.dart';
import '../widget/snakbar.dart';

FocusNode _myFocusNodeDetails = FocusNode();
FocusNode _myFocusNodeAddress = FocusNode();
List<DamandFirstTypeModel>? firstType;
List<DamandSecandTypeModel>? secandType;
String? myAddress;
bool isInitial = true;
bool isSecandTypeSelected = false;
String? _initialFirstType;
String selectType = '0';
TextEditingController detailsConroler = TextEditingController();
TextEditingController? addressControler;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class DamandScreen extends StatefulWidget {
  const DamandScreen({super.key});

  @override
  State<DamandScreen> createState() => _DamandScreenState();
}

class _DamandScreenState extends State<DamandScreen> {
  final IDamandRepository repository = locator.get();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DamandBloc>(context).add(GetDamandFirstTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child:
        // appBar(context),
        BlocBuilder<DamandBloc, DamandState>(
      builder: (context, state) {
        if (state is DamandInitState) {
          return const Center(
            child: MySpinKit(),
          );
        }
        if (state is DamandLoadingState) {
          return const Center(
            child: MySpinKit(),
          );
        }
        if (state is DamandLoadedFirstTypes) {
          return state.response.fold((l) {
            return ErrorBox(
              errorMessage: l,
              onTap: () {
                context.read<DamandBloc>().add(GetDamandFirstTypeEvent());
              },
            );
          }, (r) {
            return state.checkeAddress.fold((l) {
              return ErrorBox(
                errorMessage: l,
                onTap: () {
                  context.read<DamandBloc>().add(GetDamandFirstTypeEvent());
                },
              );
            }, (address) {
              addressControler = TextEditingController(text: address.address);
              context
                  .read<DamandBloc>()
                  .add(GetDamandSecandTypeEvent(r[0].id.toString()));
              firstType = [...r];
              _initialFirstType = r[0].title;
              if (address.address != null) {
                myAddress = address.address;

                return body(firstType, secandType, 1, address.address!);
              } else {
                return body(firstType, secandType, 1, '');
              }
            });
          });
        }
        if (state is DamandLoadedSecandTypes) {
          return state.response.fold((l) {
            return ErrorBox(
              errorMessage: l,
              onTap: () {
                context.read<DamandBloc>().add(GetDamandFirstTypeEvent());
              },
            );
          }, (r) {
            secandType = [...r];

            return body(firstType, secandType, 1, myAddress ?? '');

            //body(firstType, secandType, 2);
          });
        }
        if (state is DamandSendedState) {
          return state.response.fold((l) {
            return ErrorBox(
              errorMessage: l,
              onTap: () {
                context.read<DamandBloc>().add(GetDamandFirstTypeEvent());
              },
            );
          }, (r) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.success,
                      body: const Center(
                        child: Text(
                          'درخواست شمابا موفقیت ثبت شد. میتوانید از بخش حساب کاربری وضعیت درخواست خود را مشاهده کنید',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      title: r,
                      desc: '',
                      btnOkOnPress: () {
                        context
                            .read<DamandBloc>()
                            .add(GetDamandFirstTypeEvent());
                      },
                      btnOkText: 'فهمیدم')
                  .show();
            });
            return Text('ثبت درخواست موفقیت آمیز بود');
            //body(firstType, secandType, 2);
          });
        } else {
          return ErrorBox(
            errorMessage: 'خطایی رخ داده است',
            onTap: () {
              context.read<DamandBloc>().add(GetDamandFirstTypeEvent());
            },
          );
        }
      },
    )));
  }

  Widget body(List<DamandFirstTypeModel>? first,
      List<DamandSecandTypeModel>? secand, int state, String address) {
    return CustomScrollView(
      slivers: [
        appBar(context),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text('انتخاب نوع درخواست :'),
          ),
        ),
        SliverPadding(
            padding: const EdgeInsets.only(bottom: 8, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  // label: Text('data'),

                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'صندوق صدقات',
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
                items: first == null
                    ? []
                    : first
                        .map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                validator: (value) {},
                // value: first == null ? [] : first[0].id,

                onChanged: (value) {
                  print(value);
                  isInitial = false;
                  selectType = value.toString();
                  context
                      .read<DamandBloc>()
                      .add(GetDamandSecandTypeEvent(value.toString()));
                },
                onSaved: (value) {},
              ),
            )),
        const SliverPadding(
            padding: EdgeInsets.only(bottom: 8, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Text('انتخاب جزئی تر درخواست'),
            )),
        SliverPadding(
            padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  // label: Text('data'),

                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  // items?[hint!] ?? 'انتخاب',
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
                items: secand == null
                    ? []
                    : secand
                        .map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                validator: (value) {},
                onChanged: (value) {
                  selectType = value.toString();
                  isInitial = false;
                  isSecandTypeSelected = true;
                  print(value);
                },
                onSaved: (value) {},
              ),
            )),
        SliverPadding(
            padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: TextFormField(
                  controller: detailsConroler,
                  maxLines: 5,
                  validator: (value) {},
                  focusNode: _myFocusNodeDetails,
                  style: TextStyle(
                    color: blueDark,
                    fontFamily: 'GM',
                    fontSize: 16,
                  ),
                  onChanged: (value) {},
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: blueDark,
                          width: 3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      // label: Align(
                      //   alignment: AlignmentDirectional.topCenter,
                      //   child: Text('تست'),
                      // ),
                      labelText: '  ${'توضیحات'}   ',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        fontFamily: 'GM',
                        color: _myFocusNodeDetails.hasFocus
                            ? blueDark
                            : Colors.grey,
                        fontSize: 18,
                      ))),
            )),
        SliverPadding(
            padding: EdgeInsets.only(bottom: 8, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: TextFormField(
                    controller: addressControler,
                    maxLines: 4,
                    validator: (value) {
                      if (addressControler == null ||
                          addressControler!.text.isEmpty) {
                        print('object');
                        return 'لطفا آدرس را وارد کنید';
                      }
                    },
                    focusNode: _myFocusNodeAddress,
                    style: TextStyle(
                      color: blueDark,
                      fontFamily: 'GM',
                      fontSize: 16,
                    ),
                    onChanged: (value) {},
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: blueDark,
                            width: 3,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: '  ${'آدرس'}   ',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          fontFamily: 'GM',
                          color: _myFocusNodeAddress.hasFocus
                              ? blueDark
                              : Colors.grey,
                          fontSize: 18,
                        ))),
              ),
            )),
        SliverPadding(
            padding: EdgeInsets.only(bottom: 72, right: 32, left: 32, top: 24),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      myAddress = addressControler!.text;
                      if (isInitial) {
                        print('init');
                        context.read<DamandBloc>().add(
                              SendDamandEvent(
                                address: addressControler!.text,
                                details: detailsConroler.text,
                                type: first![0].id.toString(),
                              ),
                            );
                      } else {
                        if (isSecandTypeSelected) {
                          print(isSecandTypeSelected);
                          secand!.forEach((element) {
                            if (element.id == int.parse(selectType)) {
                              print('sec');

                              context.read<DamandBloc>().add(
                                    SendDamandEvent(
                                      address: addressControler!.text,
                                      details: detailsConroler.text,
                                      type: element.id.toString(),
                                    ),
                                  );
                            }
                          });
                        } else {
                          print(isSecandTypeSelected);
                          first!.forEach((element) {
                            if (element.id == int.parse(selectType)) {
                              print('frs');

                              context.read<DamandBloc>().add(
                                    SendDamandEvent(
                                      address: addressControler!.text,
                                      details: detailsConroler.text,
                                      type: element.id.toString(),
                                    ),
                                  );
                            }
                          });
                        }
                      }
                      // if(state==1){context.read<DamandBloc>().add(SendDamandEvent(address: myAddress??'',details: details,type: damandIdFirst!));}

                    }
                  },
                  child: Text('ارسال درخواست'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      title: Text(shortName),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      pinned: false,
      expandedHeight: AppBar().preferredSize.height + 70,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              height: AppBar().preferredSize.height + 40,
              decoration: BoxDecoration(
                gradient: blueGradient,
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 150),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
