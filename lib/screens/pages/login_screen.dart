import 'dart:convert';

import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

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

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    focusNodePhone.addListener(() {
      setState(() {});
    });

    focusNodePassword.addListener(() {
      setState(() {});
    });
  }

  void login(
    String phone,
    String pass,
  ) async {
    print('phone:' + phone);
    print('pass:' + pass);

    try {
      Response response = await post(
          Uri.parse('https://khapp.amiralmomenin-kheirieh.ir/api/v1/1/login'),
          body: {
            'phone': phone,
            'password': pass,
            'device_name': divaiceName,
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print(data['status']);
        if (data['status'].toString() == 'error') {
          setState(() {
            visibelCheckInformation = true;
            dontClickLogin = true;
            errorText = data['errors'].toString();
            errorText = errorText!.replaceAll(',', '\n');
            List le = [
              'phone',
              'password',
              ']',
              '[',
              ':',
              '{',
              '}',
              '',
              'massage',
            ];
            for (var i = 0; i < le.length; i++) {
              errorText = errorText!.replaceAll(le[i], '');
            }
          });
        }
        print('logedin');
        await box.put('token', data['data']['token']);
        await box.put('name', data['data']['name']);
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
                      'ورود',
                      style: TextStyle(
                          fontFamily: 'VB', fontSize: 18, color: blueDark),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _getTextfild(focusNodePhone, 'شماره تلفن', phoneController,
                        TextInputType.number),
                    _getTextfild(focusNodePassword, 'رمز عبور',
                        passwordController, TextInputType.visiblePassword),
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
                      visible: !dontClickLogin,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Visibility(
                      visible: dontClickLogin,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 24, right: 24, left: 24, bottom: 8),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              visibelCheckInformation = false;
                              dontClickLogin = false;
                            });

                            phone = phoneController.text.toString().trim();

                            password = passwordController.text.toString();

                            login(phone!, password!);
                          },
                          child: Text(
                            'ورود',
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
                      visible: dontClickLogin,
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
                              Navigator.pop(context);
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

    focusNodePhone.dispose();

    focusNodePassword.dispose();

    super.dispose();
  }
}
