import 'package:charity/bloc/damand_bloc/damand_bloc.dart';
import 'package:charity/bloc/damand_bloc/damand_event.dart';
import 'package:charity/bloc/damand_bloc/damand_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/damand_repository.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/auth_manager.dart';

FocusNode _myFocusNodeDetails = FocusNode();
FocusNode _myFocusNodeAddress = FocusNode();
List<DamandFirstTypeModel>? firstType;
List<DamandSecandTypeModel>? secandType;

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
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        // appBar(context),
        BlocBuilder<DamandBloc, DamandState>(
          builder: (context, state) {
            if (state is DamandInitState) {
              return const Center(
                child: MySpinKit(),
              );
            }
            if (state is DamandLoadedFirstTypes) {
              return state.response.fold((l) {
                return Text(l);
              }, (r) {
                firstType = []..addAll(r);

                print(firstType);
                return body(firstType, [], 1);
              });
            }
            if (state is DamandLoadedSecandTypes) {
              return state.response.fold((l) {
                return body(firstType, secandType, 3);
              }, (r) {
                return body(firstType, secandType, 2);
              });
            }
            if (state is DamandSendedState) {
              return state.response.fold((l) {
                return Center(
                  child: Text('خطا'),
                );
              }, (r) {
                return body(firstType, secandType, 2);
              });
            } else {
              return Center(
                  child: (Container(
                child: Text('خطا در دریافت اطلاعات'),
              )));
            }
          },
        )
      ]),
    ));
  }

  SingleChildScrollView body(List<DamandFirstTypeModel>? first,
      List<DamandSecandTypeModel>? secand, int type) {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('انتخاب نوع درخواست :'),
              const SizedBox(
                height: 8,
              ),
              DropDownDamand<DamandFirstTypeModel>(
                  itemForHint: 0, items: first, type: type),
              const SizedBox(
                height: 8,
              ),
              Text('انتخاب جزئی تر درخواست'),
              const SizedBox(
                height: 8,
              ),
              DropDownDamand<DamandSecandTypeModel>(
                itemForHint: 2,
                items: secand,
                type: type,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomInputText(
                maxLines: 6,
                hint: 'توضیحات',
                focusNode: _myFocusNodeDetails,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomInputText(
                maxLines: 4,
                hint: 'آدرس',
                focusNode: _myFocusNodeAddress,
              ),
              SizedBox(
                height: 18,
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('ارسال درخواست'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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

class CustomInputText extends StatelessWidget {
  int maxLines;
  String hint;
  FocusNode focusNode;
  CustomInputText(
      {Key? key,
      required this.maxLines,
      required this.hint,
      required this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: (value) {},
      focusNode: focusNode,
      keyboardType: TextInputType.number,
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
          // label: Align(
          //   alignment: AlignmentDirectional.topCenter,
          //   child: Text('تست'),
          // ),
          labelText: '  ${hint}   ',
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            fontFamily: 'GM',
            color: focusNode.hasFocus ? blueDark : Colors.grey,
            fontSize: 18,
          )),
    );
  }
}

class DropDownDamand<T> extends StatefulWidget {
  List<T>? items;
  int itemForHint;
  int type = 1;
  DropDownDamand(
      {super.key,
      required this.items,
      required this.itemForHint,
      required this.type});

  @override
  State<DropDownDamand> createState() => _DropDownDamandState();
}

class _DropDownDamandState extends State<DropDownDamand> {
  List<dynamic>? items;
  int? hint;
  int? type;
  @override
  void initState() {
    items = widget.items;
    hint = widget.itemForHint;
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      items: items == null
          ? []
          : items!
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
        print(value);
        if (type == 1) {
          context
              .read<DamandBloc>()
              .add(GetDamandSecandTypeEvent(value.toString()));
        }
      },
      onSaved: (value) {},
    );
  }
}
