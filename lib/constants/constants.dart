import 'package:flutter/cupertino.dart';

Color blueDark = Color(0xff1d3557);
Color blueLight = Color(0xff457b9d);
//// gradient
LinearGradient blueGradient = LinearGradient(
    colors: [blueDark, blueLight],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
