import 'dart:convert';

import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/login_screen.dart';
import 'package:charity/screens/pages/main_screen.dart';
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

  void login(String name, String phone, String emailAddress, String pass,
      String configPass) async {
    print('name:' + name);
    print('phone:' + phone);
    print('email:' + emailAddress);
    print('pass:' + pass);
    print('config:' + configPass);
    try {
      Response response = await post(
          Uri.parse(
              'https://khapp.amiralmomenin-kheirieh.ir/api/v1/1/register'),
          body: {
            'name': name,
            'phone': phone,
            'email': emailAddress,
            'password': pass,
            'password_confirmation': configPass,
            'device_name': divaiceName,
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data['status'].toString() == 'error') {
          setState(() {
            dontTapRegister = true;
            visibelCheckInformation = true;
            errorText = data['errors'].toString();
            errorText = errorText!.replaceAll(',', '\n');
            List le = [
              'phone',
              'password',
              ']',
              '[',
              ': ',
              '{',
              '}',
              '',
              'massage',
              'email',
            ];
            for (var i = 0; i < le.length; i++) {
              errorText = errorText!.replaceAll(le[i], '');
            }
          });
        }
        print(data);
        print(data['data']['token']);
        box.put('token', data['data']['token']);
        box.put('name', data['data']['name']);
        // await storage.write(key: 'token', value: data['data']['token']);
        // await storage.write(key: 'name', value: data['data']['name']);
        print('account creat sucssesfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
            (route) => false);
      } else
        (print('faild'));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
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
                    _getTextfild(focusNodePhone, 'شماره تلفن', phoneController,
                        TextInputType.number),
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
                          child: Text(
                            errorText ?? 'بدون خطا',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'VM',
                                fontSize: 14),
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
                          onPressed: () {
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

                            login(name!, phone!, emailAddress!, password!,
                                configPassword!);
                          },
                          child: Text(
                            'ثبت نام',
                            style: TextStyle(fontSize: 16, fontFamily: 'VB'),
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
      ),
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
