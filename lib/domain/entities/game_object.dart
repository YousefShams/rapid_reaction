import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import 'package:rapid_reaction/presentation/view/game/components/hit_widget.dart';
import '../../app/resources/app_assets.dart';


class GameObject {
  late double x;
  late double y;
  late DateTime lastSpawn;
  bool visible = false;
  final double screenWidth;
  final double screenHeight;
  late AudioPlayer playerOnClick;
  late AudioPlayer playerOnShow ;
  List<int> hitsMsList = [];
  final int maxHits;
  bool get isGameOver => maxHits != hitsMsList.length;

  GameObject._create(this.screenHeight, this.screenWidth,
      this.playerOnClick, this.playerOnShow, this.lastSpawn, this.maxHits);

  static Future<GameObject> create(double h, double w, int maxHits) async {
    final lastSpawn = DateTime.now();
    final playerClick  = AudioPlayer()..setSourceAsset(AppAssets.clickSound);
    final playerShow = AudioPlayer()..setSourceAsset(AppAssets.showSound);
    final gameObj= GameObject._create(h,w,playerClick,playerShow,lastSpawn,maxHits);
    await gameObj._changePosition();
    return gameObj;
  }

  Future<void> hit(Function updateUI) async {
    await hide();
    updateUI();
    int hitReactionMs = DateTime.now().difference(lastSpawn).inMilliseconds;
    hitsMsList.add(hitReactionMs);
    if(isGameOver) {
      await _changePosition();
      updateUI();
    }
  }

  void setVisibility(bool value) {
    visible = value;
  }

  Widget getWidget(Function onTap) {
    return Visibility(
        visible: visible,
        child: HitWidget(x: x, y: y, onTap: onTap)
    );
  }

  Future hide() async {
    setVisibility(false);
    await playerOnClick.play(AssetSource(AppAssets.clickSound));
  }

  Future show() async {
    setVisibility(true);
    await playerOnShow.play(AssetSource(AppAssets.showSound), volume: 0.6);
  }


  Future _changePosition() async {
    await Future.delayed(Duration(milliseconds: getDelay()));
    x = Random().nextInt(screenWidth.toInt()).toDouble();
    y = Random().nextInt(screenHeight.toInt()).toDouble();
    lastSpawn = DateTime.now();
    await show();
  }

  static int getDelay() {
    return Random().nextInt(AppConsts.maxReactionDelayTime-
        AppConsts.minReactionDelayTime)+ AppConsts.minReactionDelayTime;
  }

  ReactionResult getReactionResult() {
    return ReactionResult(hitsMsList.average.round(), hitsMsList.min,
        hitsMsList.max);
  }

  Future dispose() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if(playerOnClick.state!=PlayerState.disposed) await playerOnClick.dispose();
    if(playerOnShow.state!=PlayerState.disposed) await playerOnShow.dispose();
  }
}