import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';

import '../constants/constants.dart';

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle({Key? key, this.title = AppConsts.appTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:AppValues.pagePadding),
      child: Text(title,
          style: context.textTheme.titleLarge, textAlign: TextAlign.center,),
    );
  }
}
