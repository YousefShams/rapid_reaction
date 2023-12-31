
import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Colors.blue;
  static final splashColor = Colors.indigoAccent.withOpacity(0.5);
  static const scaffoldLightBackground = Colors.white;
  static const scaffoldDarkBackground = Color.fromARGB(255, 0, 1,6);
  static final imageSplashColor = Colors.white.withOpacity(0.5);
  static final lightPrimaryColor = Colors.indigoAccent[300];
  static const hitWidgetColor = Colors.blue;
  static final primaryColorDarker = Colors.blue[900];
  static final defaultIconColor = AppColors.primaryColorDarker;
  static const circularProgressGradient = LinearGradient(
      colors: [Colors.green, Colors.red],
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      stops: [0.1, 1.0]
  );
}