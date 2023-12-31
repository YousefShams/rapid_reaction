import 'package:flutter/material.dart';
import 'package:rapid_reaction/presentation/view/game/game_view.dart';
import 'package:rapid_reaction/presentation/view/game_modes/game_modes_view.dart';
import 'package:rapid_reaction/presentation/view/game_over/game_over_view.dart';
import 'package:rapid_reaction/presentation/view/how_to_play/view/how_to_play_view.dart';
import 'package:rapid_reaction/presentation/view/main_menu/main_menu_view.dart';
import 'package:rapid_reaction/presentation/view/scoreboard/scoreboard_view.dart';
import 'package:rapid_reaction/presentation/view/splash/splash_view.dart';

import '../resources/app_page_transition.dart';

class AppRoutes {

  static const splashRoute = "/splash";
  static const mainMenuRoute = "/main-menu";
  static const gameRoute = "/game";
  static const gameModesRoute = "/game-modes";
  static const gameOverRoute = "/game-over";
  static const scoreboardRoute = "/scoreboard";
  static const howToPlayRoute = "/howToPlay";



  static final screens = {
    splashRoute : const SplashScreen(),
    mainMenuRoute : const MainMenuScreen(),
    gameRoute : const GameScreen(),
    gameOverRoute : const GameOverScreen(),
    scoreboardRoute : const ScoreboardScreen(),
    gameModesRoute : const GameModesScreen(),
    howToPlayRoute : const HowToPlayScreen()
  };

  static Widget getScreenFromRoute(String? route) {
    return screens[route] ?? const Scaffold();
  }

  static Route onGenerateRoute (RouteSettings route) {
    return PageTransition(getScreenFromRoute(route.name), setting: route);
  }

}