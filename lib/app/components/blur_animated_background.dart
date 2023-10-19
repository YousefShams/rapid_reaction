import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../resources/app_assets.dart';

class BlurAnimation extends StatelessWidget {
  const BlurAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const blur = 30.0;
    return ClipRect(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(AppAssets.bubbles, frameRate: FrameRate(45)),
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(AppAssets.bubbles, frameRate: FrameRate(45)),
            ),
          ),
          BackdropFilter(
            filter : ImageFilter.blur(sigmaX: blur  ,sigmaY: blur),
            child: const SizedBox(),
          )
        ],
      ),
    );
  }
}
