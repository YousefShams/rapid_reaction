import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_reaction/app/resources/app_assets.dart';
import 'package:rapid_reaction/app/resources/app_shared_prefs_keys.dart';
import 'package:rapid_reaction/domain/entities/game_object.dart';
import 'package:rapid_reaction/presentation/view_model/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/application/application.dart';
import '../../app/routes/app_routes.dart';
import '../../domain/entities/reaction_result.dart';
import 'package:collection/collection.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitialState());

  static GameCubit get(context) => BlocProvider.of(context);

  //VARIABLES
  late GameObject gameObject;
  List<int> hitsMsList = [];
  int maxHits = 10;
  bool visible = false;
  bool get isGameOver => hitsMsList.length == maxHits;
  final playerOnClick = AudioPlayer();
  final playerOnShow = AudioPlayer();

  //EVENTS
  Future spawn(double screenHeight , double screenWidth) async {
    emit(GameLoadingState());
    await playerOnClick.setSourceAsset(AppAssets.clickSound);
    await playerOnShow.setSourceAsset(AppAssets.showSound);
    await Future.delayed(Duration(milliseconds: GameObject.getDelay()));
    gameObject = GameObject(screenHeight, screenWidth);
    showGameObject();
  }

  Future onHit() async {
    hideGameObject();
    final hitMs = await gameObject.hit();
    hitsMsList.add(hitMs);

    if(isGameOver) {
      await handleGameOver(isGameOver);
    }
    else {
      showGameObject();
      emit(GameSuccessState());
    }
  }

  Future handleGameOver(bool isGameOver) async {
    if(isGameOver) {
      final reactionResult= getReactionResult();
      await saveResults(reactionResult);
      await playerOnShow.dispose();
      await playerOnClick.dispose();
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.gameOverRoute,
          arguments: reactionResult);
    }
  }

  Future hideGameObject() async {
    visible = false;
    await playerOnClick.play(AssetSource(AppAssets.clickSound));
    emit(GameSuccessState());
  }

  Future showGameObject() async {
    visible = true;
    await playerOnShow.play(AssetSource(AppAssets.showSound), volume: 0.6);
    emit(GameSuccessState());
  }

  ReactionResult getReactionResult() {
    return ReactionResult(hitsMsList.average.round(), hitsMsList.min,
        hitsMsList.max);
  }

  Future saveResults(ReactionResult reactionResult) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final reactionHistory = (sharedPrefs.get(AppSharedPrefsKeys.reactionMsHistory)
    as List? ?? []).map((e) => "$e").toList();
    final newReactionHistory = ["${reactionResult.reactionSpeed}", ...reactionHistory];
    sharedPrefs.setStringList(AppSharedPrefsKeys.reactionMsHistory, newReactionHistory);
  }
}