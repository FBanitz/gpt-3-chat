import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFCECCCC);
  static const Color secondary = Color(0xFF1E1E1E);
  static const Color accent = Color(0xFFFF7F11);
  static const Color background = Color(0xFF000000);
  static const Color secondaryBackground = Color.fromARGB(255, 12, 12, 12);
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Color(0xFF3A3A3A);
  static const Color accentText = Color(0xFFFF7F11);

  static const Map<int, Color> swatch = {
    50: Color.fromRGBO(206, 204, 204, .1),
    100: Color.fromRGBO(206, 204, 204, .2),
    200: Color.fromRGBO(206, 204, 204, .3),
    300: Color.fromRGBO(206, 204, 204, .4),
    400: Color.fromRGBO(206, 204, 204, .5),
    500: Color.fromRGBO(206, 204, 204, .6),
    600: Color.fromRGBO(206, 204, 204, .7),
    700: Color.fromRGBO(206, 204, 204, .8),
    800: Color.fromRGBO(206, 204, 204, .9),
    900: Color.fromRGBO(206, 204, 204, 1),
  };
}