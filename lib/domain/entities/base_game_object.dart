import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import '../../app/resources/app_enums.dart';
import '../../presentation/view/game/components/score_widget.dart';

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
  final int minDelayMs;
  final int maxDelayMs;
  List<int> hitsMsList = [];
  bool destroyed = false;
  List<Widget> scoreWidgets = [];


  GameObject(this.screenHeight, this.screenWidth, this.playerOnClick,
      this.playerOnShow, this.lastSpawn, this.gameMode, this.clickSound,
      this.allowTapOutside, this.showSound,this.minDelayMs, this.maxDelayMs);

  Future<void> hit(Function updateUI) async {
    int hitReactionMs= DateTime.now().difference(lastSpawn).inMilliseconds;
    handleScore(updateUI, hitReactionMs);
    await hide();
    updateUI();
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
    await playerOnShow.play(AssetSource(clickSound), volume: 0.5);
  }

  Future show() async {
    if(!destroyed) {
      setVisibility(true);
      await playerOnShow.play(AssetSource(showSound), volume: 0.5);
    }
  }

  Future respawn() async {
    await Future.delayed(Duration(milliseconds: getDelay(minDelayMs,maxDelayMs)));
    x = Random().nextInt(screenWidth.toInt()).toDouble();
    y = Random().nextInt(screenHeight.toInt()).toDouble();
    lastSpawn = DateTime.now();
    await show();
  }

  static int getDelay(int min, int max) {
    return Random().nextInt(max- min)+ min;
  }

  ReactionResult? getReactionResult() {
    if(hitsMsList.isNotEmpty) {
      return ReactionResult(hitsMsList.average.round(),
          hitsMsList.min, hitsMsList.max);
    }
    return null;
  }

  Future dispose() async {
    destroyed = true;
    await Future.delayed(const Duration(milliseconds: 700));
    if(playerOnClick.state!=PlayerState.disposed) await playerOnClick.dispose();
    if(playerOnShow.state!=PlayerState.disposed) await playerOnShow.dispose();
  }

  Color getReactionMsColor(int ms);


  void handleScore(Function updateUI, int hitReactionMs) {
    if(scoreWidgets.length > 2) scoreWidgets.clear();
    updateUI();
    final widget= ScoreWidget(key:Key("${DateTime.now().millisecondsSinceEpoch}"),
        x: x, y:y, color: getReactionMsColor(hitReactionMs), ms: hitReactionMs);
    scoreWidgets.add(widget);
    updateUI();

  }
}