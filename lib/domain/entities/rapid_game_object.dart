import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/domain/entities/base_game_object.dart';
import 'package:rapid_reaction/presentation/view/game/components/circle_hit_widget.dart';
import '../../app/resources/app_assets.dart';


class RapidGameObject extends GameObject {
  RapidGameObject._create(super.screenHeight, super.screenWidth,
      super.playerOnClick, super.playerOnShow, super.lastSpawn,
      super.gameMode, super.clickSound, super.allowTapOutside,
      super.showSound);

  static Future<RapidGameObject> create(double h, double w,
      GameMode gameMode, String clickSound) async {
    final lastSpawn = DateTime.now();
    final playerClick  = AudioPlayer()..setSourceAsset(clickSound);
    final playerShow = AudioPlayer()..setSourceAsset(AppAssets.showSound);
    final gameObj= RapidGameObject._create(h,w,playerClick,playerShow,
        lastSpawn, gameMode, clickSound, true, AppAssets.showSound);
    await gameObj.respawn();
    return gameObj;
  }

  @override
  Future handleAfterHit(int hitReactionMs) async {
    if(!isGameOver) await respawn();
  }

  @override
  Widget getWidget(Function onTap) {
    return Visibility(
        visible: visible,
        child: CircleHitWidget(x: x, y: y,
            size: AppConsts.gameObjectSize, onTap: onTap)
    );
  }

  @override
  bool get isGameOver {
    return AppConsts.rapidModeMaxHits == hitsMsList.length;
  }

}