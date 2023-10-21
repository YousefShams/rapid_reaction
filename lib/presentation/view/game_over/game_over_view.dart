import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rapid_reaction/app/components/app_title.dart';
import 'package:rapid_reaction/app/components/default_button.dart';
import 'package:rapid_reaction/app/extensions/extensions.dart';
import 'package:rapid_reaction/app/resources/app_assets.dart';
import 'package:rapid_reaction/app/resources/app_strings.dart';
import 'package:rapid_reaction/app/resources/app_values.dart';
import 'package:rapid_reaction/app/routes/app_routes.dart';
import 'package:rapid_reaction/domain/entities/reaction_result.dart';
import 'package:rapid_reaction/presentation/view/game_over/components/game_over_empty_result.dart';
import '../../../app/components/info_item.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reactionResult = ModalRoute.of(context)!.settings.arguments as ReactionResult?;
    if(reactionResult!=null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppValues.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(AppAssets.cup, height: context.height*0.25),
                const AppTitle(title: AppStrings.gameOver),
                const Spacer(flex: 1),
                InfoItem(icon: Icons.timer_rounded, title: AppStrings.reactionSpeed,
                    info: AppStrings.getTimeString(reactionResult.reactionSpeed)),
                InfoItem(icon: Icons.star_rounded, title: AppStrings.bestReaction,
                  info: AppStrings.getTimeString(reactionResult.bestReaction),
                  iconColor: Colors.orangeAccent,),
                InfoItem(icon: Icons.trending_down_rounded, title: AppStrings.worstReaction,
                    info: AppStrings.getTimeString(reactionResult.worstReaction),
                    iconColor: Colors.redAccent),
                const Spacer(flex: 2),
                DefaultButton(text: AppStrings.done, onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.mainMenuRoute);})
              ],
            ),
          ),
        ),
      );
    }
    else {
      return const GameOverEmptyResultView();
    }
  }
}
