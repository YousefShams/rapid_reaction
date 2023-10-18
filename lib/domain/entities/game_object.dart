
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rapid_reaction/presentation/view/game/components/hit_widget.dart';

class GameObject {
  late double x;
  late double y;
  late DateTime lastSpawn;
  late final double screenWidth;
  late final double screenHeight;

  GameObject(this.screenHeight, this.screenWidth) {
    x = Random().nextInt(screenWidth.toInt()).toDouble();
    y = Random().nextInt(screenHeight.toInt()).toDouble();
    lastSpawn = DateTime.now();
  }

  Future<int> hit() async {
    int hitReactionMs = DateTime.now().difference(lastSpawn).inMilliseconds;
    await _changePosition();
    return hitReactionMs;
  }

  Widget getWidget(Function onTap) {
    return HitWidget(x: x, y: y, onTap: onTap);
  }


  Future<int> _changePosition() async {
    final delayMs = getDelay();
    await Future.delayed(Duration(milliseconds: delayMs));
    x = Random().nextInt(screenWidth.toInt()).toDouble();
    y = Random().nextInt(screenHeight.toInt()).toDouble();
    lastSpawn = DateTime.now();
    return delayMs;
  }

  static int getDelay() {
    return Random().nextInt(1500)+250;
  }
}