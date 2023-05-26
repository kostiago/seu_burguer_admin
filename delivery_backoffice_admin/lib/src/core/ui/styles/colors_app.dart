import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0XFF007D21);
  Color get secondary => const Color(0XFFFFAB18);
  Color get black => const Color(0XFF140E0E);

  Color get backColor => const Color(0XFFf6f6f6);
  Color get mainColor => const Color(0XFFFE6B00);
  Color get blueDarkColor => const Color(0XFF252B5C);
}

extension ColorsExtensiosApp on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
