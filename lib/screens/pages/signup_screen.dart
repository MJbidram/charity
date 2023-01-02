import 'dart:convert';

import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:charity/screens/pages/login_screen.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/util/api_exception.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorText;
  List<RegisterErrorModel>? registerError;
  bool visibelCheckInformation = false;
  FocusNode focusNodeName = FocusNode();
  TextEditingController nameController = TextEditingController();
  String? name;
  FocusNode focusNodePhone = FocusNode();
  TextEditingController phoneController = TextEditingController();
  String? phone;
  FocusNode focusNodeEmail = FocusNode();
  TextEditingController emailController = TextEditingController();
  String? emailAddress;
  FocusNode focusNodePassword = FocusNode();
  TextEditingController passwordController = TextEditingController();
  String? password;
  FocusNode focusNodeConfirmPassword = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  String? configPassword;
  final String divaiceName = 'android';
  var box = Hive.box('information');
  // final storage = new FlutterSecureStorage();
  bool dontTapRegister = true;
  @override
  void initState() {
    // TODO: implement initState
    AuthManager.readauth();
    super.initState();
    focusNodeName.addListener(() {
      setState(() {});
    });
    focusNodePhone.addListener(() {
      setState(() {});
    });
    focusNodeEmail.addListener(() {
      setState(() {});
    });
    focusNodePassword.addListener(() {
      setState(() {});
    });
    focusNodeConfirmPassword.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var registererrors = AuthenticationRepository.registerErrorModel;
    List<String> registerTexterrors = [
      registererrors.name ?? '',
      registererrors.phone ?? '',
      registererrors.password ?? '',
      registererrors.email ?? '',
      registererrors.unknow ?? '',
    ];
    return ValueListenableBuilder(
      valueListenable: AuthManager.authChangeNotifire,
      builder: (context, value, child) {
        if (value == null || value.isEmpty) {
          print('$value');
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'ثبت نام',
                          style: TextStyle(
                              fontFamily: 'VB', fontSize: 18, color: blueDark),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _getTextfild(focusNodeName, 'نام', nameController,
                            TextInputType.name),
                        _getTextfild(focusNodePhone, 'شماره تلفن',
                            phoneController, TextInputType.number),
                        _getTextfild(focusNodeEmail, 'ایمیل (اختیاری)',
                            emailController, TextInputType.emailAddress),
                        _getTextfild(focusNodePassword, 'رمز عبور',
                            passwordController, TextInputType.visiblePassword),
                        _getTextfild(
                            focusNodeConfirmPassword,
                            'تکرار رمز عبور',
                            confirmPasswordController,
                            TextInputType.visiblePassword),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Visibility(
                              visible: visibelCheckInformation,
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: registerTexterrors.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      registerTexterrors[index],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'VM',
                                          fontSize: 14),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !dontTapRegister,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Visibility(
                          visible: dontTapRegister,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 24, right: 24, left: 24, bottom: 8),
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  dontTapRegister = false;
                                  visibelCheckInformation = false;
                                });
                                name = nameController.text.toString().trim();
                                phone = phoneController.text.toString().trim();
                                emailAddress =
                                    emailController.text.toString().trim();
                                password = passwordController.text.toString();
                                configPassword =
                                    confirmPasswordController.text.toString();

                                var either =
                                    await AuthenticationRepository().register(
                                  name!,
                                  phone!,
                                  emailAddress!,
                                  'android',
                                  password!,
                                  configPassword!,
                                );
                                either.fold((erroreMessage) {
                                  erroreMessage?.forEach((element) {
                                    if (element != null) {
                                      if (element.isNotEmpty) print(element);
                                    } else
                                      (print(''));
                                  });
                                  setState(() {
                                    visibelCheckInformation = true;
                                    dontTapRegister = true;
                                  });
                                }, (successMessage) => print(successMessage));
                              },
                              child: Text(
                                'ثبت نام',
                                style:
                                    TextStyle(fontSize: 16, fontFamily: 'VB'),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blueDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: dontTapRegister,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'قبلا ثبت نام کرده اید؟',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: 'VM'),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                }),
                                child: Text(
                                  ' ورود',
                                  style: TextStyle(
                                      color: blueDark,
                                      fontSize: 16,
                                      fontFamily: 'VM'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return MainScreen();
        }
      },
    );
  }

  Padding _getTextfild(
    FocusNode focusNode,
    String hintText,
    TextEditingController controller,
    TextInputType inputType,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: inputType,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'VM',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blueDark,
              width: 3,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          labelText: '  $hintText  ',
          labelStyle: TextStyle(
            fontFamily: 'VL',
            color: focusNode.hasFocus ? blueDark : Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNodeName.dispose();
    focusNodePhone.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    super.dispose();
  }
}
