import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_reaction/app/resources/app_shared_prefs_keys.dart';
import 'package:rapid_reaction/domain/entities/game_object.dart';
import 'package:rapid_reaction/presentation/view_model/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/application/application.dart';
import '../../app/routes/app_routes.dart';
import '../../domain/entities/reaction_result.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitialState());

  static GameCubit get(context) => BlocProvider.of(context);

  //VARIABLES
  late GameObject gameObject;
  int maxHits = 15;
  updateUI(){ emit(GameSuccessState()); }

  //EVENTS
  Future spawn(double screenHeight , double screenWidth) async {
    emit(GameLoadingState());
    gameObject = await GameObject.create(screenHeight, screenWidth, maxHits);
    emit(GameSuccessState());
  }

  Future onHit() async {
    await gameObject.hit(updateUI);

    if(isGameOver()) {
      await handleGameOver(isGameOver());
    }
  }

  bool isGameOver() {
    return gameObject.hitsMsList.length == gameObject.maxHits;
  }

  Future handleGameOver(bool isGameOver) async {
    if(isGameOver) {
      final reactionResult= gameObject.getReactionResult();
      await saveResults(reactionResult);
      await gameObject.dispose();
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.gameOverRoute,
          arguments: reactionResult);
    }
  }




  Future saveResults(ReactionResult reactionResult) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final reactionHistory = (sharedPrefs.get(AppSharedPrefsKeys.reactionMsHistory)
    as List? ?? []).map((e) => "$e").toList();
    final newReactionHistory = ["${reactionResult.reactionSpeed}", ...reactionHistory];
    sharedPrefs.setStringList(AppSharedPrefsKeys.reactionMsHistory, newReactionHistory);
  }

  @override
  Future<void> close() async {
    await gameObject.dispose();
    super.close();
  }
}