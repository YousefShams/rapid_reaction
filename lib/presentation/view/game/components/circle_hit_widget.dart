import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/resources/app_colors.dart';
import '../../../../app/resources/app_values.dart';

class CircleHitWidget extends StatelessWidget {
  final double x;
  final double y;
  final Function onTap;
  final double size;
  final String assetName;
  const CircleHitWidget({Key? key, required this.x,
    required this.y, required this.onTap,
    required this.size, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const p = AppValues.pagePadding;
    return Positioned(
      top: max(0, y - p*2 - size),
      left: max(0, x - p*2 - size),
      child: GestureDetector(
        onTap: () { onTap(); },
        child: CircularPercentIndicator(
          radius: size/2,
          animation: true,
          percent: 1.0,
          linearGradient: AppColors.circularProgressGradient,
          animationDuration: AppConsts.percentIndicatorMs,
          center: Padding(
            padding: const EdgeInsets.all(AppValues.circularProgressLineWidth),
            child: SvgPicture.asset(assetName),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          //progressColor: AppColors.circularProgressColor,
        ),
      )
    );
  }
}
