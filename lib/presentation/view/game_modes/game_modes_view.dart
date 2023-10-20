import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/components/app_title.dart';
import 'package:rapid_reaction/app/components/back_app_bar.dart';
import 'package:rapid_reaction/app/functions/functions.dart';
import 'package:rapid_reaction/app/resources/app_enums.dart';
import 'package:rapid_reaction/app/resources/app_shared_prefs_keys.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/presentation/view/game_modes/components/game_mode_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameModesScreen extends StatefulWidget {
  const GameModesScreen({Key? key}) : super(key: key);

  @override
  State<GameModesScreen> createState() => _GameModesScreenState();
}

class _GameModesScreenState extends State<GameModesScreen> {
  GameMode? currentGameMode;


  @override
  void initState() {
    super.initState();
    getCurrentGameMode();
  }

  Future getCurrentGameMode() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final result=sharedPrefs.get(AppSharedPrefsKeys.currentGameMode) as int? ??0;
    setState(() {
      currentGameMode = AppFunctions.getGameModeFromNumber(result);
    });
  }

  Future saveGameMode(GameMode gameMode) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final gameModeNumber = AppFunctions.getNumberFromGameMode(gameMode);
    await sharedPrefs.setInt(AppSharedPrefsKeys.currentGameMode,gameModeNumber);
    setState(() { currentGameMode = gameMode; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBackAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle(title: AppStrings.gameModes),
            const Spacer(flex: 1),
            GameModeButton(icon: Icons.touch_app, gameMode: GameMode.normal,
                title: AppStrings.normalMode, onSelected: saveGameMode,
                isSelected: currentGameMode==GameMode.normal),
            GameModeButton(icon: Icons.flash_on, gameMode: GameMode.ninja,
                iconColor: Colors.yellow,
                title: AppStrings.ninjaMode, onSelected: saveGameMode,
                isSelected: currentGameMode==GameMode.ninja),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
