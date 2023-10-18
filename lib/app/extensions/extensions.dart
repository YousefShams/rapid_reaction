import 'package:flutter/material.dart';

extension TextThemeExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ScreenSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get safeAreaHeight => MediaQuery.of(this).padding.top+MediaQuery.of(this).padding.bottom;
}