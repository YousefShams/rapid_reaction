import 'package:rapid_reaction/app/resources/app_enums.dart';

class AppFunctions {

  static GameMode getGameModeFromNumber(int value) {
    if(value == 0) { return GameMode.normal; }
    else if(value == 1) { return GameMode.rapid; }
    else { return GameMode.ninja; }

  }

  static int getNumberFromGameMode(GameMode value) {
    if(value == GameMode.normal) { return 0; }
    else if(value == GameMode.rapid) { return 1; }
    else { return 2; }
  }
}