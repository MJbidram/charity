import 'package:charity/constants/constants.dart';

import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/signup_screen.dart';
import 'package:charity/util/api_exception.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/repository/authentication_repository.dart';
import '../../util/auth_manager.dart';
import '../widget/spin_kit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorText;
  bool visibelCheckInformation = false;
  String? name;
  FocusNode focusNodePhone = FocusNode();
  TextEditingController phoneController = TextEditingController();
  String? phone;

  String? emailAddress;
  FocusNode focusNodePassword = FocusNode();
  TextEditingController passwordController = TextEditingController();
  String? password;

  final String divaiceName = 'android';

  bool dontClickLogin = true;
  var box = Hive.box('information');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    focusNodePhone.addListener(() {
      setState(() {});
    });

    focusNodePassword.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthManager.readauth();
    var registererrors = AuthenticationRepository.loginErrorModel;
    List<String> loginTextErrors = [
      registererrors.phone ?? '',
      registererrors.password ?? '',
      registererrors.message ?? '',
      registererrors.unknow ?? '',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'ورود',
                      style: TextStyle(
                          fontFamily: 'VB', fontSize: 18, color: blueDark),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _getTextfild(focusNodePhone, 'شماره تلفن', phoneController,
                        TextInputType.number, 1, registererrors),
                    _getTextfild(
                        focusNodePassword,
                        'رمز عبور',
                        passwordController,
                        TextInputType.visiblePassword,
                        2,
                        registererrors),
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
                                itemCount: loginTextErrors.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    loginTextErrors[index],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'VM',
                                        fontSize: 14),
                                  );
                                },
                              ),
                            )),
                      ),
                    ),
                    Visibility(
                      visible: !dontClickLogin,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: MySpinKit(),
                      ),
                    ),
                    Visibility(
                      visible: dontClickLogin,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 24, right: 24, left: 24, bottom: 8),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            phone = phoneController.text.toString().trim();

                            password = passwordController.text.toString();
                            if (!_formKey.currentState!.validate()) {
                              setState(() {
                                registererrors.phone = '';
                                registererrors.password = '';
                              });
                              return;
                            } else {
                              setState(() {
                                visibelCheckInformation = false;
                                dontClickLogin = false;
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                            }

                            var either = await AuthenticationRepository()
                                .login(phone!, password!, 'android');
                            either.fold((erroreMessage) {
                              _formKey.currentState!.validate();
                              erroreMessage?.forEach((element) {
                                if (element != null) {
                                  if (element.isNotEmpty) print(element);
                                  setState(() {
                                    visibelCheckInformation = true;
                                    dontClickLogin = true;
                                  });
                                } else
                                  (print('خطا در بخش لاگین'));
                                setState(() {
                                  visibelCheckInformation = true;
                                  dontClickLogin = true;
                                });
                              });
                            }, (successMessage) {
                              print(successMessage);

                              setState(() {
                                dontClickLogin = true;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                  (route) => false);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: const Text(
                            'ورود',
                            style: TextStyle(fontSize: 16, fontFamily: 'VB'),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: dontClickLogin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'حساب کاربری ندارید؟',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'VM'),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (() {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                  (route) => false);
                            }),
                            child: Text(
                              ' ثبت نام',
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
      ),
    );
  }

  Padding _getTextfild(
      FocusNode focusNode,
      String hintText,
      TextEditingController controller,
      TextInputType inputType,
      int val,
      LoginErrorModel registerErrors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: inputType,
        style: TextStyle(
          color: blueDark,
          fontFamily: 'VM',
          fontSize: 16,
        ),
        validator: (value) {
          switch (val) {
            case 1:
              if (value == null || value.isEmpty) {
                return 'لطفا شماره تلفن خود را وارد کنید';
              } else if (value.length < 11 || value.length > 11) {
                return 'شماره تلفن باید ۱۱ رقمی باشد';
              } else if (value.contains('.') || value.contains('-')) {
                return 'مقادیر وارد شده مجاز نیست';
              } else if (registerErrors.phone!.isNotEmpty) {
                return registerErrors.phone;
              }
              break;
            case 2:
              if (value == null || value.isEmpty) {
                return 'لطفا رمز عبور را وارد کنید';
              } else if (value.length < 8) {
                return 'رمز عبور حداقل باید ۸ رقم باشد';
              } else if (registerErrors.password!.isNotEmpty) {
                return registerErrors.password;
              }
              break;
          }
        },
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blueDark,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
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

    focusNodePhone.dispose();

    focusNodePassword.dispose();

    super.dispose();
  }
}
