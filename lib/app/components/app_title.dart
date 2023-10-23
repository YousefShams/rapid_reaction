import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_fonts.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import '../constants/constants.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final bool big;
  const AppTitle({Key? key, this.title = AppConsts.appTitle,
    this.big = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:AppValues.pagePadding),
      child: Text(title,
        style: context.textTheme.titleLarge?.copyWith(
            fontSize: big ? AppFonts.xXLFontSize : null),
        textAlign: TextAlign.center
      ),
    );
  }
}
