import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/domain/entities/base_game_object.dart';
import 'package:rapid_reaction/presentation/view/game/components/normal_hit_widget.dart';
import '../../app/resources/app_assets.dart';
import '../../app/resources/app_enums.dart';

class NormalGameObject extends GameObject {

  NormalGameObject._create(super.screenHeight, super.screenWidth,
      super.playerOnClick, super.playerOnShow, super.lastSpawn,
      super.gameMode, super.clickSound, super.allowTapOutside,
      super.showSound);

  static Future<NormalGameObject> create(double h, double w,
      GameMode gameMode, String clickSound) async {
    final lastSpawn = DateTime.now();
    final playerClick  = AudioPlayer()..setSourceAsset(clickSound);
    final playerShow = AudioPlayer()..setSourceAsset(AppAssets.showSound);
    final gameObj= NormalGameObject._create(h,w,playerClick,playerShow,
        lastSpawn, gameMode, clickSound, false, AppAssets.showSound);
    await gameObj.respawn();
    return gameObj;
  }

  @override
  Widget getWidget(Function onTap) {
    return Visibility(visible:visible, child: NormalHitWidget(onTap:onTap));
  }



  @override
  bool get isGameOver => hitsMsList.length == AppConsts.normalModeMaxHits;

  @override
  Future handleAfterHit(int hitReactionMs) async {
    if(!isGameOver) await respawn();
  }

}