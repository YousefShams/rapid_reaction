import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_values.dart';
import 'app_title.dart';

class RapidReactionWidget extends StatelessWidget {
  const RapidReactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTitle(big: true),
        Icon(Icons.touch_app_rounded, color: AppColors.primaryColor,
            size: AppValues.splashIconSize)
      ],
    );
  }
}
