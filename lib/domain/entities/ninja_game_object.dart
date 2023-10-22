import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/resources/app_assets.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/domain/entities/base_game_object.dart';
import 'package:rapid_reaction/presentation/view/game/components/circle_hit_widget.dart';


class NinjaGameObject extends GameObject {

  double size = AppConsts.circleGameObjectSize;

  NinjaGameObject._create(super.screenHeight, super.screenWidth,
      super.playerOnClick, super.playerOnShow, super.lastSpawn,
      super.gameMode, super.clickSound, super.allowTapOutside,
      super.showSound, super.minDelayMs, super.maxDelayMs);

  static Future<NinjaGameObject> create(double h, double w,
      GameMode gameMode, String clickSound, String showSound) async {
    final lastSpawn = DateTime.now();
    final playerClick  = AudioPlayer()..setSourceAsset(clickSound);
    final playerShow = AudioPlayer()..setSourceAsset(showSound);
    final gameObj= NinjaGameObject._create(h,w,playerClick,playerShow,
        lastSpawn, gameMode, clickSound, true, AppAssets.showNinja,
        AppConsts.minReactionDelayTime , AppConsts.maxReactionDelayTime);
    await gameObj.respawn();
    return gameObj;
  }


  @override
  Future handleAfterHit(int hitReactionMs) async {
    size = getNewSize(hitReactionMs);
    if(!isGameOver) await respawn();

  }


  @override
  Widget getWidget(Function onTap) {
    return Visibility(
        visible: visible,
        child: CircleHitWidget(x: x, y: y, size: size,
            assetName: AppAssets.ninja, onTap: onTap)
    );
  }


  double getNewSize(int differenceMs) {
    final diffNorm = differenceMs - AppConsts.lowNinjaReactionTime;
    const highNorm = AppConsts.highNinjaReactionTimeNorm;
    final factor = min(max(0, 1.0 - (diffNorm/highNorm)) , 1);
    final newSize = factor * AppConsts.circleGameObjectSize;
    return newSize;
  }

  @override
  bool get isGameOver {
    const factor = AppConsts.minCircleGameObjectSizeFactor;
    return size <=  factor * AppConsts.circleGameObjectSize;
  }

  @override
  Color getReactionMsColor(int ms) {
    if(ms < 700) { return Colors.green; }
    else if(ms >= 700 && ms < 1000) { return Colors.orange; }
    else { return Colors.red; }
  }

}