import 'package:flutter/material.dart';
import 'package:rapid_reaction/app/constants/constants.dart';
import 'package:rapid_reaction/app/routes/app_routes.dart';
import '../../../app/components/rapid_reaction_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, widget) => AnimatedOpacity(
              opacity: value,
              duration: const Duration(seconds: AppConsts.splashTime-1),
              child: widget,
            ),
            child: const RapidReactionWidget(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: AppConsts.splashTime), () {
      Navigator.pushReplacementNamed(context, AppRoutes.mainMenuRoute);
    });
  }
}
