import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import '../../app/constants/constants.dart';
import '../../app/resources/app_enums.dart';

abstract class GameObject {
  late double x;
  late double y;
  late DateTime lastSpawn;
  final GameMode gameMode;
  bool visible = false;
  final double screenWidth;
  final double screenHeight;
  final AudioPlayer playerOnClick;
  final AudioPlayer playerOnShow;
  final String clickSound;
  final String showSound;
  final bool allowTapOutside;
  List<int> hitsMsList = [];
  bool destroyed = false;

  GameObject(this.screenHeight, this.screenWidth, this.playerOnClick,
      this.playerOnShow, this.lastSpawn, this.gameMode, this.clickSound,
      this.allowTapOutside, this.showSound);

  Future<void> hit(Function updateUI) async {
    await hide();
    updateUI();
    int hitReactionMs= DateTime.now().difference(lastSpawn).inMilliseconds;
    hitsMsList.add(hitReactionMs);
    await handleAfterHit(hitReactionMs);
    if(!isGameOver) updateUI();
  }

  Future handleAfterHit(int hitReactionMs);

  Widget getWidget(Function onTap);

  bool get isGameOver;


  void setVisibility(bool value) {
    visible = value;
  }

  Future hide() async {
    setVisibility(false);
    await playerOnShow.play(AssetSource(clickSound));
  }

  Future show() async {
    if(!destroyed) {
      setVisibility(true);
      await playerOnShow.play(AssetSource(showSound), volume: 0.6);
    }
  }

  Future respawn() async {
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

  ReactionResult? getReactionResult() {
    if(hitsMsList.isNotEmpty) {
      return ReactionResult(hitsMsList.average.round(), hitsMsList.min,
          hitsMsList.max);
    }
    return null;
  }

  Future dispose() async {
    destroyed = true;
    await Future.delayed(const Duration(milliseconds: 700));
    if(playerOnClick.state!=PlayerState.disposed) await playerOnClick.dispose();
    if(playerOnShow.state!=PlayerState.disposed) await playerOnShow.dispose();
  }

}