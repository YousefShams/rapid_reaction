import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_fonts.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';

class ScoreWidget extends StatelessWidget {
  final double x;
  final double y;
  final int ms;
  final Color color;
  const ScoreWidget({Key? key, required this.x,
    required this.y, required this.ms, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
     tween: Tween(begin: 1.0, end: 0.0),
     duration: const Duration(milliseconds: AppConsts.scoreAnimationDuration),
     builder: (context, value, _) {
       return AnimatedPositioned(
         left: max(AppValues.pagePadding, x - 60),
         top: (max(30,y) * value) - 30,
         duration: const Duration(milliseconds: AppConsts.minReactionDelayTime),
         curve: Curves.fastOutSlowIn,
         child: Text(
           AppStrings.getTimeString(ms),
           style: context.textTheme.titleMedium?.copyWith(
               color: color, fontSize: AppFonts.largeFontSize)
         ),
       );
     }
    );
  }
}
