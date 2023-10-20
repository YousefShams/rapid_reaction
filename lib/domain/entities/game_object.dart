import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import 'package:rapid_reaction/presentation/view/game/components/hit_widget.dart';
import '../../app/resources/app_assets.dart';


class GameObject {
  late double x;
  late double y;
  late DateTime lastSpawn;
  late GameMode gameMode;
  double size = AppConsts.gameObjectSize;
  bool visible = false;
  final double screenWidth;
  final double screenHeight;
  late AudioPlayer playerOnClick;
  late AudioPlayer playerOnShow ;
  List<int> hitsMsList = [];
  final int maxHits;

  GameObject._create(this.screenHeight, this.screenWidth,
      this.playerOnClick, this.playerOnShow,
      this.lastSpawn, this.maxHits, this.gameMode);

  static Future<GameObject> create(double h, double w, GameMode gameMode) async {
    final lastSpawn = DateTime.now();
    final playerClick  = AudioPlayer()..setSourceAsset(AppAssets.clickSound);
    final playerShow = AudioPlayer()..setSourceAsset(AppAssets.showSound);
    const maxHits = 15;
    final gameObj= GameObject._create(h,w,playerClick,playerShow,lastSpawn,
        maxHits, gameMode);
    await gameObj._changePosition();
    return gameObj;
  }

  Future<void> hit(Function updateUI) async {
    if(gameMode==GameMode.normal) {
      await hitNormal(updateUI);
    }
    else {
      await hitNinja(updateUI);
    }
  }

  Future hitNormal(Function updateUI) async {
    await hide();
    updateUI();
    int hitReactionMs = DateTime.now().difference(lastSpawn).inMilliseconds;
    hitsMsList.add(hitReactionMs);
    if(!isGameOver) {
      await _changePosition();
      updateUI();
    }
  }

  Future hitNinja(Function updateUI) async {
    await hide();
    updateUI();
    int hitReactionMs = DateTime.now().difference(lastSpawn).inMilliseconds;
    hitsMsList.add(hitReactionMs);
    setSize(getNewSize(hitReactionMs));
    if(!isGameOver) {
      await _changePosition();
      updateUI();
    }
  }

  void setVisibility(bool value) {
    visible = value;
  }

  void setSize(double newSize) {
    size = newSize;
  }

  Widget getWidget(Function onTap) {
    return Visibility(
        visible: visible,
        child: HitWidget(x: x, y: y, size: size, onTap: onTap)
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

  double getNewSize(int differenceMs) {
    if(gameMode==GameMode.normal) {
      return AppConsts.gameObjectSize;
    }
    else {
      final diffNorm = differenceMs - AppConsts.lowNinjaReactionTime;
      const highNorm = AppConsts.highNinjaReactionTimeNorm;
      final factor = min(max(0, 1.0 - (diffNorm/highNorm)) , 1);
      final newSize = factor * AppConsts.gameObjectSize;
      return newSize;
    }
  }

  Future _changePosition() async {
    await Future.delayed(Duration(milliseconds: getDelay()));
    x = Random().nextInt(screenWidth.toInt()).toDouble();
    y = Random().nextInt(screenHeight.toInt()).toDouble();
    lastSpawn = DateTime.now();
    await show();
  }

  bool get isGameOver {
    if(gameMode==GameMode.normal) {
      return maxHits == hitsMsList.length;
    }
    else {
      return size <= AppConsts.gameObjectSize*0.2;
    }
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