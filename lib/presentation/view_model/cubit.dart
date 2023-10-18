import 'package:flutter_bloc/flutter_bloc.dart';
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
  int maxHits = 3;
  bool visible = false;
  bool get isGameOver => hitsMsList.length == maxHits;

  //EVENTS
  Future spawn(double screenHeight , double screenWidth) async {
    emit(GameLoadingState());
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
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.gameOverRoute,
          arguments: reactionResult);
    }
  }

  void hideGameObject() {
    visible = false;
    emit(GameSuccessState());
  }

  void showGameObject() {
    visible = true;
    emit(GameSuccessState());
  }

  ReactionResult getReactionResult() {
    return ReactionResult(hitsMsList.average.round(), hitsMsList.min,
        hitsMsList.max);
  }

  Future saveResults(ReactionResult reactionResult) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final reactionHistory = sharedPrefs.get(
        AppSharedPrefsKeys.reactionMsHistory) as List<String>? ?? [];
    final newReactionHistory = ["${reactionResult.reactionSpeed}", ...reactionHistory];
    sharedPrefs.setStringList(AppSharedPrefsKeys.reactionMsHistory, newReactionHistory);
  }
}