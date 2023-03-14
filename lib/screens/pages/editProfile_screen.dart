import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charity/bloc/profile_edit_bloc/profile_edit_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/screens/widget/snakbar.dart';
import 'package:charity/screens/widget/spin_kit.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_edit_bloc/profile_edit_bloc.dart';
import '../../bloc/profile_edit_bloc/profile_edit_event.dart';
import '../widget/error_box.dart';

FocusNode _myFocusNodename = FocusNode();
FocusNode _myFocusNodeemail = FocusNode();
FocusNode _myFocusNodephone = FocusNode();
FocusNode _myFocusNodeaddress = FocusNode();

// FocusNode _myFocusNodeemail = FocusNode();

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? nameC;
  TextEditingController? phoneC;
  TextEditingController? emailC;
  TextEditingController? addressC;
  String name = '';
  String phone = '';
  String email = '';
  String address = '';
  @override
  void initState() {
    BlocProvider.of<PorfileEditBloc>(context).add(LoadDetailsProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PorfileEditBloc, ProfileEditState>(
      builder: (context, state) {
        if (state is PorfileEditInitState) {
          return const Center(child: MySpinKit());
        }
        if (state is ProfileLoadingState) {
          return const Center(child: MySpinKit());
        }
        if (state is ProfileEditLoadedState) {
          return state.response.fold((l) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              mySnackBar(
                context,
                l == ErrorsMessages.unAvailable ? l : 'خطا در برقراری ارتباط',
                onTap: () {
                  context
                      .read<PorfileEditBloc>()
                      .add(LoadDetailsProfileEvent());
                },
              );
            });

            return ErrorBox(
              errorMessage: l,
              onTap: () {
                context.read<PorfileEditBloc>().add(LoadDetailsProfileEvent());
              },
            );
          }, (r) {
            nameC = TextEditingController(text: r.name);
            phoneC = TextEditingController(text: r.phone);
            emailC = TextEditingController(text: r.email);

            addressC =
                TextEditingController(text: r.address ?? 'آدرسی ثبت نشده است');

            return CustomScrollView(
              slivers: [
                appBar(context),
                SliversInputText(
                    controller: nameC!,
                    focusNode: _myFocusNodename,
                    hint: '',
                    // initText: r.name,
                    lable: 'نام و نام خانوادگی',
                    maxLines: 1),
                SliversInputText(
                    controller: phoneC!,
                    focusNode: _myFocusNodephone,
                    hint: '',
                    // initText: r.phone,
                    lable: 'شماره تلفن',
                    maxLines: 1),
                SliversInputText(
                    controller: emailC!,
                    focusNode: _myFocusNodeemail,
                    hint: '',
                    // initText: r.email,
                    lable: 'ایمیل',
                    maxLines: 1),
                SliversInputText(
                    controller: addressC!,
                    focusNode: _myFocusNodeaddress,
                    hint: '',
                    // initText: r.address ?? 'آدرسی ثبت نشده است',
                    lable: 'آدرس',
                    maxLines: 4),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  sliver: SliverToBoxAdapter(
                    child: ElevatedButton(
                      onPressed: () {
                        if (r.address != addressC!.text) {
                          address = addressC!.text;
                        }
                        if (r.name != nameC!.text) {
                          name = nameC!.text;
                        }
                        if (r.email != emailC!.text) {
                          email = emailC!.text;
                        }
                        if (r.phone != phoneC!.text) {
                          phone = phoneC!.text;
                        }

                        context.read<PorfileEditBloc>().add(SetEditProfileEvent(
                              address: address,
                              email: email,
                              phone: phone,
                              username: name,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('ویرایش پروفایل'),
                    ),
                  ),
                )
              ],
            );
          });
        }
        if (state is ProfileEditSetCahngeState) {
          return state.response.fold((l) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              mySnackBar(
                context,
                l == ErrorsMessages.unAvailable
                    ? l
                    : 'ویرایش اطلاعات نا موفق بود',
                onTap: () {
                  context
                      .read<PorfileEditBloc>()
                      .add(LoadDetailsProfileEvent());
                },
              );
            });

            return ErrorBox(
              errorMessage: l,
              onTap: () {
                context.read<PorfileEditBloc>().add(LoadDetailsProfileEvent());
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
                          'اطلاعات شما با موفقیت تغییر یافت',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      title: 'عملیات موفقیت آمیز',
                      desc: 'اطلاعات شما با موفقیت تغییر یافت',
                      btnOkOnPress: () {
                        context
                            .read<PorfileEditBloc>()
                            .add(LoadDetailsProfileEvent());
                      },
                      btnOkText: 'فهمیدم')
                  .show();
            });
            return const Center();
          });
        } else {
          return const Center(
            child: Text('errore'),
          );
        }
      },
    ));
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      title: Text(shortName),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      pinned: false,
      expandedHeight: AppBar().preferredSize.height + 30,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: blueGradient,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width, 170),
            ),
          ),
        ),
      ),
    );
  }
}

class SliversInputText extends StatelessWidget {
  int maxLines;
  String hint;
  String lable;
  FocusNode focusNode;
  // String initText;
  TextEditingController controller;
  SliversInputText({
    required this.maxLines,
    required this.focusNode,
    required this.hint,
    required this.lable,
    // required this.initText,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverToBoxAdapter(
          child: CustomInputText(
        controller: controller,
        maxLines: maxLines,
        hint: hint,
        focusNode: focusNode,
        // initText: initText,
        lable: lable,
      )),
    );
  }
}

class CustomInputText extends StatelessWidget {
  int maxLines;
  String hint;
  String lable;
  FocusNode focusNode;
  // String initText;
  TextEditingController controller;
  CustomInputText(
      {Key? key,
      // required this.initText,
      required this.maxLines,
      required this.hint,
      required this.focusNode,
      required this.lable,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // initialValue: initText,
      maxLines: maxLines,
      validator: (value) {},
      focusNode: focusNode,

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

          // labelText: '${hint}',
          alignLabelWithHint: true,
          labelText: lable,
          labelStyle: TextStyle(
            fontFamily: 'GM',
            color: focusNode.hasFocus ? blueDark : Colors.grey,
            fontSize: 18,
          )),
    );
  }
}
