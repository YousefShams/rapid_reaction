import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_reaction/app/functions/functions.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/app/resources/app_shared_prefs_keys.dart';
import 'package:rapid_reaction/domain/entities/base_game_object.dart';
import 'package:rapid_reaction/domain/entities/game_object_factory.dart';
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
  late GameMode gameMode;
  updateUI(){ emit(GameSuccessState()); }

  //EVENTS
  Future init(double sH , double sW) async {
    emit(GameLoadingState());
    gameMode = await getGameMode();
    gameObject = await GameObjectFactory().create(sH,sW,gameMode);
    emit(GameSuccessState());
  }

  Future onHit() async {
    await gameObject.hit(updateUI);
    if(gameObject.isGameOver) await handleGameOver();
  }


  Future handleGameOver() async {
    final reactionResult= gameObject.getReactionResult();
    if(reactionResult!=null) await saveResults(reactionResult);
    await gameObject.dispose();
    navigatorKey.currentState?.pushReplacementNamed(
        AppRoutes.gameOverRoute, arguments: reactionResult);
  }

  Future onTapOutside() async {
    if(!gameObject.allowTapOutside) await handleGameOver();
  }

  Future saveResults(ReactionResult reactionResult) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final reactionHistory= (sharedPrefs.get(AppSharedPrefsKeys.reactionMsHistory)
    as List? ?? []).map((e) => "$e").toList();
    final newReactionHistory = ["${reactionResult.reactionSpeed}", ...reactionHistory];
    sharedPrefs.setStringList(AppSharedPrefsKeys.reactionMsHistory, newReactionHistory);
  }

  Future<GameMode> getGameMode() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final gameModeNumber= sharedPrefs.getInt(AppSharedPrefsKeys.currentGameMode);
    return AppFunctions.getGameModeFromNumber(gameModeNumber ?? 0);
  }

  @override
  Future<void> close() async {
    await gameObject.dispose();
    super.close();
  }
}