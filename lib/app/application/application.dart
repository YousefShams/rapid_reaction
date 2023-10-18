import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/resources/app_page_transition.dart';
import 'package:rapid_reaction/app/resources/app_themes.dart';
import 'package:rapid_reaction/app/routes/app_routes.dart';
import 'package:rapid_reaction/presentation/view/splash/splash_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: AppConsts.appTitle,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppThemes.getTheme(),
      onGenerateInitialRoutes: (_)=> [PageTransition(const SplashScreen())],
    );
  }
}
