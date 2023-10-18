import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/resources/app_colors.dart';
import '../../../../app/constants/constants.dart';
import '../../../../app/resources/app_values.dart';

class HitWidget extends StatelessWidget {
  final double x;
  final double y;
  final Function onTap;

  const HitWidget({Key? key, required this.x,
    required this.y, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const p = AppValues.pagePadding;
    const size = AppConsts.gameObjectSize;
    return Positioned(
      top: max(0, y - p*2 - size*2),
      left: max(0, x - p*2 - size*2),
      child: GestureDetector(
        onTap: () { onTap(); },
        child: const CircleAvatar(radius: size, backgroundColor: AppColors.hitWidgetColor)
      )
    );
  }
}
