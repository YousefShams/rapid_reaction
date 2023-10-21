import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_colors.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';

class NormalHitWidget extends StatelessWidget {

  final Function onTap;
  const NormalHitWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { onTap(); },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          width: context.width, height: context.height,
          color: AppColors.hitWidgetColor,
          child: Text(AppStrings.pressNow, textAlign: TextAlign.center,
              style: context.textTheme.titleLarge),
        ),
      )
    );
  }
}
