// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color blueDark = Color(0xff1d3557);
Color blueLight = Color(0xff457b9d);
// Color blueDark = Color(0xff1f6243);
// Color blueLight = Color(0xff98b45e);
Color white = Colors.white;
Color black = Colors.black;
Color grey = Color(0xFFEEEEEE);
//// gradient
LinearGradient blueGradient = LinearGradient(
    colors: [blueDark, blueLight],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);

// Strings
String longName = 'خیریه امام علی (ع) شهر گرگاب ';
String shortName = ' خیریه امام علی (ع) گرگاب';

String newsTest =
    'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد';
const String phoneNumber = '03145753131';

class ApiAddress {
  static const String baseApiUrl = 'https://khapp.kheiriehemamali.ir/api/v1/1/';
  static const String homeAddress = '';
  static const String register = 'register';
  static const String login = 'login';
  static const String projectAddress = 'project';
  static const String pooyeshAddress = 'pooyesh';
  static const String hadisAddress = 'hadis';
  // static const String newsAddressHome =
  //     'https://kheiriehemamali.ir/blog/wp-json/wp/v2/posts?per_page=5';
  static const String newsAddressHome =
      'https://kheiriehemamali.ir/blog/wp-json/wp/v2/posts?per_page=5';
  static const String newsAddress =
      'https://kheiriehemamali.ir/blog/wp-json/wp/v2/posts';
  static const String type = 'type';
  static const String secandType = 'type?sub=';

  static const String factors = 'profile/faktoors';
  static const String damandType = 'profile/darkhasts/type';
  static const String damandSecandType = 'profile/darkhasts/type?sub=';
  static const String damandList = 'profile/darkhasts';
  static const String creatDamand = 'profile/darkhasts/create';
  static const String profile = 'profile';
  static const String profileUpdate = 'profile/update';
  static const String repayLink = 'https://khapp.kheiriehemamali.ir/invoice/';
  static const String shareFactors = 'khapp.kheiriehemamali.ir/fk/';
  static const String deletedamand = 'profile/darkhasts/delete?id=';
  static const String aboutUs = 'about';
  static const String marasemat = 'marasem';
  static const String wearthType = 'taj/type';
  static const String wearthTarh = 'taj/tarh';
  static const String creatOrder = 'taj/create-order';
  static const String userOrders = 'taj/user-order';
}

class ErrorsMessages {
  static const String unAvailable = 'خیره در دسترس نمیباشد';
}
