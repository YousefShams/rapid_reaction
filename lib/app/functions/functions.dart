import 'package:rapid_reaction/app/resources/app_enums.dart';

class AppFunctions {

  static GameMode getGameModeFromNumber(int value) {
    if(value == 0) return GameMode.normal;
    return GameMode.ninja;
  }

  static int getNumberFromGameMode(GameMode value) {
    if(value == GameMode.normal) return 0;
    return 1;
  }
}